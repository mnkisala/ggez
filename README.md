ggez
====

gra godot ekologia zielen

pozdro

Struktura folderów
------------------

| Folder        | Funkcja                                                                         |
|---------------|---------------------------------------------------------------------------------|
| Models        | Worek na wszystko co eksportuje blender, każdy asset                            |
|               | wypadałoby przerobić na customową scene w folderze `Scenes/Models`              |
| Scenes        | Wszystkie sceny                                                                 |
| Scenes/Models | Sceny z zaadaptowanych modeli z Models                                          |
| Scenes/Levels | Poziomy                                                                         |
| Fonts         | Czcionki                                                                        |
| Scripts       | Skrypty (Nazwa folderu - "Scripts" oznacza "Skrypty" ale po angielsku,          |
|               | jest to nawiązanie do faktu że folder ten ma służyć do przechowywania skryptów) |

Poziomy:
--------

-	**Parkour** : skakanie
-	**Fps** : Strzelanie (Mikołaj rób co chesz)
-	**Pytania wybierz z 2** : Zbiór pytań, wybierz z 2 wraz z zapadnią (Masz 10 sekund na wybranie swojej odpowiedzi stając na odpowiednie pole. Po tym czasie zapada się pole ze złą odp , jeśli gracz tam stał to spada i po chwili "umiera" i tak do "5" pytań na wszystkie musi odp dobrze żeby przejść poziom)
-	**Labirint** : Pytanie wraz z 3 odpowiedziamy po wyborze złego otwierają siędrzwi po których droga prowadzi do przycisku, który wywala nas na start. Natomiast dobra odp otwieraz ścieżkę, która umożliwia przejście labiryntu. Pytania się resetują dopiero gdy na wszystkich ścieżkach wyboru źle wybierzemy.
-	**Zbieractwo** : Odblowkowuje się dopiero gdy przejdziemy wszystkie poziomy. Wyrzucamy tu śmieci do odpowiednich śmietników.

-	**Mechaniki ogólne**: Zbieranie śmieci(Podnoszenie śmieci, animacja zbierania papieru), Rzucanie(thrownig do śmietników, jeśli śmieć nie zgadza to go odrzuca i trzeba podnieść jeszcze raz), otwieranie drzwi(labirynt), ogólne wyświetlanie ekwipunku oraz punktów.
