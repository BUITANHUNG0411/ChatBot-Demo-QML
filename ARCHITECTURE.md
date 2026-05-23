# Project Architecture: Dashboard HMI

## Overview
A multi-view dashboard application using a central `StackLayout` for navigation.

## QML Structure
- `Main.qml`: The root window. Contains a Left Sidebar (Iconic Navigation) and a central `StackLayout`.
- `Home.qml`: The launcher view containing a Grid of available apps.
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
- **Theming:** Rely on `chatBackend.isDarkMode` for ALL color switches (e.g., `color: chatBackend.isDarkMode ? "#1e293b" : "#f1f5f9"`).
- **Styling:** Use semi-transparent rectangles (`Qt.rgba`) for glassmorphism effects.