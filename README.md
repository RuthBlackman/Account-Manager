# Final Year Project - Account Manager
## Setup Instructions
### Setup Flutter
- [Follow this link to set up Flutter](https://docs.flutter.dev/get-started/install)
- Select your Operating System
- Scroll down to 'Install the Flutter SDK'
- Follow the instructions to 'download and install Flutter' and then 'add Flutter to PATH'
- In the terminal, run ```flutter doctor``` 
  - This will check if you have the Dart SDK and install it if you don't
  - It will then display a summary of which tools you have (don't worry if only Flutter is ticked)

### Setup Android Studio
- [Follow this link to download Android Studio](https://developer.android.com/studio)

#### Setup Android SDK
- Go to the Android SDK settings within Android Studio 
  - Settings -> Languages & Frameworks -> Android SDK
- Select SDK tools and install the following tools:
  - Android SDK Build_Tools 35_rc3 
    - 34.0.0
  - Android SDK Command_Line Tools
  - Android Emulator
  - Android SDK Platform_Tools

#### Setup Emulator
- [Follow this link to setup an Android Virtual Device (AVD)](https://developer.android.com/studio/run/managing-avds)

### Run the project
Run ```flutter doctor``` in the terminal to ensure that that Flutter, Android toolchain, and Android Studio are setup.

[//]: # (![image info]&#40;./assets/flutter_doctor.png&#41;)

Now all the tools should be ready.

- Clone this repository
- Open the project within Android Studio
- Run ```flutter pub get``` to ensure that all dependencies are installed
- Open the device manager and start the virtual device
- Run main.dart, which will open up the terminal to inform you of the build progress and automatically open the application on the device

## Code Structure
Important folders and their uses:
- **assets:** contains images to be used within the project
- **lib:** contains all the dart files for the frontend and the backend
- **test:** contains dart files that run Flutter widget tests 

The dart_tool folder contains files used by the Dart tools, and the build folder contains the files needed to run the
application on different platforms, such as iOS and Android.
There are also folders called android and ios, which are also needed to create a working application for these platforms.

Two important files that are placed in the project directory, not inside any other folders, are pubspec.lock and pubspec.yaml.
- **Pubspec.lock** simply contains all the packages that the application needs and the version of each package.
- **Pubspec.yaml** is the file that the developer can edit to add or remove dependencies, such as Isar for this project.

When the developer edits pubspec.yaml, it is crucial that they then execute this command to get the new packages:
```
flutter pub get
```

### Frontend
Within the lib folder, there are many folders that separate the code for the frontend, which are:
- **components:** Contains dart files that define custom widgets, which are likely to be reused
across several files.
- **helpers:** Contains dart files with functions that are likely to be reused.
- **pages:** Contains all the dart files which display the screens for the application.

There are also a couple of files which do not live in these named folders, but only within the lib
folder. The first file is **colours.dart**. This file stores the colours that are regularly used within
the codebase. By storing colours within this file, they can be used from anywhere in the project,
meaning that it is easy to reuse colours across multiple different screens. The second file, which
is the most important file, is **main.dart**. This file is the entry point to the application - it is the
first file of code that gets executed when the application is run.

To run a Flutter application in Android Studio, one needs to select the target device (which
can be either an emulator or a physical device), select the configuration (which is main.dart by
default) and then click the run icon. This will build the application and then display it on the
chosen device.

### Backend
Isar is used as the database solution for this project, and the correct packages can be installed using:
```
flutter pub add isar isar_flutter_libs path_provider
flutter pub add −d isar_generator build_runner
```

Isar requires a collection class to be created, which defines the data types that the model needs.

More information about how Isar has been used is in the report.
