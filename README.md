## DSB-SC Demodulation with File Output (MATLAB Project)

### Project Summary

This MATLAB script performs **DSB-SC (Double Sideband Suppressed Carrier) demodulation** on an audio signal (`dsbmix.wav`) and searches for the optimal carrier frequency and phase to recover the original message. It generates a low-pass Butterworth filter (4 kHz cutoff) to isolate the baseband message after mixing with candidate carriers.

---

### Core Features

* Reads a modulated audio signal and creates a time vector.
* Tests a range of candidate carrier frequencies (10–14 kHz) and phases (π/4, π/2, 3π/4, π).
* Demodulates by multiplying the received signal with each candidate carrier.
* Applies a low-pass filter to recover the baseband message.
* Calculates the energy of the filtered signal to identify the best carrier parameters.
* Logs significant improvements and final results to a text file (`demodulation_results.txt`).
* Saves the recovered audio signal (`recovered_message.wav`).
* Displays progress and final results on the console.

---

### Key Methods and Algorithms

* **Exhaustive Search:** Loops over all candidate carrier frequencies and phases to maximize the energy of the demodulated signal.
* **Mixing for Demodulation:** Multiplies the received DSB-SC signal with a locally generated carrier.
* **Low-Pass Filtering:** Uses a 6th-order Butterworth filter to remove high-frequency components after demodulation.
* **Energy Calculation:** Uses signal energy (`sum(y^2)`) to quantify how well a candidate carrier recovers the message.
* **Normalization and Audio Output:** Normalizes the recovered signal and saves it as a WAV file for playback.
* **Progress Logging:** Continuously logs improvements to a text file and shows progress in the console.

---

### Skills Demonstrated

* Signal processing with **DSB-SC modulation/demodulation**.
* Implementation of **low-pass filtering** and frequency-domain analysis.
* Use of **exhaustive parameter search** to optimize demodulation.
* File I/O for results logging.
* Audio signal handling with **audioread** and **audiowrite**.
* MATLAB programming with loops, filtering, and vectorized operations.

---

### File Overview

| File Name                    | Description                                              |
| ---------------------------- | -------------------------------------------------------- |
| **demodulation_script.m**    | Contains full DSB-SC demodulation and logging.           |
| **dsbmix.wav**               | Input modulated audio file for testing.                  |
| **recovered_message.wav**    | Output recovered audio after demodulation.               |
| **demodulation_results.txt** | Text file logging search results and optimum parameters. |

---

### How to Run

1. Open MATLAB and place the script in the same folder as `dsbmix.wav`.
2. Run the script:

```matlab
demodulation_script
```

3. Monitor console progress and check `demodulation_results.txt` for detailed results.
4. Listen to `recovered_message.wav` to verify successful demodulation.

---
