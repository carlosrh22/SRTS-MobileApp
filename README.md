# MyApp

**MyApp** is an application developed in **Flutter** to complement a project related to physical rehabilitation. It allows users to consult personalized daily exercise plans, monitor patient progress, and receive automatic alerts for correcting incorrect movements.

---

## **Table of Contents**

1. [Project Description](#project-description)
2. [Key Features](#key-features)
3. [Prerequisites](#prerequisites)
4. [Installation and Execution](#installation-and-execution)
5. [Emulator Configuration](#emulator-configuration)
6. [Project Structure](#project-structure)
7. [Modifications Made](#modifications-made)
8. [Contributors and Copyright](#contributors-and-copyright)
9. [License](#license)

---

## **Project Description**

**MyApp** is designed for patients undergoing rehabilitation and physiotherapy. The application includes:
- Personalized daily exercise plans.
- Automatic alerts for correcting incorrect movements using simulated sensors.
- Progress charts (weight, mobility, and strength) with cloud access for more detailed analysis.
- A chat feature for direct communication with physiotherapists or doctors.
- A user profile (login, logout) that displays the name, age, and rehabilitation type of the patient.
- **WiFi** connection to upload sensor data to the cloud and **Bluetooth** connection to link with the smart shirt carrying the sensors.

---

## **Key Features**

- **Exercise Plan**: Generates and details exercise routines with links to instructional videos.
- **Automatic Movement Correction**: Simulates sensor functionality in the garment to adjust posture.
- **Progress Charts**: Visualizes weekly progress for weight, mobility, and strength.
- **Detailed Analysis**: Opens detailed analytics in Power BI via external links (requires Firefox).
- **Real-Time Chat**: Facilitates communication with a physiotherapist or doctor.
- **User Profile**: Accessible via **login** (username: *juan.perez*, password: *1234*) or demo mode without login.
- **Bluetooth Connection**: Allows verification of the connection status with the smart shirt.
- **WiFi Connectivity**: Uploads sensor data to the cloud for detailed tracking.

---

## **Prerequisites**

Ensure the following components are installed:

1. **Flutter SDK** (minimum version `3.x.x`): [Download Flutter](https://docs.flutter.dev/get-started/install)
2. **Dart SDK** (included with Flutter).
3. **Code Editor** (Visual Studio Code or Android Studio).
4. Properly configured **Android Emulator**.

---

## **Installation and Execution**

1. **Clone the repository**:
   ```bash
   git clone https://github.com/usuario/myapp.git
   cd myapp
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the application on an emulator or device**:
   ```bash
   flutter run
   ```

---

## **Emulator Configuration**

To open links correctly in **Firefox**, execute the following script in the terminal:

```bash
./install_firefox.sh
```

This script installs the **Firefox** browser on the emulator, enabling access to external links such as **Power BI**.

---

## **Project Structure**

The project structure matches the current files and is as follows:

```plaintext
myapp/
|── .dart_tool/                # Dart tools and cache
|── .idea/                     # IDE configuration (IntelliJ/Android Studio)
|── .idx/                      # Internal Project IDX data
|── android/                   # Android-specific files
|── build/                     # Generated files during compilation
|── lib/                       # Main source code
|   |── models/                # Data classes and models
|   |   └── progress_models.dart
|   |── screens/               # Application screens
|   |   ├── chat_screen.dart
|   |   ├── exercise_plan_details_screen.dart
|   |   ├── home_screen.dart
|   |   ├── login_screen.dart
|   |   ├── patient_progress_screen.dart
|   |   └── profile_details_screen.dart
|   └── main.dart              # Application entry point
|── test/                      # Unit tests
|── web/                       # Web version configuration
|── .flutter-plugins           # Flutter plugin data
|── .flutter-plugins-dependencies
|── .gitignore                 # Files and folders ignored by Git
|── .metadata                  # Flutter project metadata
|── analysis_options.yaml      # Code analysis configuration
|── firefox-base.apk           # Firefox base APK
|── firefox-split-x86_64.apk   # APK for x86_64 architecture
|── firefox-split-xxhdpi.apk   # APK for xxhdpi devices
|── install_firefox.sh         # Firefox installation script
|── myapp.iml                  # IntelliJ project configuration file
|── pubspec.lock               # Locked versions of dependencies
|── pubspec.yaml               # Project dependencies and configuration
└── README.md                  # Project documentation
```

---

## **Modifications Made**

### 1. Internet Permissions in AndroidManifest.xml

The following permission was added in **AndroidManifest.xml** to allow internet access on the emulator:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### 2. Firefox Installation Script

The **`install_firefox.sh`** script was created to install **Firefox** on the emulator and ensure proper link handling.

---

## **Contributors and Copyright**

This application was developed as part of the course **"Projects in Data Engineering and Systems"** at the **Polytechnic University of Madrid**:

- **Carlos Rubio Hernán**
- **Miguel Ángel Arias González**
- **Diego Fernández Gómez**
- **Sonia Menéndez Menéndez**

For any questions or inquiries, please contact us at:

📧 **srtsdemo@gmail.com**

All rights reserved to the respective authors and the Polytechnic University of Madrid.

---

## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

**Thank you for using MyApp!** 🌟