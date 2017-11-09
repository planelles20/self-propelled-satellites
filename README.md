# self-propelled satellites
The system is formed by self-propelled satellites influenced by the Sun whose objective is not to leave the domain maintaining the maximum possible speed.

All satellites start at the same point with zero velocity, interacting with the Sun according to Newton's law of universal gravitation. Each satellite can auto propel.

## Example 1

### Equations

#### Calculation of position, speed, and acceleration.
Acceleration is calculated by Newton's law of universal gravitation plus the satellite impulse, the velocity is computed from the acceleration and the position from the velocity.

<p align="center">
    <img src="https://github.com/planelles20/self-propelled-satellites/blob/master/img/posVelAccEq.gif?raw=true" alt="Calculation of position, speed, and acceleration"/>
</p>

#### Inpulse

The pulse is calculated by the "brain" of the satellite consisting of a neural network consisting of two hidden layers of 5 and 3 neurons, the input data are the satellite speed, the position of the satellite and the position of the Sun, as output the impulse.

#### Genetic algorithm
The genetic algorithm changes weight and bias of neural networks by mutation, reproduction and crossing of the neurons, between the top 5 of the satellites. This way, the maximum fitness value is obtained progressively.

Note: The first 5 satellites are not affected by the genetic algorithm.


#### Fitness

Fitness must calculate the accumulated velocity (in module) of the satellite "i" in the generation "g", adding all the previous steps "j". Then a constant (0.025) is multiplied at that speed. If the module of the instantaneous velocity is greater than a maximum value established (20), it is penalized by subtracting 10.

<p align="center">
    <img src="https://github.com/planelles20/self-propelled-satellites/blob/master/img/maxVelEq.gif?raw=true" alt="max velocity equations"/>
</p>

<p align="center">
    <img src="https://github.com/planelles20/self-propelled-satellites/blob/master/img/fitnessEq.gif?raw=true" alt="fitness equations"/>
</p>

*[YouTube video]()*


<p align="center">
  <img src="https://github.com/planelles20/self-propelled-satellites/blob/master/img/example1.gif?raw=true" alt="Vicsek model 3D gif"/>
</p>
