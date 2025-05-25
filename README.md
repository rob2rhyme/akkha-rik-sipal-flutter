	•	Project summary
	•	Features
	•	Folder structure
	•	Setup instructions
	•	Web deployment steps
	•	Notes for web compatibility

⸻

📄 README.mdx

import { CodeBlock } from '@theme/CodeBlock';

# 🧠 Akkha Rik Lipi Sipal

An educational **Flutter app** to teach **Akkha Rik Lipi** — a custom script and language experience tailored for children. The app includes visual, interactive modules like alphabets, counting, spelling, comparison, and coloring — with sound and animated feedback.

---

## 🚀 Features

- 🔤 Learn alphabets with interactive coloring
- ➕➖ Addition and subtraction with drag-drop answers
- 🎨 Paint screen with fillable strokes
- 🔊 Text-to-speech powered guidance
- 🎞️ Animated success dialogs
- 🌐 Web-compatible (Flutter web) via Vercel

---

## 📁 Project Structure

<CodeBlock language="txt">
lib/
├── main.dart
├── routes/
│   └── app_pages.dart
├── ui/
│   ├── alphabets/
│   ├── add_subtract/
│   ├── compare/
│   ├── paint/
│   ├── settings/
│   └── ...
├── dialog/
│   └── complete_dialog/
├── database/
├── utils/
├── assets/
</CodeBlock>

---

## 🧑‍💻 Getting Started

### 1. 📦 Install Flutter dependencies
```bash
flutter pub get

2. ▶️ Run the App (Android/iOS)

flutter run


⸻

🌍 Web Deployment (Vercel)

Build for web

flutter build web --base-href=/

Add vercel.json (in project root)

{
  "outputDirectory": "build/web",
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}

Deploy from terminal

vercel --prod build/web


⸻

🌐 Web Compatibility Notes

To avoid runtime crashes on Flutter Web:
	•	✅ Wrap all Platform.isX calls with !kIsWeb check
	•	✅ Use import 'dart:io' show Platform; guarded with kIsWeb
	•	✅ Avoid any direct dart:io operations unless using conditional imports

⸻

📄 License

This project is copyright © 2025.

⸻

Built with ❤️ using Flutter for educational impact.

---

Would you like this exported as a file or want a version ready for GitHub Pages / Docusaurus?
