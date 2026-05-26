# Project Roadmap: Omnidirectional Robot Firmware

## Phase 1: Foundation & Communication
- [x] Verify CMake build passes without errors.
- [x] Implement `_write` syscall or redirect `printf` to USB CDC (usbd_cdc_if.c) to allow easy string formatting.
- [x] Test USB CDC: Send a "Hello from STM32" heartbeat every 1 second to the Qt app.

## Phase 2: Sensor Integration
- [x] Implement non-blocking HC-SR04 Trigger logic (every 100ms).
- [x] Implement EXTI Callback on PA8 to measure Echo pulse duration.
- [x] Calculate distance in cm and print it via USB CDC.
- [x] Configure ADC with DMA for continuous scanning of the Potentiometer and Joystick axes.

## Phase 3: Actuation & Control
- [x] Initialize TIM2 PWM for L298N and TIM1 PWM for the Servo.
- [x] Write the differential drive logic (convert ADC joystick/potentiometer values to left/right motor PWM and direction).
- [x] Write safety override: If distance < 10cm, stop both motors regardless of joystick input.

## Phase 4: Qt Integration
- [x] Format the telemetry string strictly to be parsed by the Qt QSerialPort backend.