# photo_editor

Photo Editor App is a mobile application developed in Flutter that allows users to edit images by applying filters and save the edited images to the device's gallery. 

The application includes the following functionalities:

- Image selection: users can choose an image from the gallery or take a picture with the camera.
- Filter application: The application offers various filters, such as Normal, Black & White, Sepia and Invert.
- Image saving: Edited images can be saved to the device's gallery.
- User-friendly interface: The application has an intuitive and easy to use interface.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Settings
#### Prerequisites: 
Before running the application, make sure you have the following installed:

- Flutter SDK: Make sure you have Flutter installed on your machine. You can download it from here.
- Android Studio or Xcode: Depending on whether you want to run the application on Android or iPhone, you will need Android Studio or Xcode.
- Physical device or emulator: You can use a physical device or an emulator to test the application.

#### Dependencies
The application uses the following Flutter dependencies:

- **image_picker**: To select images from the gallery or take pictures with the camera.
- **gallery_saver_plus**: To save images to the device's gallery.
- **path_provider**: To get paths to directories on the device.

These dependencies are configured in the pubspec.yaml file. To install them, run:

    ````bash Copy
    flutter pub get
    ````

## Application Features
#### Welcome screen
- Welcome message: Displays a welcome message and a background image.

    **Buttons:**
    - **Take Picture:** Opens the camera to take a picture.
    - **Choose from Gallery:** Opens the gallery to select an image.

#### Edit Screen
**Available filters:**
- Normal: No filter.
- Black & White: Converts the image to grayscale.
- Sepia: Applies a sepia effect to the image.
- Invert: Invert the image colours.

**Save button:** Saves the edited image to the device gallery.

#### Custom Dialogues
**- Success Dialog:** Displays a success message when the image is saved successfully.

**- Error Dialog:** Displays an error message if a problem occurs while saving the image.

## How to Clone and Use This Project
If you want to use this project on your local machine, follow these steps:

1. Clone the Repository
First, clone the repository from GitHub to your local machine. Open a terminal and run the following command:

    ````bash Copy
    git clone https://github.com/Maggiove13/photo-editor.git 
    ````
2. Navigate to the Project Directory
Once you have cloned the repository, navigate to the project directory:

    ````bash Copy
    cd photo-editor
    ```` 
3. Installing Dependencies
The project uses several Flutter dependencies. To install them, run:

    ````bash Copy
    flutter pub get
    ````   
This command will download and install all necessary dependencies defined in the pubspec.yaml file.

4.  Run the Application
Now that the project is set up, you can run the application on a physical device or on an emulator.

    #### On Android:
    
    1- Connect a physical device:
    
    2- Connect your Android device to your computer via USB.
    
    3- Make sure USB debugging mode is enabled on your device.
    
    4- Run the application:
    
    5- Run the following command in the terminal:
    
    ````bash Copy
    flutter run
    ````
    
    The application will be installed and run on your Android device.

    #### Use an emulator:
    
    1- Open Android Studio and set up an emulator.
    
    2- Run the application with:
    
    ````bash Copy
    flutter run
    ````
    
    #### On iPhone (iOS)
    
    1- Connect a physical device:
    
    2- Connect your iPhone to your Mac via USB.
    
    3- Open Xcode and select your device as the build target.
    
    4- Run the application:
    
    5- Run the following command in the terminal:
    
    ````bash Copy
    flutter run
    ````
    The application will be installed and run on your iPhone.
    
    #### Use a simulator:
    
    1- Open Xcode and set up an iPhone simulator.
    
    2- Run the application with:
    
    ````bash Copy
    flutter run
    ````


