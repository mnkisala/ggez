use std::io::Cursor;

use clap::Parser;
use gltf::json::image::MimeType;
use image::{imageops::FilterType, EncodableLayout};

/// The most powerful tool for optimizing game assets in the Tri-State Area!
#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// path to the file
    #[arg(short, long)]
    input: String,

    /// where to output the damn thing
    #[arg(short, long)]
    output: String,

    /// limits how big textures can be
    #[arg(short, long)]
    max_texture_dimensions: u32,

    /// limits how big textures can be
    #[arg(short, long)]
    texture_quality: u32,
}

fn gltf_image_to_image_image(data: &gltf::image::Data) -> image::DynamicImage {
    match data.format {
        gltf::image::Format::R8 => image::DynamicImage::ImageLuma8(
            image::GrayImage::from_raw(data.width, data.height, data.pixels.clone()).unwrap(),
        ),
        gltf::image::Format::R8G8 => image::DynamicImage::ImageLumaA8(
            image::GrayAlphaImage::from_raw(data.width, data.height, data.pixels.clone()).unwrap(),
        ),
        gltf::image::Format::R8G8B8 => image::DynamicImage::ImageRgb8(
            image::RgbImage::from_raw(data.width, data.height, data.pixels.clone()).unwrap(),
        ),
        gltf::image::Format::R8G8B8A8 => image::DynamicImage::ImageRgba8(
            image::RgbaImage::from_raw(data.width, data.height, data.pixels.clone()).unwrap(),
        ),
        gltf::image::Format::R16G16B16 => image::DynamicImage::ImageRgb8(
            image::DynamicImage::ImageRgb16(
                image::ImageBuffer::<image::Rgb<u16>, Vec<u16>>::from_raw(
                    data.width,
                    data.height,
                    unsafe {
                        std::slice::from_raw_parts(
                            data.pixels.as_ptr() as *const u16,
                            (data.width * data.height * 3) as usize,
                        )
                    }
                    .to_owned(),
                )
                .unwrap(),
            )
            .to_rgb8(),
        ),
        gltf::image::Format::R16G16B16A16 => image::DynamicImage::ImageRgba8(
            image::DynamicImage::ImageRgba16(
                image::ImageBuffer::<image::Rgba<u16>, Vec<u16>>::from_raw(
                    data.width,
                    data.height,
                    unsafe {
                        std::slice::from_raw_parts(
                            data.pixels.as_ptr() as *const u16,
                            (data.width * data.height * 4) as usize,
                        )
                    }
                    .to_owned(),
                )
                .unwrap(),
            )
            .to_rgba8(),
        ),

        _ => panic!("input image format not implemented! {:?}", data.format),
    }
}

fn main() {
    let args = Args::parse();

    println!("SMOLINATOR: optimizing {}", args.input);

    let (document, buffers, image_data) = gltf::import(args.input).unwrap();

    let images = document
        .images()
        .zip(&image_data)
        .map(|(image_view, image_data)| {
            let image = gltf_image_to_image_image(image_data);

            let image = image.resize(
                args.max_texture_dimensions,
                args.max_texture_dimensions,
                FilterType::Gaussian,
            );

            let mut buf = Vec::new();
            let mut cursor = Cursor::new(&mut buf);
            image
                .write_to(
                    &mut cursor,
                    image::ImageOutputFormat::Jpeg(args.texture_quality as u8),
                )
                .unwrap();

            let bv = match image_view.source() {
                gltf::image::Source::View { view, .. } => Some(view),
                gltf::image::Source::Uri { .. } => None,
            };

            (
                gltf::json::Image {
                    buffer_view: None,
                    uri: Some(format!("data:image/jpeg;base64,{}", base64::encode(&buf))),
                    mime_type: Some(MimeType("image/jpeg".into())),
                    name: image_view.name().map(|s| s.into()),
                    extensions: None,
                    extras: image_view.extras().clone(),
                },
                bv,
            )
        });

    /* Right now it doesn't really matter that smolinator itself doesnt strip
    binary data, but it would be cool to implement at some point
        let excluded_views: Vec<usize> = images
            .clone()
            .filter_map(|p| p.1.map(|p| p.index()))
            .collect();

        let views: Vec<gltf::buffer::View> = document
            .views()
            .filter(|v| !excluded_views.contains(&v.index()))
            .collect();
    */

    let mut giga_buffer: Vec<u8> = Vec::new();
    let mut views_json: Vec<gltf::json::buffer::View> = Vec::new();
    for view in document.views() {
        let start = giga_buffer.len();
        let buf = &buffers[view.buffer().index()].0;
        giga_buffer.extend_from_slice(&buf[view.offset()..(view.offset() + view.length())]);
        let end = giga_buffer.len();
        let len = end - start;

        views_json.push(gltf::json::buffer::View {
            buffer: gltf::json::Index::new(0),
            byte_length: len as u32,
            byte_offset: Some(start as u32),
            byte_stride: None,
            name: None,
            target: None,
            extensions: None,
            extras: gltf::json::extras::Void::default(),
        });
    }

    let giga_buffer_json = gltf::json::Buffer {
        byte_length: giga_buffer.len() as u32,
        name: None,
        uri: Some(format!(
            "data:application/octet-stream;base64,{}",
            base64::encode(&giga_buffer)
        )),
        extensions: None,
        extras: gltf::json::extras::Void::default(),
    };

    let mut root = document.clone().into_json();
    root.buffers = vec![giga_buffer_json];
    root.images = images.map(|p| p.0).collect();
    root.buffer_views = views_json;

    let mut out = std::fs::File::create(args.output).unwrap();
    root.to_writer_pretty(&mut out).unwrap();
}
