# 📚 BookBuddy

BookBuddy is a SwiftUI iOS app that allows users to search books using the Google Books API, mark them as favorites (saved locally via CoreData), and post reviews (stored in Firebase Firestore). User authentication is handled via Firebase Auth.

---

## 🚀 Features

- 🔍 **Search Books** by title or author using Google Books API
- ⭐ **Save to Favorites** (CoreData, filtered per user)
- 💬 **Write & View Reviews** (Firebase Firestore)
- 🔐 **User Login / Registration** (Firebase Auth)
- 🧠 **User-specific data handling** for favorites and reviews

---

## 📦 Tech Stack

- SwiftUI
- CoreData
- Firebase (Auth, Firestore)
- Google Books API

---

## 📱 Screenshots

<img src="https://github.com/user-attachments/assets/3143f34c-57d9-4e0a-83d6-aa3117c64a9a" width="200">
<img src="https://github.com/user-attachments/assets/00ec176c-c35e-4dea-8e10-1d1cb6ba1e12" width="400">
<img src="https://github.com/user-attachments/assets/6c413ba4-f933-48b8-b7d3-dd32aa611a82" width="200">
<img src="https://github.com/user-attachments/assets/730b1a78-6e73-4131-b306-8b2bedc55bc1" width="200">
<img src="https://github.com/user-attachments/assets/7c1ef364-879b-4e4d-8d16-a2d02c0dc9ff" width="200">
<img src="https://github.com/user-attachments/assets/0d1b1bae-6acb-4def-a01a-87999e26919d" width="200">
<img src="https://github.com/user-attachments/assets/478ac851-13d3-4934-9eaa-1d7e69f1164d" width="200">
<img src="https://github.com/user-attachments/assets/f08c1854-861b-47ca-a8ab-e1ff32c77bc3" width="200">
<img src="https://github.com/user-attachments/assets/d6f02d7b-0185-4a66-9978-538974b7edc8" width="200">
<img src="https://github.com/user-attachments/assets/444f8cd9-79ec-422c-a69d-876de9e62ad8" width="200">
<img src="https://github.com/user-attachments/assets/e8d90bd7-df6c-4b30-8011-1bda9862286e" width="200">
<img src="https://github.com/user-attachments/assets/804ea04f-5ce4-459d-a049-9afd4356f71d" width="200">

---

## 🔧 Setup Instructions

### 1. Clone the Repo
```bash
git clone https://github.com/Saloni260712/BookBuddy.git
cd BookBuddy
```

### 2. Open in Xcode
Open `BookBuddy.xcodeproj` or `BookBuddy.xcworkspace`

### 3. Setup Firebase
- Create a Firebase project
- Enable **Authentication** (Email/Password)
- Enable **Firestore Database**
- Download `GoogleService-Info.plist` and add it to your project

### 4. Install Dependencies
- Project uses Swift Package Manager to include Firebase

### 5. Build and Run ✅

---

## 🗃️ Firestore Structure
**Collection:** `reviews`
```
bookID: String
userEmail: String
content: String
timestamp: Timestamp
```

**CoreData Entity:** `FavoriteBook`
```
id: String
userEmail: String
title: String
author: String
thumbnail: String
```

---

## ✨ Future Improvements
- Add star rating to reviews
- Sync favorites to Firestore
- Filter/search reviews
- Offline caching

---

## 👨‍💻 Author
Saloni Patel — [@Saloni260712 on GitHub](https://github.com/Saloni260712)
