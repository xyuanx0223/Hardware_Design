### checkpoints
#### A) class transaction:
* 1 Declare all the inputs and outputs with equivalent sizes
* 2 Add modifiers (randc / rand) to all inputs
* 3 Do not add modifiers to output ports

#### B) class Generator:
* 1 Generate random stimulus for inputs
* 2 Send data to Driver with Mailbox
* 3 Signify to Driver about completion of stimuli generation using Event

#### C) Interface:
* 1 Declare all the inputs with logic datatypes

#### D) class Driver:
* 1 Receive data from the Generator through the Mailbox
* 2 Send data to Interface

#### E) class Monitor:
* 1 Receive data from Interface
* 2 Send data to Scoreboard with Mailbox

#### F) class Scoreboard:
* 1 Receive data from the Monitor
* 2 Compare with Golden REF data

#### G) class Environment:
* 1 Initial all the class
* 2 Connect respective Mailbox
* 3 Connect respective Event
* 4 Connect respective Interfaces
* 5 Schedule execution of different process

#### H) Testbench top:
* 1 Instance of Env
* 2 New method to Mailbox
* 3 Connect Interfaces
* 4 Perform connection between Interfaces and DUT

