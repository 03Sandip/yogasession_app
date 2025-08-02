
# 🧘‍♂️ Flutter Yoga Session Player App

A modular yoga session player built using Flutter. This app guides users through yoga poses (like Cat-Cow) by syncing audio instructions, images, and scripted text from a JSON configuration.

## 🚀 Features

- 🎵 Plays synchronized audio instructions
- 🖼️ Displays images for each pose or instruction step
- 📜 Shows real-time guided script text
- 🔁 Supports looping segments (e.g., for repeated poses)
- ⏯️ Full play/pause/resume control
- ✅ Modular JSON structure for adding custom yoga sessions

## 📂 File Structure

```
lib/
├── main.dart
├── screens/
│   └── home_page.dart
│   └── session_player.dart
├── models/
│   ├── yoga_session.dart
│   ├── yoga_segment.dart
│   └── script_entry.dart
├── services/
│   └── session_loader.dart
assets/
├── poses.json
├── audio/
│   └── *.mp3
├── images/
│   └── *.png
```

## 🛠️ Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/yourusername/flutter-yoga-app.git
cd flutter-yoga-app
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Run on emulator or device
```bash
flutter run
```

### 4. Build release APK
```bash
flutter build apk --release
```
