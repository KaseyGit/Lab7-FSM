# Lab7-FSM

This project includes two main FSM subprojects: a sequence detector and a counter + display module.

Two sequence detectors are implemented to detect two different 4-bit patterns, each developed as a Moore or Mealy style FSM.

The counter display module (topModule) takes a clock and a reset input and continuously counts from 0 to 4095 (maximum value of 12 bits). It displays this value on a seven segment display by converting the counter's binary output to a binary-coded-decimal (BCD) value, which is then encoded into cathode patterns corresponding to readable digits on a seven-segment display. The module uses a cycle of enables to ensure that the main processes of the program do not interrupt each other; each process's (count, convert, display) ready signal is connected to the enable port of the following action.
The topModule is programmed onto a Basys3 board in the context of this Lab.
