# Build Instructions — Pati Patni Ki Ladai

This is a complete Godot 4.x project configured for a portrait Android APK.
The game is offline at runtime: it contains its gameplay data, UI, cartoon
characters, local saves, and synthesized placeholder sound effects in the
project itself.

## 1. Required software

- Godot Engine **4.3 or newer 4.x stable**.
- Android Studio (latest stable) or the Android SDK command-line tools.
- Android SDK Platform 34 or newer.
- Android SDK Build-Tools 34 or newer.
- Android SDK Command-line Tools.
- OpenJDK 17.

Godot's Android export templates are also required. In Godot, open
**Editor > Manage Export Templates > Download and Install**.

## 2. Open the project

1. Start Godot.
2. Click **Import**.
3. Select this folder (the folder containing `project.godot`).
4. Click **Import & Edit**.
5. Press **Play Project** to run the game in the editor.

The project is already set to a 540 × 960 portrait viewport and uses
canvas-item scaling so it fits normal Android phone screens.

## 3. Configure the Android SDK in Godot

1. Open **Editor > Editor Settings**.
2. Search for **Android**.
3. Under **Export > Android**, set:
   - **Android SDK Path** to your Android SDK folder.
   - **Jarsigner** / Java path to your OpenJDK 17 installation if Godot does
     not detect it automatically.
4. In Android Studio's SDK Manager, make sure these are installed:
   - Android SDK Platform 34
   - Android SDK Build-Tools 34.x
   - Android SDK Command-line Tools
   - Android SDK Platform-Tools

For a Hindi font with consistent rendering, optionally follow
`fonts/README.md` and add the SIL OFL-licensed Noto Sans Devanagari font before
exporting. Android fallback fonts are supported when that file is not present.

## 4. Create an Android export preset

1. Open **Project > Export**.
2. Click **Add... > Android**.
3. Set the preset name to `Android Debug`.
4. Confirm the package name, for example:
   `com.example.patipatnikiladai`
5. Keep the orientation portrait. The project configuration already requests
   portrait orientation.
6. For a local debug build, no release keystore is needed.
7. Save the preset in `export_presets.cfg` when Godot asks.

## 5. Build a debug APK

### From the Godot editor

1. Open **Project > Export**.
2. Select **Android Debug**.
3. Click **Export Project**.
4. Save it as `build/pati-patni-ki-ladai-debug.apk`.

### From the command line

Run this from the project folder:

```bash
mkdir -p build
godot --headless --path . --export-debug "Android Debug" build/pati-patni-ki-ladai-debug.apk
```

If your executable is named `godot4`, use:

```bash
godot4 --headless --path . --export-debug "Android Debug" build/pati-patni-ki-ladai-debug.apk
```

The exact export preset name must match the name shown in Godot's Export
window.

## 6. APK location

After a successful export, the debug APK is located at:

```text
build/pati-patni-ki-ladai-debug.apk
```

## 7. Install the APK on an Android phone

### USB / ADB

1. Enable **Developer options** and **USB debugging** on the phone.
2. Connect the phone by USB and accept the debugging prompt.
3. Run:

```bash
adb install -r build/pati-patni-ki-ladai-debug.apk
```

### Direct file install

Copy the APK to the phone, open it, and allow installation from that file
manager if Android asks. A debug APK is suitable for local testing.

## Optional release APK configuration

For a distributable release APK:

1. Create a long-lived upload keystore, for example:

```bash
keytool -genkeypair -v -keystore pati-patni-release.keystore \
  -alias pati_patni -keyalg RSA -keysize 2048 -validity 10000
```

2. In **Project > Export > Android**, add a **Release** preset.
3. Enter the keystore path, alias, and passwords in the export preset.
4. Do not commit the keystore or passwords to source control.
5. Export with:

```bash
godot --headless --path . --export-release "Android Release" build/pati-patni-ki-ladai-release.apk
```

For Google Play, export an Android App Bundle (`.aab`) and use the Play App
Signing flow rather than distributing the debug APK.

## Verification checklist

- `project.godot` points to `main.tscn`.
- `main.tscn` points to `main.gd`.
- `main.gd` loads `character_art.gd`.
- The game contains all 10 levels and all requested screens.
- Progress and settings use `user://` local storage.
- No runtime network calls or remote assets are required.
- Portrait orientation and Android export settings are in `project.godot`.