
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

## 📦 Add Your Own Sessions

1. Edit `assets/poses.json` with your custom session:
   - Add segments: intro, loop, outro
   - Define audio file references
   - Define image + script entries with `startSec` and `endSec`

2. Place audio files in `assets/audio/`  
3. Place images in `assets/images/`

---

## 🧩 Sample JSON Snippet (`poses.json`)

```json
{
  "title": "Cat-Cow Session",
  "loopCount": 3,
  "audios": {
    "intro": "intro.mp3",
    "loop": "loop.mp3",
    "outro": "outro.mp3"
  },
  "images": {
    "cat": "cat_pose.png",
    "cow": "cow_pose.png"
  },
  "sequence": [
    {
      "type": "intro",
      "audioRef": "intro",
      "script": [{ "imageRef": "cat", "startSec": 0, "endSec": 5, "text": "Welcome to Cat-Cow!" }]
    },
    {
      "type": "loop",
      "audioRef": "loop",
      "script": [
        { "imageRef": "cat", "startSec": 0, "endSec": 4, "text": "Inhale, arch your back" },
        { "imageRef": "cow", "startSec": 4, "endSec": 8, "text": "Exhale, round your spine" }
      ]
    }
  ]
}
```

## 🧑‍💻 Built With

- Flutter
- Dart
- audioplayers package
- JSON-based configuration

## 📄 License

MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙌 Credits

Built as part of the RevoltronX Team X internship program.

---

## 📬 Contact

For feedback or collaboration:

**Your Name** – [your.email@example.com](mailto:your.email@example.com)  
GitHub: [@yourusername](https://github.com/yourusername)
