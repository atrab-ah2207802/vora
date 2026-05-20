# Vora — Room Climate Control

A Flutter app built for the [Vora](https://vora.qa) Mobile Development Intern Phase 2 skill task. It implements a single-screen room climate control interface with full state management, multi-room support, and animated UI interactions.

---

## Features

- **Multi-room switching** — switch between Living Room, Bedroom, and Kitchen via animated chips
- **Live readings** — current temperature and humidity displayed per room
- **Target temperature control** — adjust target temp up/down (16–30 °C) with a progress bar and diff indicator
- **Fan speed selector** — scrollable wheel picker with Low / Medium / High options
- **Power toggle** — animated on/off state with visual feedback across all controls

No backend, no API calls — all state is managed locally with `provider`.

---

## Project Structure

```
lib/
├── main.dart                  # App entry point, ChangeNotifierProvider setup
│
├── model/
│   ├── climate_model.dart     # FanSpeed enum, RoomData, ClimateState
│   └── app_colors.dart        # Brand color palette
│
├── providers/
│   └── climate_provider.dart  # ClimateProvider (ChangeNotifier) — all state logic
│
├── screens/
│   └── home_screen.dart       # Single HomeScreen, composes all widgets
│
├── widgets/
│   ├── room_chips.dart        # Horizontal scrollable room selector
│   ├── current_readings.dart  # Temperature + humidity display cards
│   ├── temperature_control.dart # Target temp with up/down arrows and progress bar
│   ├── settings_card.dart     # Fan speed + power rows in a card
│   └── fan_speed_selector.dart # ListWheelScrollView fan speed picker
│
└── routes/                    # Reserved for future navigation (currently empty)
```


## State Management

State lives in `ClimateProvider` (a `ChangeNotifier`) and is injected at the root via `ChangeNotifierProvider`. The `HomeScreen` reads state with `context.watch` and dispatches actions via `context.read` — keeping the screen reactive without unnecessary rebuilds deeper in the tree.

`ClimateState` is immutable and updated via `copyWith`. Per-room data (`RoomData`) is also immutable; room updates replace the entry in the list.

---

### Prerequisites

- Flutter SDK **3.x** or later ([install guide](https://docs.flutter.dev/get-started/install))
- Dart **3.x**
- `provider` package (listed in `pubspec.yaml`)

### Run

```bash
git clone <repo-url>
cd <repo-folder>
flutter pub get
flutter run
```


## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
```