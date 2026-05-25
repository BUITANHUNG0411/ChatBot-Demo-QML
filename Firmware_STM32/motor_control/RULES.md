# Firmware Architecture & Coding Rules

## 1. Hardware Abstraction
- **USB CDC (Virtual COM):** Used for bridging telemetry data to the Qt Desktop App.
- **Motor Control (L298N):** `TIM2_CH1` & `TIM2_CH2` for PWM speed. GPIOs for direction.
- **Sonar (HC-SR04):** `PA10` (Trigger - GPIO Out), `PA8` (Echo - EXTI). Use a hardware timer (e.g., SysTick or TIM4) to measure the pulse width in microseconds. Do not use blocking `HAL_Delay` for sonar reading.
- **Servo:** `TIM1_CH2` (PA9) for 50Hz PWM position control.
- **ADC (Joystick & Speed Potentiometer):** Must use DMA to constantly read values into an array in the background without blocking the CPU.

## 2. Real-Time Logic (Non-Blocking)
- **NO `HAL_Delay()`** in the main `while(1)` loop or inside interrupts.
- Use `HAL_GetTick()` for state machines and periodic tasks (e.g., sending USB data every 50ms, triggering sonar every 100ms).

## 3. Kinematics Logic (Differential Drive)
- The Potentiometer sets the Base Speed ($V_{base}$).
- The Joystick X-axis dictates the Turn Differential ($\Delta V$).
- Left Motor Speed = $V_{base} + \Delta V$
- Right Motor Speed = $V_{base} - \Delta V$
- Handle constraints (PWM cannot exceed timer period / ARR value).

## 4. Communication Protocol (STM32 -> Qt)
- Data sent over USB CDC must be structured, e.g., JSON or a simple comma-separated string `"$DATA,left_pwm,right_pwm,distance,state\n"`.