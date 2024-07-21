# home_controller

### Mini Home Automation App

Welcome to the Mini Home Automation App! This project is designed to provide users with a seamless and intuitive interface for controlling and monitoring home devices. Below you'll find detailed documentation to help you set up, understand, and contribute to this project.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Screenshots](#screenshots)
4. [Setup Instructions](#setup-instructions)
5. [Assumptions and Decisions](#assumptions-and-decisions)


---

### Project Overview

The Mini Home Automation App is a mobile application built with Flutter, aimed at offering users an efficient way to manage and monitor home devices. It features a clean and user-friendly interface with two main screens:

- **Dashboard Screen**: Provides control switches for home devices and displays real-time consumption data.
- **Settings Screen**: Allows users to customize the app’s appearance, manage notifications, and update their profile.

### Features

#### Dashboard Screen
- **Device Control Switches**: Users can control devices such as lights and fans using intuitive toggle switches.
- **Real-Time Data Display**: The app shows real-time data for utilities like water and gas consumption, helping users monitor their resource usage.

#### Settings Screen
- **Theme Customization**: Users can switch between different themes to personalize the app’s appearance.
- **Notification Settings**: Manage preferences for receiving notifications related to device status and updates.
- **Profile Modifications**: Update user profile information including personal details and preferences.

### Screenshots

https://github.com/user-attachments/assets/d6b40453-8542-43b2-8570-05f497e4a6c9

#### Dashboard Screen

![hc1](https://github.com/user-attachments/assets/b5f4c8c9-36d7-4481-8e95-966ef76850fc)

#### Settings Screen

![hc](https://github.com/user-attachments/assets/32d40a64-6deb-410f-bd86-5bc57a928600)

### Setup Instructions

To get started with the Mini Home Automation App, follow these steps:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/sahuharshit408/Home-Automation.git
   ```

2. **Navigate to the Project Directory**
   ```bash
   cd home-automation
   ```

3. **Install Dependencies**
   Ensure you have Flutter installed. Then, run the following command to install the required dependencies:
   ```bash
   flutter pub get
   ```

4. **Run the App**
   To run the app on an emulator or connected device, use:
   ```bash
   flutter run
   ```

5. **Build the App**
   To build the app for release, use:
   ```bash
   flutter build apk
   ```
   or for iOS:
   ```bash
   flutter build ios
   ```

### Assumptions and Decisions

- **Flutter Framework**: The app is built using Flutter to ensure a cross-platform experience with a single codebase.
- **Simulated Data Sources**: For demonstration purposes, real-time data and device controls are simulated. In a production environment, these would be replaced with actual data sources and device APIs.
- **User Interface Design**: Focused on a clean and simple interface to enhance usability and ensure that users can easily navigate and control their home devices.


Thank you for checking out the Mini Home Automation App! We hope you find it useful and welcome any feedback or contributions.
