# Hazi-fusion: The Chinese Character Crafting Game

![Hazi-fusion Banner](<logo.jpg>)
**A captivating mobile game where you combine Chinese characters to discover new ones, inspired by classics like *Little Alchemy* and *Infinite Craft*. Built with Flutter.**

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/your-username/hazi-fusion)

---
# TODO
* Create the project with "flutter create .
* Add necessary dependencies: "flutter pub add flutter_riverpod riverpod_annotation flutter pub add dev:build_runner dev:json_serializable dev:riverpod_generator flutter pub add json_annotation".



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

-   [☑️] Setup Flutter project with Flame and Riverpod.
-   [☑️] Implement data loading from `characters.json` and `recipes.json`.
-   [☑️] Create the basic game screen with an inventory panel and a fusion area.
-   [☑️] Implement drag-and-drop for character components using Flame.
-   [] Write the core combination logic to check recipes.
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

# Major Problems and Their Solutions

### 1. The Challenge: Character Complexity vs. Usage Frequency (HSK)

**The Problem:** The most logically simple characters to build (e.g., `林`, `森`) are not always the most useful words for a beginner to learn (e.g., `电影`, `我`, `是`). A game that only follows etymology might feel impractical, while a game that only follows HSK order might have nonsensical recipes.

**The Solution: A Tiered Discovery System.**

Think of your game's progression not as a straight line, but as expanding concentric circles.

*   **Tier 0: The Primitives (The Starting Elements).**
    *   This is your initial set of characters. These should be the most fundamental graphical components, many of which are also radicals.
    *   **Examples:** `人`, `口`, `木`, `火`, `水`, `日`, `月`, `一`, `十`, `力`, `心`.
    *   **Purpose:** To provide the absolute basic building blocks for the game mechanic.

*   **Tier 1: The Etymological Foundation (The Early Game).**
    *   This is the initial phase of discovery. **You should absolutely prioritize etymologically simple characters first.** This is crucial. Why? Because it teaches the *principle* of how characters are built. This is the "magic" of your game.
    *   **Recipes:** `人 + 木 = 休` (rest), `木 + 木 = 林` (woods), `日 + 月 = 明` (bright).
    *   **Player Takeaway:** "Wow, Chinese characters make sense! They're like little pictures and puzzles." This is the hook. You are right to deviate from strict HSK order here.

*   **Tier 2: Vocabulary Building (The Mid-Game).**
    *   Once a player has a solid inventory of 50-100 basic characters (many of which *will* be HSK 1 characters just by their nature), the game's focus can shift. Now they have the components to build useful *words*.
    *   **Recipes:** `电 + 话 = 电话` (telephone), `电 + 影 = 电影` (movie), `手 + 机 = 手机` (mobile phone).
    *   **Balancing:** Your HSK lists become your guide for which recipes to prioritize in this tier. Look at the HSK 1 & 2 vocabulary lists. See a word like `飞机` (airplane)? If the player has discovered `飞` and `机`, that's a perfect high-value recipe to include.

**How to Implement This:** You don't need a complex system. It's about how you design your recipe book. The early recipes you create should focus on single-character outputs from simple components. The later recipes can focus on combining those discoveries into multi-character words. The progression will feel natural to the player.

---

### 2. The Challenge: Folk Etymologies vs. Academic Rigor

**The Problem:** Many easy-to-remember stories for characters (mnemonics) are not historically accurate. Should the game use the "fun but false" story or the "correct but complex" one?

**The Solution: Separate the Mechanic from the Explanation.**

This is a brilliant use case for the "Discovery Panel" we've planned.

*   **The Crafting Logic (The Mechanic): Prioritize Fun and Memorability.**
    *   The recipe `口 (mouth) + 鳥 (bird) = 鳴 (to chirp)` is a perfect example. It's an intuitive, delightful "folk etymology." It makes a great game recipe. **Use it.** The primary goal of the game loop is engagement and creating a mental hook.
    *   Your rule for a recipe should be: "Is this a plausible and helpful mnemonic story?" If yes, it's a candidate for a recipe.

*   **The Discovery Panel (The Explanation): Provide Accurate Information.**
    *   When the player successfully creates `鳴`, a panel pops up. This is where you deliver the educational value. You can structure it in layers:
        1.  **Crafting Story:** "You combined `Mouth` and `Bird` to discover `Chirp`!"
        2.  **Pinyin / Meaning:** `míng` - to chirp, make a sound.
        3.  **True Etymology (Optional but amazing):** A small "Learn More" or "Etymology" section. "This is a pictophonetic character. The `口` radical gives the meaning (related to the mouth), while `鳥` (niǎo) provides a clue for the sound (míng)."

**The LLM Idea:** Your friend's suggestion to use an LLM is spot-on for the "True Etymology" part. You could pre-generate these explanations for your JSON data so you don't need a live API call. This gives you the best of both worlds: a fun, game-like recipe and an accurate, optional deep-dive for curious learners.

---

### 3. The Challenge: Semantic vs. Phonetic Components

**The Problem:** A single component like `马 (mǎ)` can give meaning (in `驾` - to drive a chariot) or sound (in `妈` - mā). How do you teach this without a confusing lecture?

**The Solution: Implicit Learning Through UI and Pattern Recognition.**

Do not overwhelm the user with terminology. Let them *discover* the pattern themselves. Your UI can guide them.

*   **Do Not Create Different "Types" of Elements.** A `木` is a `木`. Making a "Semantic Wood" and a "Phonetic Wood" is a usability nightmare. The character is the element, and its *function changes based on context.*

*   **Use Subtle UI Cues:** This is the elegant solution.
    *   **On Combination:** When a successful combination happens, use a subtle animation or color-coding to show the role each component played.
        *   When `女 + 马 = 妈`, as the new character forms, make the `女` part glow blue (for meaning) and the `马` part glow green (for sound).
        *   When `木 + 木 = 林`, make both `木` components glow blue (for meaning).
    *   **In the Discovery Panel:** Reinforce this with simple language.
        *   For `妈`: "Meaning from: `女` (female). Sound from: `马` (mǎ -> mā)."
        *   For `林`: "Meaning from: `木` (tree) + `木` (tree)."

**The "Aha!" Moment:** The player isn't told the rule upfront. But after they've made `妈 (mā)`, `骂 (mà)`, and `吗 (ma)`, they will have an epiphany: **"Wait a minute... every time I use `马`, the new character sounds like 'ma'! And the other part tells me what it's about!"**

You haven't lectured them. You've created a system where they have discovered one of the most fundamental principles of Chinese characters for themselves. This is incredibly powerful and rewarding.

## 🤝 How to Contribute

Contributions are welcome! If you have ideas for new features, bug fixes, or new character recipes, please follow these steps:

1.  **Fork** the repository.
2.  Create a new **branch** (`git checkout -b feature/your-feature-name`).
3.  Make your changes.
4.  Commit your changes (`git commit -m 'Add some feature'`).
5.  Push to the branch (`git push origin feature/your-feature-name`).
6.  Open a **Pull Request**.

---