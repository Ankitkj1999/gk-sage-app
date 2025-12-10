# GK Sage: Flutter Complete Quiz App for Android & iOS with Web Admin panel
![GK Sage Demo GIF](assets/gksage-gif.gif)

## Overview
GK Sage is a comprehensive, cross-platform quiz application built with Flutter, designed for seamless performance on both Android and iOS devices. It includes a user-friendly web-based admin panel for effortless content management. Whether you're creating engaging general knowledge quizzes or specialized trivia challenges, GK Sage provides an end-to-end solution for educators, businesses, or hobbyists to deliver interactive learning experiences.

Powered primarily by Dart (with supporting languages like C++, Swift, and HTML), this app leverages Flutter's hot reload and native performance to ensure a smooth, responsive interface. The web admin panel allows administrators to upload questions, manage categories, track user progress, and analyze quiz statistics—all from a intuitive dashboard.

## Key Features
- **Cross-Platform Compatibility**: Native-like experience on Android, iOS, and web via a single Flutter codebase.
- **Rich Quiz Engine**: Support for multiple-choice, true/false, and timed quizzes with instant scoring and explanations.
- **User Engagement Tools**: Progress tracking, leaderboards, daily challenges, and customizable themes to keep users motivated.
- **Admin Web Panel**: Built-in dashboard for adding/editing questions, user management, and real-time analytics (e.g., completion rates, popular categories).
- **Offline Support**: Download quizzes for offline play, with sync upon reconnection.
- **Multimedia Integration**: Embed images, audio, and videos in questions for immersive content.
- **Secure Authentication**: Firebase-based user login with social media integration (Google, Facebook).
- **Performance Optimized**: Lightweight design ensuring fast load times, even on low-end devices.

## Tech Stack
- **Frontend**: Flutter (Dart) for mobile apps; HTML/CSS/JS for web admin enhancements.
- **Backend**: Firebase for authentication, Firestore for data storage, and Cloud Functions for serverless logic.
- **State Management**: Provider or Riverpod for efficient UI updates.
- **Other Tools**: SQLite for local caching, Dio for HTTP requests, and shared_preferences for settings.

## Getting Started
### Prerequisites
- Flutter SDK (version 3.0+)
- Dart SDK
- Firebase project setup (for auth and database)
- Node.js (for web admin if extending with custom scripts)

### Installation
1. **Clone the Repository**:
   ```
   git clone https://github.com/Ankitkj1999/gk-sage-app.git
   cd gk-sage-app
   ```

2. **Flutter Setup**:
   - Run `flutter pub get` to install dependencies.
   - Ensure Flutter is configured: `flutter doctor`.

3. **Firebase Configuration**:
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com).
   - Add Android/iOS apps to the project and download `google-services.json` (Android) / `GoogleService-Info.plist` (iOS).
   - Place files in respective directories (`android/app/` and `ios/Runner/`).
   - Enable Firestore, Authentication, and Storage in Firebase console.

4. **Run the App**:
   - For Android/iOS: `flutter run`
   - For Web Admin: Navigate to `/web_admin` folder, run `flutter run -d chrome`

### Building for Release
- Android: `flutter build apk --release`
- iOS: `flutter build ios --release` (requires Xcode on macOS)
- Web: `flutter build web`

## Usage
### As a User
- Download the app from app stores (once published).
- Sign up/login, browse categories, and start quizzing!
- View personalized stats in the profile section.

### As an Admin
- Access the web panel via the deployed URL (e.g., Firebase Hosting).
- Navigate to "Add Quiz" to upload questions in JSON format or via UI forms.
- Monitor analytics under "Dashboard" for insights.

## Project Structure
```
gk-sage-app/
├── lib/
│   ├── models/          # Data models (Question, User, Quiz)
│   ├── screens/         # UI screens (Home, Quiz, Profile, Admin)
│   ├── services/        # Firebase, API, and local storage services
│   ├── widgets/         # Reusable UI components
│   └── main.dart        # App entry point
├── web_admin/           # Web-specific admin panel code
├── assets/              # Images, GIFs, and demo content
├── pubspec.yaml         # Dependencies
└── README.md            # This file
```

## Contributing
We welcome contributions! Fork the repo, create a feature branch (`git checkout -b feature/AmazingFeature`), make your changes, and submit a pull request. Ensure code follows Dart style guidelines and includes tests.

1. Fork the project.
2. Create your feature branch.
3. Commit changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Contact
- Report issues: [GitHub Issues](https://github.com/Ankitkj1999/gk-sage-app/issues)
- Email: [your-email@example.com](mailto:your-email@example.com)
- Follow updates on X (Twitter): [@Ankitkj1999](https://x.com/Ankitkj1999)

## Roadmap
- v2.0: AI-generated questions integration.
- v2.1: Multi-language support.
- v3.0: AR/VR quiz modes.

Thank you for choosing GK Sage—empowering knowledge, one quiz at a time! 🚀
