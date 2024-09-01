# Task Management App

A Flutter-based task management application that allows users to add, edit, delete, and view tasks. The app integrates Firebase for authentication and data storage, and includes local notifications to remind users of their tasks.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Features

- User authentication using Firebase
- Add, edit, delete, and view tasks
- Schedule notifications for task reminders
- Persistent storage using Firebase Firestore
- Responsive UI

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed [Flutter](https://flutter.dev/docs/get-started/install)
- You have a [Google Firebase](https://firebase.google.com/) account
- You have set up an Android development environment

## Installation

1. **Clone the repository:**

    ```sh
    git clone https://github.com/yourusername/task-management-app.git
    cd task-management-app
    ```

2. **Install Flutter dependencies:**

    ```sh
    flutter pub get
    ```

3. **Set up Firebase:**

    - Go to the [Firebase Console](https://console.firebase.google.com/).
    - Create a new project.
    - Add an Android app to your Firebase project.
    - Download the `google-services.json` file and place it in the `android/app` directory.
    - Follow the Firebase setup instructions for Android.

4. **Build the app:**

    ```sh
    flutter build apk
    ```

## Usage

1. **Run the app:**

    ```sh
    flutter run
    ```

2. **Sign in:**
    - Use your Firebase credentials to sign in.
    - If you don't have an account, sign up for a new one.

3. **Manage tasks:**
    - Add a new task by clicking the "+" button.
    - Edit a task by tapping on it in the task list.
    - Delete a task by clicking the trash icon.
    - Schedule task notifications to be reminded of your tasks.

## Configuration

### Android Setup

1. **Enable Desugaring:**
    Add the following to your `android/app/build.gradle` file:

    ```gradle
    android {
      defaultConfig {
        multiDexEnabled true
      }

      compileOptions {
        coreLibraryDesugaringEnabled true
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
      }
    }

    dependencies {
      coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:1.2.2'
    }
    ```

2. **Update Gradle Version:**
    Ensure you are using the correct Gradle version in `android/build.gradle`:

    ```gradle
    buildscript {
        dependencies {
            classpath 'com.android.tools.build:gradle:7.3.1'
        }
    }
    ```

3. **Android Manifest Permissions:**
    Add the necessary permissions to `android/app/src/main/AndroidManifest.xml`:

    ```xml
    <manifest xmlns:android="http://schemas.android.com/apk/res/android"
        package="com.yourcompany.taskmanagementapp">
        <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
        <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
        <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
        <application
            ...>
            <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
            <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
                <intent-filter>
                    <action android:name="android.intent.action.BOOT_COMPLETED"/>
                    <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                </intent-filter>
            </receiver>
            ...
        </application>
    </manifest>
    ```

4. **Request Notification Permissions:**
    Ensure your Flutter code checks and requests notification permissions appropriately.

## Dependencies

- [Flutter](https://flutter.dev/)
- [Firebase Authentication](https://pub.dev/packages/firebase_auth)
- [Firebase Firestore](https://pub.dev/packages/cloud_firestore)
- [Flutter Riverpod](https://pub.dev/packages/flutter_riverpod)
- [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [Intl](https://pub.dev/packages/intl)

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

### Acknowledgements

- Thanks to the Flutter and Firebase teams for their awesome tools and services.
