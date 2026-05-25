# Project Roadmap: Omnidirectional Robot Firmware

## Phase 1: Foundation & Communication
- [ ] Verify CMake build passes without errors.
- [ ] Implement `_write` syscall or redirect `printf` to USB CDC (usbd_cdc_if.c) to allow easy string formatting.
- [ ] Test USB CDC: Send a "Hello from STM32" heartbeat every 1 second to the Qt app.

## Phase 2: Sensor Integration
- [ ] Implement non-blocking HC-SR04 Trigger logic (every 100ms).
- [ ] Implement EXTI Callback on PA8 to measure Echo pulse duration.
- [ ] Calculate distance in cm and print it via USB CDC.
- [ ] Configure ADC with DMA for continuous scanning of the Potentiometer and Joystick axes.

## Phase 3: Actuation & Control
- [ ] Initialize TIM2 PWM for L298N and TIM1 PWM for the Servo.
- [ ] Write the differential drive logic (convert ADC joystick/potentiometer values to left/right motor PWM and direction).
- [ ] Write safety override: If distance < 10cm, stop both motors regardless of joystick input.

## Phase 4: Qt Integration
- [ ] Format the telemetry string strictly to be parsed by the Qt QSerialPort backend.