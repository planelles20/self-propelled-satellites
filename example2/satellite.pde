

class Satellite {
  PVector position;
  PVector velocity;
  PVector acceleration;
  boolean lifetag;
  float fitness;
  int numDeads;
  float mass;
  float acumulateVel; // to deff new parameter to fitness
  
  Brain brain;
  
  //domain limits
  float topLimit = 3.0;
  float downLimit = 0.63*height;
  float leftLimit = 3.0;
  float rightLimit = width-6;
  float timetag;

  Satellite(int numSuns) {
    acceleration = new PVector(0.0, 0.0);
    velocity = new PVector(0.0, 0.0);
    //position = new PVector(random(leftLimit, rightLimit), random(topLimit, downLimit));
    position = new PVector(width/6.0, 0.63*height/2.0);
    lifetag = true;
    fitness = 0;
    timetag = 0;
    numDeads = 0;
    acumulateVel = 0;
    mass = 0.1;
    brain = new Brain(numSuns);
  }

  void run(float[] sunMass, ArrayList<PVector> sunPosition) {
    if(isLife()){
      update(sunMass, sunPosition);
      display();
    }
  }

  // Method to update position
  void update(float[] sunsMass, ArrayList<PVector> sunsPosition) {
    timetag ++;
    acceleration = brain.getInpulse(position, velocity, sunsPosition);
    for (int j = 0; j < sunsPosition.size(); j++) {
      float sunMass = sunsMass[j];
      PVector sunPosition = sunsPosition.get(j);
      acceleration.add(gravityForce(sunMass, sunPosition)) ;
    }
    velocity.add(acceleration);
    position.add(velocity);
    //lifetag = true;
    deadConditions();
    calculateFitness();
  }

  // Method to display
  void display() {
    if(isLife()){
      stroke(0);
      fill(#a73540);
      ellipse(position.x, position.y, 8, 8);
    }
  }

  // Is the car still useful?
  boolean isLife() {
    return lifetag;
  }
  
  void reallocate(){
    acceleration = new PVector(0.0, 0.0);
    velocity = new PVector(0.0, 0.0);
    //position = new PVector(random(leftLimit, rightLimit), random(topLimit, downLimit));
    position = new PVector(width/6.0, 0.63*height/2.0);
    lifetag = true;
    fitness = 0;
    numDeads ++;
    timetag = 0;
    acumulateVel = 0;
  }
  
  // dead conditions
  void deadConditions(){
    if(position.x>rightLimit || position.x<leftLimit || position.y>downLimit || position.y<topLimit){
      lifetag = false;
    }
  }
  
  void calculateFitness(){
    float vel = velocity.mag();
    if(vel>20) vel = -10;
    acumulateVel += vel;
    //0.005
    fitness = 0.0*(timetag) - 0.0*numDeads + 0.0*vel + 0.025*acumulateVel;
  }
  
  float getFitness(){
    return fitness;
  }
  
  float getDeads(){
    return numDeads;
  }
  
  PVector gravityForce(float sunMass, PVector sunPosition){
    float dist = position.dist(sunPosition);
    PVector force = PVector.sub(position,sunPosition).normalize().mult(-mass*sunMass/(dist*dist));
    return force;
  }
  
  void geneticAlgotithm(Satellite sat1, Satellite sat2){
    if(0.3 < random(0, 1.0))
      brain.crossOver(sat1); // choose bebetween 4 first numbers (5 not include)
    else if(0.3 < random(0, 1.0))
      brain.copyBrain(sat1); // choose bebetween 4 first numbers (5 not include)
    else 
      brain.reproduction(sat1, sat2); // choose bebetween 4 first numbers
      
    //if(0.3 < random(0, 1.0))
    brain.mutation();
   
  }
  
  float getWeight(int layer, int i, int j){
    return brain.getWeight(layer, i, j);
  }
  
  float getBias(int layer, int i){
    return brain.getBias(layer, i);
  }

}