# Project Architecture: Dashboard HMI

## Overview
A multi-view dashboard application using a central `StackLayout` for navigation.

## QML Structure
- `Main.qml`: The root window. Contains a Left Sidebar (Iconic Navigation) and a central `StackLayout`.
- `Home.qml`: The launcher view containing a Grid of available apps.
- `Theme.qml`: A QML Singleton (`pragma Singleton`) that centralizes all color definitions. It strictly implements a unified **Green/Dark Green color palette** for the entire application to ensure UI consistency.
- `App Views`: `Chatbot.qml`, `Note.qml`, `Weather.qml`, etc.

## C++ Backend Bindings
The following singletons/context properties are currently available to QML:
1. `chatBackend`: 
   - Properties: `isDarkMode` (bool), `chatModel` (QAbstractListModel)
   - Invokables: `sendMessage(QString)`, `clearChat()`
2. `noteControl`:
   - Properties: List models for Todo/Done states.
   - Invokables: `addNote()`, `removeNote(int)`, `setStatus(int, bool)`
3. `weatherControl`:
   - Signals: `weatherDataReceived(string name, double temp, string desc, int humidity, double speed, string icon)`

## UI/UX Guidelines
- **Theming & Color Palette:** The entire application MUST use a cohesive **Green tone** palette (e.g., emerald, forest green, mint). 
- **No Inline Colors:** Do NOT use inline dark mode checks (e.g., `chatBackend.isDarkMode ? "#fff" : "#000"`). Instead, bind colors strictly to the `Theme` singleton properties (e.g., `color: Theme.background`).
- **Theme Singleton Properties:** `Theme.qml` internally observes `chatBackend.isDarkMode` and switches its green-toned hex values accordingly. It exposes semantic properties such as `background`, `surface`, `primaryText`, `secondaryText`, `accent`, and `border`.
- **Styling:** Use semi-transparent rectangles (`Qt.rgba`) for glassmorphism effects, utilizing the base colors from `Theme`.