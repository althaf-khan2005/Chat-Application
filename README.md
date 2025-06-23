# 💬 Realtime Chat App (Flutter + Firebase)

A clean, real-time chat app built with **Flutter** and **Firebase**, featuring modern dark mode UI, login/auth, profile view, real-time messaging with **last seen**, **typing indicator**, and **notification sounds**.

---

## 🧠 Backend - Firebase

This app uses **Firebase** for backend services:

- 🔐 Firebase Authentication (Login, Signup, Forgot Password)
- 💬 Cloud Firestore for real-time messaging
- ⏰ Realtime presence status and last seen
- 🔔 Notification sounds for sent/received messages
- 🌗 Dark Mode and Clean UI

---

## 🚀 Features

✅ Firebase Authentication (Login/Signup/Forgot Password)  
✅ Real-time Chat (Firestore Streams)  
✅ Last Seen + Online Status  
✅ Typing Indicator  
✅ Play Sound on Send & Receive  
✅ Clean and Animated Dark Mode UI  
✅ Profile Page (view logged-in user info)  
✅ Splash Screen  

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.11.0
  firebase_auth: ^5.4.2
  cloud_firestore: ^5.6.5
  audioplayers: ^6.5.0
  flutter_native_splash: ^2.4.4
  provider: ^6.1.5
  google_fonts: ^6.2.1
  like_button: ^2.1.0
  permission_handler: ^11.4.0


## 📁 Project Structure
less
Copy
Edit
lib/
│── main.dart
│── firebase_options.dart
│── theme.dart
│── themeprovider.dart
│
├── pages/
│   ├── auth.dart
│   ├── authservices.dart
│   ├── login.dart
│   ├── registration.dart
│   ├── loginor_registre.dart
│   ├── forgot.dart
│   ├── home.dart
│   ├── profile.dart
│   ├── firestore.dart      // Firestore service
│   ├── textfiled.dart
│   ├── button.dart
│   ├── buttontext.dart
│
├── new_file/
│   ├── chatpage.dart       // Main chat screen
│   ├── chatservice.dart    // Handles messages
│   ├── chatbubble.dart     // UI bubble widget
│   ├── setting.dart
│   ├── message.dart
│   ├── profile.dart
│   ├── listtile.dart
│   ├── decretion.dart

```

##🔐 Authentication Flow

1.Login/Register → Firebase Auth

2.Forgot Password → Email recovery

3.Auth Gate → Checks login state

4.Chat Page → Messages in real-time

5.Online/Last Seen → Real-time presence

6.Sound → Notification for send/receive

7.Profile Page → View logged-in user

8.Logout → Sign out securely

## How to run 

1. Clone the repo  
   ```sh
   git clone https://github.com/althaf-khan2005/Chat-Application.git
   cd Chat-Application

   ```
2. Install dependencies  
   ```sh
   flutter pub get
   ```
3. Run the app  
   ```sh
   flutter run

## Screenshots 

![Image](https://github.com/user-attachments/assets/0c6ffb5c-77b4-4033-a691-16fb374f6d93)

![Image](https://github.com/user-attachments/assets/919c80d7-1523-44b9-a59e-4fc6c70a9380)

![Image](https://github.com/user-attachments/assets/c7d45d74-5208-4ad6-94da-22fcf7f507fb)

![Image](https://github.com/user-attachments/assets/cee33bc8-a01c-4ef6-bfe3-ddc3bd88b46c)

![Image](https://github.com/user-attachments/assets/8af199c9-2417-4f17-b839-5ab77ee8c01e)

![Image](https://github.com/user-attachments/assets/4289b810-269e-452a-9c36-eb6af0a567d7)

![Image](https://github.com/user-attachments/assets/4b1ae354-b218-4114-ac47-b69036e64942)

![Image](https://github.com/user-attachments/assets/3e4384ea-21cd-4454-b41d-ee72c287a2ea)

![Image](https://github.com/user-attachments/assets/d82c1f44-da76-45e0-926f-61fa12ce0668)

![Image](https://github.com/user-attachments/assets/6f6403da-2138-4d33-8012-648642a4eb3d)

![Image](https://github.com/user-attachments/assets/c9709f40-a1bd-48ae-b182-8f613d1b766b)

![Image](https://github.com/user-attachments/assets/5421da12-d0a2-4af1-b42a-669c24d0731b)
