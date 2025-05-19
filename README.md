# 🎵 Flutter Media Player

A modern Flutter application for playing music with advanced queue and album management.

---

## ✨ Features

- 🎧 **Album Playback** – Browse albums and play all songs from an album.
- 📜 **Queue Management** – View and manage the current playback queue, including _Now Playing_ and _Next from Queue_.
- 🔀 **Shuffle & Loop Modes** – Supports shuffle play and repeat/loop modes for flexible listening.
- 🎮 **Media Controls** – Control playback (play, pause, skip, seek) from within the app and via Android/iOS notification controls.
- 📱 **Audio Session Handling** – Properly manages audio focus and background playback using platform audio sessions.
- 🧠 **State Management** – Uses Riverpod for robust and scalable state management.
- 🧩 **Dependency Injection** – Clean architecture with GetIt and Injectable for dependency management.

---

## 📦 Packages Used

| Package                                                         | Description                                         |
| --------------------------------------------------------------- | --------------------------------------------------- |
| [`just_audio`](https://pub.dev/packages/just_audio)             | 🎵 Audio playback engine                            |
| [`audio_service`](https://pub.dev/packages/audio_service)       | 🔊 Background audio, media controls & notifications |
| [`audio_session`](https://pub.dev/packages/audio_session)       | 🎚️ Audio focus & session handling                   |
| [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) | 🧠 State management                                 |
| [`get_it`](https://pub.dev/packages/get_it)                     | 💉 Dependency injection                             |
| [`injectable`](https://pub.dev/packages/injectable)             | ⚙️ Dependency code generation                       |
| [`equatable`](https://pub.dev/packages/equatable)               | 🟰 Simplified value equality for state classes       |

---

## 🗂️ Project Structure

```plaintext
lib/
├── core/
│   └── audio_player_handler.dart     # 🎧 Core audio logic using just_audio & audio_service
├── features/
│   └── app/      # 🎨 UI for audio player buttons (e.g. play/pause), seeker, etc
│   └── music/      # 🎨 UI for albums, songs, and playback queue
├── injectors/
├── app_initializer.dart
└── main.dart
```
