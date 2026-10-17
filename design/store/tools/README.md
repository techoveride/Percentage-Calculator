# Store graphics

Regenerate after UI changes. Needs Python 3 + Pillow and the Poppins font
(OFL, https://fonts.google.com/specimen/Poppins: Bold, SemiBold, Medium .ttf)
in a folder passed as FONT_DIR below.

1. Raw app captures (phone, 7" and 10" tablet) → `design/store/screenshots/raw/`:

       flutter test test/store_screenshots_test.dart --dart-define=SCREENSHOTS=true --dart-define=FONT_DIR=<flutter>/bin/cache/artifacts/material_fonts

2. Framed Play screenshots (9:16, captions) → `design/store/screenshots/{phone,tablet7,tablet10}/`:

       python design/store/tools/compose_screenshots.py . <POPPINS_DIR>

3. Feature graphic (1024x500) → `design/store/feature_graphic_1024x500.png`:

       python design/store/tools/feature_graphic.py . <POPPINS_DIR>
