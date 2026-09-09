# Devanagari font loading

The game contains all gameplay logic and UI code without any remote font
dependency. For the cleanest Hindi rendering in exported APKs, place a legally
redistributable Devanagari font in this folder before exporting:

1. Download **Noto Sans Devanagari Regular** from the official Google Fonts
   repository: <https://github.com/google/fonts/tree/main/ofl/notosansdevanagari>.
2. Copy the file into this folder as `NotoSansDevanagari-Regular.ttf`.
3. The script already checks
   `res://fonts/NotoSansDevanagari-Regular.ttf` when it starts, so no code
   change is needed.
4. Re-import the project in Godot and export the APK.

Noto Sans Devanagari is licensed under the SIL Open Font License. If the font
is not present, the game still runs and uses Godot/Android font fallback.
The Hindi strings remain in the source so a font can be added without any
code changes.