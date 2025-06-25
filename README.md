# Hazi-fusion: The Chinese Character Crafting Game

![Hazi-fusion Banner](https://via.placeholder.com/1280x320.png?text=Hazi-fusion+%E6%B1%89%E5%AD%97%E8%9E%8D%E5%90%88)

**A captivating mobile game where you combine Chinese characters to discover new ones, inspired by classics like *Little Alchemy* and *Infinite Craft*. Built with Flutter.**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/your-username/hazi-fusion)

---

## 📖 Table of Contents

-   [🎯 Project Overview](#-project-overview)
-   [✨ Key Features](#-key-features)
-   [🛠️ Tech Stack & Architecture](#️-tech-stack--architecture)
-   [📂 Project Structure](#-project-structure)
-   [🚀 Getting Started](#-getting-started)
-   [📊 Data Structure](#-data-structure)
-   [🗺️ Development Roadmap](#️-development-roadmap)
-   [🤝 How to Contribute](#-how-to-contribute)
-   [📜 License](#-license)

---

## 🎯 Project Overview

Hazi-fusion is a puzzle game that leverages the beautiful, component-based nature of Chinese characters (Hanzi). Players start with a handful of basic elemental characters (e.g., 木 tree, 水 water, 人 person) and combine them by dragging and dropping them together. Successful combinations, based on etymology, semantics, or phonetic clues, create new characters, which are then added to the player's inventory for further fusion.

The goal is to create an experience that is not only addictive and fun but also subtly educational, offering players a glimpse into the logic and artistry behind one of the world's oldest writing systems.

---

## ✨ Key Features

-   **Intuitive Drag & Drop Interface:** Simple and satisfying core mechanic.
-   **Expansive Discovery System:** Hundreds of characters to discover, from simple pictographs to complex ideograms.
-   **Discovery Book:** An in-game encyclopedia that tracks all discovered characters, showing their pinyin (pronunciation), meaning, and a short etymology.
-   **Hint System:** A non-intrusive system to help players when they get stuck.
-   **Local Progress Saving:** Your discoveries are automatically saved to your device.
-   **Cross-Platform:** Built with Flutter for a native experience on both Android and iOS from a single codebase.

---

## 🛠️ Tech Stack & Architecture

This project is built using the Flutter framework, chosen for its high-performance, cross-platform capabilities and excellent developer experience.

-   **Framework:** [**Flutter**](https://flutter.dev/)
-   **Language:** [**Dart**](https://dart.dev/)
-   **Game/Rendering Logic:** [**Flame Engine**](https://flame-engine.org/) - A minimalist 2D game engine for Flutter that's perfect for handling the game canvas, sprites, and drag-and-drop gestures.
-   **State Management:** [**Riverpod**](https://riverpod.dev/) - For clean, robust, and scalable state management, separating UI from business logic (e.g., managing the list of discovered characters).
-   **Local Storage:** [**shared_preferences**](https://pub.dev/packages/shared_preferences) - For persisting the player's list of discovered character IDs locally.
-   **Data Source:** `JSON` files stored in the app's assets for all character and recipe data. This allows for easy updates and management.
-   **Backend (Future):** [**Firebase**](https://firebase.google.com/) - For potential future features like cloud sync (Firestore) and user authentication (Auth).

---

## 📂 Project Structure

The project follows a standard feature-first folder structure to maintain separation of concerns.

```
hazi_fusion/
├── assets/
│   ├── data/
│   │   ├── characters.json   # Master list of all characters and their properties
│   │   └── recipes.json      # List of all valid combinations
│   ├── fonts/
│   │   └── NotoSansSC.ttf    # Primary font for UI and characters
│   └── sfx/                  # Sound effects for game events
│
├── lib/
│   ├── data/
│   │   ├── models/           # Dart classes for Character, Recipe, etc.
│   │   └── data_source.dart  # Logic for loading and parsing JSON data
│   │
│   ├── game/
│   │   ├── components/       # Flame components (character_sprite, fusion_area)
│   │   └── hazi_fusion_game.dart # The main Flame game class
│   │
│   ├── providers/
│   │   └── player_progress_provider.dart # Riverpod provider for player's state
│   │
│   ├── ui/
│   │   ├── screens/          # Main app screens (GameScreen, EncyclopediaScreen)
│   │   └── widgets/          # Reusable UI widgets (custom buttons, panels)
│   │
│   └── main.dart             # App entry point
│
└── pubspec.yaml              # Project dependencies and asset declarations
```

---

## 🚀 Getting Started

Follow these instructions to get the project running on your local machine for development and testing.

### Prerequisites

-   [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.x or higher)
-   An IDE like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)
-   An Android emulator or physical device

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/hazi-fusion.git
    cd hazi-fusion
    ```
2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
3.  **Ensure assets are registered:**
    Open `pubspec.yaml` and make sure the `assets/` directory is included under the `flutter:` section.
    ```yaml
    flutter:
      uses-material-design: true
      assets:
        - assets/data/
        - assets/fonts/
        - assets/sfx/
    ```
4.  **Run the app:**
    ```sh
    flutter run
    ```

---

## 📊 Data Structure

The game's content is driven by two key JSON files. The Dart models will be generated based on these structures.

### `characters.json`

An array of all characters in the game.

```json
[
  {
    "id": 1,
    "char": "人",
    "pinyin": "rén",
    "meaning": "person",
    "is_base_element": true
  },
  {
    "id": 3,
    "char": "木",
    "pinyin": "mù",
    "meaning": "tree, wood",
    "is_base_element": true
  },
  {
    "id": 5,
    "char": "休",
    "pinyin": "xiū",
    "meaning": "rest (a person leaning on a tree)",
    "is_base_element": false
  }
]
```

### `recipes.json`

An array defining all valid combinations using character IDs for efficiency.

```json
[
  {
    "input1_id": 1,
    "input2_id": 3,
    "output_id": 5
  }
]
```

---

## 🗺️ Development Roadmap

The project is broken down into four key milestones.

### ☑️ Milestone 1: Core Engine (MVP)

-   [ ] Setup Flutter project with Flame and Riverpod.
-   [ ] Implement data loading from `characters.json` and `recipes.json`.
-   [ ] Create the basic game screen with an inventory panel and a fusion area.
-   [ ] Implement drag-and-drop for character components using Flame.
-   [ ] Write the core combination logic to check recipes.
-   [ ] Implement local progress saving/loading using `shared_preferences`.

### ⬜ Milestone 2: UI/UX & Polish

-   [ ] Design and implement a clean UI for all screens.
-   [ ] Add satisfying animations for successful and failed fusions.
-   [ ] Integrate sound effects for key game events.
-   [ ] Build the "Discovery Book" screen to browse unlocked characters.
-   [ ] Add pinyin and meaning details to the Discovery Book.

### ⬜ Milestone 3: Content & Gameplay Expansion

-   [ ] Expand the `characters.json` and `recipes.json` to 100+ discoveries.
-   [ ] Balance the discovery path to ensure smooth progression.
-   [ ] Implement a simple hint system.
-   [ ] Add a settings screen (e.g., for sound volume).

### ⬜ Milestone 4: Deployment & Advanced Features

-   [ ] Prepare and publish the app to the Google Play Store.
-   [ ] Prepare and publish the app to the Apple App Store.
-   [ ] (Stretch Goal) Investigate Firebase integration for cloud sync.
-   [ ] (Stretch Goal) Investigate deploying a web version using Flutter for Web.

---

## 🤝 How to Contribute

Contributions are welcome! If you have ideas for new features, bug fixes, or new character recipes, please follow these steps:

1.  **Fork** the repository.
2.  Create a new **branch** (`git checkout -b feature/your-feature-name`).
3.  Make your changes.
4.  Commit your changes (`git commit -m 'Add some feature'`).
5.  Push to the branch (`git push origin feature/your-feature-name`).
6.  Open a **Pull Request**.

---