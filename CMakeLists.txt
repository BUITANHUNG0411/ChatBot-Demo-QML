cmake_minimum_required(VERSION 3.16)

project(ChatBotDemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Network Positioning Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appChatBotDemo
    src/main.cpp
    src/ChatController.h
    src/ChatController.cpp
    src/ChatModel.h
    src/ChatModel.cpp
    src/WeatherController.h
    src/WeatherController.cpp
    src/note.h
    src/note.cpp
    src/NoteFilterModel.h
    src/NoteFilterModel.cpp
)

qt_add_qml_module(appChatBotDemo
    URI ChatBotDemo
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/Home.qml
        qml/Chatbot.qml
        qml/Weather.qml
        qml/Map.qml
        qml/Contact.qml
        qml/Music.qml
        qml/Note.qml
    RESOURCES
        assets/rubbish.png
)

target_include_directories(appChatBotDemo PRIVATE src)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appChatBotDemo PROPERTIES
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appChatBotDemo
    PRIVATE Qt6::Quick Qt6::Network Qt6::Positioning Qt6::Core
)

include(GNUInstallDirs)
install(TARGETS appChatBotDemo
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
