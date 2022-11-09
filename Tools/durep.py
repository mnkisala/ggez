#!/usr/bin/python3

# Disk usage report utilty
# usage: python3 durep.py > raport.html

import os
from functools import reduce
import json

template = """
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {{ 
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                width: 100vw;
                margin: 0;
                flex-direction: column;
                padding: 0;
            }}

            #out {{
                width: 80vw;
                height: 100px;
                display: flex;

                background-color: #eee;
                padding: 10px;

                border-radius: 20px;
            }}

            .block {{
                background-color: black;
                height: 100px;
                margin: 1px;

                border-radius: 4px;

                overflow: clip;

                color: white;

                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;

                cursor: pointer;
            }}

            .block:hover {{
                opacity: 0.9;
            }}
        </style>
    </head>
    <body>
        <h1> file sizes </h1>
        <div id="out"></div>

        <script>
            const data = {0}

            const out = document.getElementById("out")

            output =  ""

            function toHumanReadable(bytes) {{
                const units = ["B", "KiB", "MiB", "GiB", "TiB", "PiB", "YiB"]
                let out = bytes
                let idx = 0
                while (out > 1024) {{
                    out /= 1024
                    idx++
                }}
                return `${{Math.round(out * 1000) / 1000}} ${{units[idx]}}`
            }}

            for (el of data) {{
                const path = el[0]
                const size = el[1]
                const perc = el[2] * 100.0

                const red = Math.min(255 * ((perc * perc) / 100.0), 255);

                output += `<div class="block" style="width: ${{Math.min(100, perc)}}%; ${{(perc < 1) ? `display: none` : ``}}; background-color: rgb(${{Math.round(red)}}, 96, 96);" title="${{path}} ${{toHumanReadable(size)}}"> 
                    ${{ (perc > 10) ? `<div>${{path}}</div>
                        <div>${{toHumanReadable(size)}}</div>
                        <div>${{Math.round(perc)}} %</div>
                    ` : ``}}
                </div>`
            }}

            out.innerHTML = output
        </script>
    </body>
</html>
"""

def get_files(root):
    children = os.listdir(root)
    all_files = []
    for entry in children:
        full_path = os.path.join(root, entry)
        if os.path.isdir(full_path):
            all_files += get_files(full_path)
        else:
            all_files.append(full_path)
    return all_files

files_with_sizes = map(lambda f: (f, os.stat(f).st_size), get_files("."))

files_sorted = list(files_with_sizes)
files_sorted.sort(key=lambda s: s[1])

total = reduce(lambda a, b: a + b, map(lambda t: t[1], files_sorted), 0)

files_with_percentage = list(map(lambda t: (t[0], t[1], t[1] / total), files_sorted))

'''
for (path, size) in files_sorted:
    print(path, size, size / total)
print("total: ", total)
'''

print(template.format(json.dumps(files_with_percentage)))
