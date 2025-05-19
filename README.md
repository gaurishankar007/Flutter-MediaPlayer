# Flutter Media Player

A modern Flutter application for playing music with advanced queue and album management.

## Features

- **Album Playback**: Browse albums and play all songs from an album.
- **Queue Management**: View and manage the current playback queue, including "Now Playing" and "Next from Queue".
- **Shuffle & Loop Modes**: Supports shuffle play and repeat/loop modes for flexible listening.
- **Media Controls**: Control playback (play, pause, skip, seek) from within the app and via Android/iOS notification controls.
- **Audio Session Handling**: Properly manages audio focus and background playback using platform audio sessions.
- **State Management**: Uses Riverpod for robust and scalable state management.
- **Dependency Injection**: Clean architecture with GetIt and Injectable for dependency management.

## Packages Used

- [`just_audio`](https://pub.dev/packages/just_audio): Audio playback.
- [`audio_service`](https://pub.dev/packages/audio_service): Background audio, media controls, and notification integration.
- [`audio_session`](https://pub.dev/packages/audio_session): Audio session management for proper focus and mixing.
- [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod): State management.
- [`get_it`](https://pub.dev/packages/get_it): Dependency injection.
- [`injectable`](https://pub.dev/packages/injectable): Code generation for dependency injection.
- [`equatable`](https://pub.dev/packages/equatable): Value equality for state

## Project Structure

- `lib/features/music/views/`: UI for music, albums, and queue.
- `lib/app/notifiers/`: Riverpod notifiers for audio and queue state.
- `lib/core/audio_player_handler.dart`: Core audio logic and integration with just_audio and audio_service.
