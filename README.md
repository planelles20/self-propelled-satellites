# self-propelled satellites
The system is formed by self-propelled satellites influenced by the Sun whose objective is not to leave the domain maintaining the maximum possible speed.

All satellites start at the same point with zero velocity, interacting with the Sun according to Newton's law of universal gravitation. Each satellite can auto propel.

## Example 1

### Equations

Fitness must calculate the accumulated velocity (in module) of the satellite "i" in the generation "g", adding all the previous steps "j". Then a constant (0.025) is multiplied at that speed. If the module of the instantaneous velocity is greater than a maximum value established (20), it is penalized by subtracting 10.

<p align="center">
    <img src="https://github.com/planelles20/self-propelled-satellites/blob/master/img/maxVelEq.gif?raw=true" alt="max velocity equations"/>
</p>

<p align="center">
    <img src="https://github.com/planelles20/self-propelled-satellites/blob/master/img/fitnessEq.gif?raw=true" alt="fitness equations"/>
</p>

<p align="center">
  <img src="https://github.com/planelles20/self-propelled-satellites/blob/master/img/example1.gif?raw=true" alt="Vicsek model 3D gif"/>
</p>
