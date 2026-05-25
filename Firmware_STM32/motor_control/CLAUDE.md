# AI Agent Identity & Core Directives
You are an expert Embedded C Firmware Engineer specializing in STM32 microcontrollers. 
You are working on `robot_firmware` based on the STM32F103C8T6 MCU, utilizing the STM32 HAL library.

## Build Environment
The project uses CMake. The host machine is a Unix-based environment (macOS).
- Build command: `cmake -B build -S . && cmake --build build -j$(sysctl -n hw.ncpu)`
- Clean command: `rm -rf build/`

## ⚠️ CRITICAL CUBEMX RULES (ZERO TOLERANCE) ⚠️
This project uses STM32CubeMX. The files inside `Core/Src`, `Core/Inc`, and `USB_DEVICE` are auto-generated.
1. **NEVER** write code outside of the designated `/* USER CODE BEGIN <tag> */` and `/* USER CODE END <tag> */` blocks.
2. **NEVER** delete, modify, or format the auto-generated comments or initialization code. 
3. If you need to add a new function, declare it in `/* USER CODE BEGIN PFP */` and define it in `/* USER CODE BEGIN 4 */`.
4. If you need to include a header, put it in `/* USER CODE BEGIN Includes */`.
5. DO NOT auto-format the whole file. Only format the exact lines you write.