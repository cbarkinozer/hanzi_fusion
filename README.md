# Hanzi Fusion: The Chinese Character Crafting Game

![Hanzi Fusion Banner](logo.jpg)

**A captivating mobile game where you combine Chinese characters to discover new ones, inspired by classics like *Little Alchemy* and *Infinite Craft*. Built with Flutter and Flame.**

Fundamental char numbers that will be learned at Intro (HSK0):

[
  131:"一",
  27:"二",
  94:"丨",
  732:"十",
  308:"干",
  "丷",
  "半",
  "丿",
  "㇏",
  "人",
  "亻",
  "从",
  "个",
  "入",
  "什",
  "𠂉",
  "午",
  "年",
  "ㄱ",
  "口",
  "中",
  "丩",
  "叫",
  "八",
  "只",
  "介",
  "乚",
  "儿",
  "四",
  "兄",
  "兑", "讠", "说", "计", "认", "识", "㇉", "马", "吗", "骂",
  "乙", "乞", "吃", "气", "冫", "飞", "况", "日", "旧", "旦",
  "但", "早", "唱", "电", "七", "化", "丶", "白", "百", "㇇",
  "今", "千", "舌", "话", "氵", "活", "乱", "汽", "㇆", "月",
  "用", "胖", "朋", "明", "习", "勹", "⺈", "句", "勺", "的",
  "亅", "了", "子", "寸", "时", "辶", "过", "付", "讨", "才",
  "牙", "卜", "上", "下", "卡", "吓", "占", "灬", "点", "让",
  "止", "正", "𤴓", "是", "目", "罒", "自", "面", "身", "谢",
  "弋", "代", "戈", "手", "扌", "我", "或", "看", "担", "拍",
  "提", "找", "木", "本", "体", "末", "米", "来", "呆", "休",
  "桌", "相", "禾", "和", "种", "香", "几", "机", "心", "忄",
  "想", "息", "总", "怕", "匚", "己"
]

