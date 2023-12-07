### Interface Classification
#### Simplex & Duplex(Full/ Half)
Simplex: Monodirectional 
Duplex(Full/ Half): Bidirectional(Simultaneously available or not)
#### Serial & Parallel
Serial: UART. Parallel: RAM/LCD.
#### Synchronous & Asynchronous
Synchronous: Both sender(Master) and receiver(Slave) share the same clock(SPI, L2C)
Asynchronous: Data sent without a clock(UART)
#### Communication
Point to point: between 2 devices(UART)
Multi_drop: Single transmitter and multiple receivers(SPI)
Multi_point: channel is shared between devices(L2C)

### UART(Universal Asynchronous Receiver & Transmitter)
baud rate measures the speed of data transmission, including start, stop, and parity bits. (number of bits/second)
bit rate(bps) indicates the amount of the actual data transmitted from the sender to the receiver.
#### TX & RX
idle state: 1, start bit: 0, LSB, ..., MSB, stop bit:1, idle state
![image](https://github.com/xyuanx0223/Hardware_Design/assets/92006744/9a8a2f1a-b442-4752-9ac6-e8026d444e34)
![image](https://github.com/xyuanx0223/Hardware_Design/assets/92006744/66006b97-b34f-4458-911f-b3da5a4710a2＝116×91)

For example, in UART communication, the baud rate can be calculated using the following formula:
Baud rate = Clock frequency / Divisor
Suppose the clock frequency of a UART device is 16 MHz, and the desired baud rate is 9600 bps. To calculate the divisor, we can rearrange the formula:
Divisor = Clock frequency / Baud rate
Divisor = 16,000,000 Hz / 9600 bps ≈ 1667
In this case, the divisor is approximately 1667. 
The divisor may be rounded to the nearest integer value to achieve the closest possible baud rate to the desired value.

#### FIFO(First in First out)
