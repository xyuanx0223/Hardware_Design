## 
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