Not every character exist as an output in the recipe and they must be literals that cant be divided or should be added.
We might give the fundamental literals at the beginning. Later we need to give the above characters to teach the system. Later we can continue with the remaining characters.

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev)
[![Status](https://img.shields.io/badge/status-in%20development-orange)](https://github.com/cbarkinozer/hanzi_fusion)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/cbarkinozer/hanzi_fusion)

---

## 📖 Table of Contents

-   [🎯 Project Overview](#-project-overview)
-   [✨ Key Features](#-key-features)
-   [🛠️ Tech Stack & Architecture](#️-tech-stack--architecture)
-   [📂 Project Structure](#-project-structure)
-   [🚀 Getting Started](#-getting-started)
-   [📊 Data Structure](#-data-structure)
-   [🗺️ Development Roadmap](#️-development-roadmap)
-   [🤔 Major Problems and Their Solutions](#-major-problems-and-their-solutions)
-   [🤝 How to Contribute](#-how-to-contribute)

---

## 🎯 Project Overview

Hanzi Fusion is a puzzle game that leverages the beautiful, component-based nature of Chinese characters (Hanzi). Players start with a handful of basic elemental characters (e.g., 木 tree, 水 water, 人 person) and combine them by dragging and dropping them together. Successful combinations, based on etymology, semantics, or phonetic clues, create new characters, which are then added to the player's inventory for further fusion.

The goal is to create an experience that is not only addictive and fun but also subtly educational, offering players a glimpse into the logic and artistry behind one of the world's oldest writing systems.

---

## ✨ Key Features

-   **Intuitive Drag & Drop Interface:** Simple and satisfying core mechanic.
-   **Expansive Discovery System:** Hundreds of characters to discover, from simple pictographs to complex ideograms.
-   **Local Progress Saving:** Your discoveries are automatically saved to your device.
-   **Cross-Platform:** Built with Flutter for a native experience on both Android and iOS from a single codebase.
-   **(In Progress) Audio Feedback:** Sound effects for successful and failed fusions.
-   **(Planned) Discovery Book:** An in-game encyclopedia that tracks all discovered characters, showing their pinyin (pronunciation), meaning, and a short etymology.
-   **(Planned) Hint System:** A non-intrusive system to help players when they get stuck.

---

## 🛠️ Tech Stack & Architecture

This project is built using the Flutter framework, chosen for its high-performance, cross-platform capabilities and excellent developer experience.

-   **Framework:** [**Flutter**](https://flutter.dev/)
-   **Language:** [**Dart**](https://dart.dev/)
-   **Game/Rendering Logic:** [**Flame Engine**](https://flame-engine.org/) - A minimalist 2D game engine for Flutter that's perfect for handling the game canvas, sprites, and drag-and-drop gestures.
-   **State Management:** [**Riverpod**](https://riverpod.dev/) - For clean, robust, and scalable state management, separating UI from business logic (e.g., managing the list of discovered characters).
-   **Local Storage:** [**shared_preferences**](https://pub.dev/packages/shared_preferences) - For persisting the player's list of discovered character IDs locally.
-   **Audio:** [**flame_audio**](https://pub.dev/packages/flame_audio) - For playing sound effects for game events.
-   **Data Source:** `JSON` files stored in the app's assets for all character and recipe data. This allows for easy updates and management.

---

## 📂 Project Structure

The project follows a standard feature-first folder structure to maintain separation of concerns.

```
hanzi_fusion/
├── assets/
│   └── data/
│       ├── characters.json   # Master list of all characters (ID, char, pinyin, meaning)
│       └── recipes.json      # Human-readable list of all valid combinations
│
├── lib/
│   ├── data/
│   │   ├── models/           # Dart models for Character and Recipe (with JSON serialization)
│   │   └── game_data_repository.dart # Loads and processes all game data from JSON
│   │
│   ├── game/
│   │   ├── components/       # Flame components (e.g., CharacterComponent)
│   │   └── hanzi_fusion_game.dart # The main Flame game class, handling logic
│   │
│   ├── providers/
│   │   └── player_progress_provider.dart # Riverpod provider for managing player's discovered characters
│   │
│   ├── ui/
│   │   ├── screens/          # Main app screens (GameScreen)
│   │   └── widgets/          # Reusable UI widgets (InventoryPanel)
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
    git clone https://github.com/cbarkinozer/hanzi_fusion.git
    cd hanzi-fusion
    ```
2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
3.  **Ensure assets are registered:**
    Open `pubspec.yaml` and make sure the `assets/data/` directory is included under the `flutter:` section.
    ```yaml
    flutter:
      uses-material-design: true
      assets:
        - assets/data/
        # - assets/fonts/   # Add when custom fonts are included
        # - assets/audio/   # Add when sound effects are included
    ```
4.  **Run the code generator:**
    The project uses code generation for models and providers. Run this command to generate the necessary files:
    ```sh
    dart run build_runner watch
    ```
5.  **Run the app:**
    ```sh
    flutter run
    ```

---

## 📊 Data Structure

The game's content is driven by two key JSON files.

### `characters.json`

An array of all characters in the game. Each character has a unique ID, the character itself, pinyin, and meaning.

```json
[
  {
    "id": 10,
    "char": "人",
    "pinyin": "rén",
    "meaning": "person"
  },
  {
    "id": 123,
    "char": "木",
    "pinyin": "mù",
    "meaning": "wood/tree"
  },
  {
    "id": 130,
    "char": "休",
    "pinyin": "xiū",
    "meaning": "rest"
  }
]
```

### `recipes.json`

An array defining all valid combinations. It uses the actual characters as inputs, making it easy for anyone to contribute new recipes without needing to look up IDs. The application intelligently converts these into a more performant, ID-based format at runtime.

```json
[
  {
    "inputs": ["人", "木"],
    "output": "休"
  },
  {
    "inputs": ["日", "月"],
    "output": "明"
  },
  {
    "inputs": ["木", "木"],
    "output": "林"
  }
]
```

---

## 🗺️ Development Roadmap

The project is broken down into key milestones. `☑️` = Done, `🚧` = In Progress, `⬜` = To-Do.

### ☑️ Milestone 1: Core Engine (MVP)

The basic gameplay loop is functional. Players can discover new characters by combining existing ones, and progress is saved locally.

-   [x] Setup Flutter project with Flame and Riverpod.
-   [x] Implement data loading from `characters.json` and `recipes.json`.
-   [x] Create the basic game screen with an inventory panel and a fusion area.
-   [x] Implement drag-and-drop for character components using Flame.
-   [x] Write the core combination logic to check recipes on drag-and-drop.
-   [x] Implement local progress saving/loading using `shared_preferences`.

### ⬜ Milestone 2: UI/UX & Polish

This milestone focuses on creating a polished and satisfying user experience.

-   [ ] **Design and implement a clean UI for all screens.**
-   [ ] **Add satisfying animations** for successful (e.g., particle burst) and failed (e.g., shake) fusions.
-   [🚧] **Integrate sound effects** for key game events (fusion, failure, UI clicks).
-   [ ] **Build the "Discovery Book" screen** to browse all characters, showing locked and unlocked states.
-   [ ] **Implement the Character Info Page/Dialog** that shows details and stroke order.
-   [ ] Add a main menu or settings button to the game screen.

### 🚧 Milestone 3: Content & Gameplay Expansion

This milestone focuses on deepening the educational content and expanding the gameplay.

-   [ ] **Expand `characters.json` with etymological data** (e.g., components, audio URLs).
-   [ ] **Implement phono-semantic highlighting** on the Character Info Page.
-   [🚧] **Expand character and recipe data** to over 200+ discoveries.
-   [ ] Balance the discovery path to ensure smooth progression.
-   [ ] Implement a simple hint system.
-   [ ] Add a settings screen (e.g., for sound volume, resetting progress).

### ⬜ Milestone 4: Deployment & Advanced Features

-   [ ] Prepare and publish the app to the Google Play Store.
-   [ ] Prepare and publish the app to the Apple App Store.
-   [ ] (Stretch Goal) Investigate Firebase integration for cloud sync.
-   [ ] (Stretch Goal) Investigate deploying a web version using Flutter for Web.

---

## 🤔 Major Problems and Their Solutions

This section documents key design decisions and the reasoning behind them.

### 1. The Challenge: Character Complexity vs. Usage Frequency (HSK)

**The Problem:** The most logically simple characters to build (e.g., `林`, `森`) are not always the most useful words for a beginner to learn (e.g., `电影`, `我`, `是`). A game that only follows etymology might feel impractical.

**The Solution: A Tiered Discovery System.**

The game's progression is designed in tiers, starting with etymologically simple characters to teach the *principle* of Hanzi construction, and then expanding to include more common vocabulary (HSK words) as the player builds their inventory of components.

*   **Tier 0: Primitives:** The starting elements (`人`, `木`, `水`, etc.).
*   **Tier 1: Etymological Foundation:** The early game focuses on intuitive combinations like `人 + 木 = 休` (rest). This is the "magic" that hooks the player.
*   **Tier 2: Vocabulary Building:** The mid-game introduces recipes for common words like `电 + 话 = 电话` (telephone), using the components discovered in Tier 1.

### 2. The Challenge: Folk Etymologies vs. Academic Rigor

**The Problem:** Many easy-to-remember stories for characters are not historically accurate. Should the game use the "fun but false" story or the "correct but complex" one?

**The Solution: Separate the Mechanic from the Explanation.**

*   **The Crafting Logic (The Mechanic): Prioritize Fun and Memorability.** The recipes in `recipes.json` are designed to be intuitive and create a memorable mental hook, even if they are based on folk etymology. The goal of the game loop is engagement.
*   **The Discovery Panel (The Explanation): Provide Accurate Information.** When a character is discovered (a feature planned for Milestone 2), the info panel will provide the accurate etymology, separating the fun mnemonic from the real linguistic details.

### 3. The Challenge: Semantic vs. Phonetic Components

**The Problem:** A single component like `马 (mǎ)` can give meaning (in `驾`) or sound (in `妈`). How do you teach this without a confusing lecture?

**The Solution: Implicit Learning Through UI and Pattern Recognition.**

Instead of complex rules, the game will guide the user with subtle UI cues.

*   **On Combination:** When a character is formed, an animation can highlight which component provided the meaning (e.g., glows blue) and which provided the sound (e.g., glows green).
*   **The "Aha!" Moment:** After making a few characters with the same phonetic component (like `妈`, `骂`, `吗`), the player will discover the pattern for themselves, which is a far more powerful and rewarding learning experience than being told the rule upfront.

## 🤝 How to Contribute

Contributions are welcome! If you have ideas for new features, bug fixes, or new character recipes, please follow these steps:

1.  **Fork** the repository.
2.  Create a new **branch** (`git checkout -b feature/your-feature-name`).
3.  Make your changes. (Adding new recipes to `assets/data/recipes.json` is a great way to start!)
4.  Commit your changes (`git commit -m 'Add some feature'`).
5.  Push to the branch (`git push origin feature/your-feature-name`).
6.  Open a **Pull Request**.