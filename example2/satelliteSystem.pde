
// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

import java.util.Arrays;

class SatelliteSystem {
  ArrayList<Satellite> selfCarSystem;
  ArrayList<Sun> suns;
  int generation;
  int numSats;
  int numSatsLife;
  int stepsLeft;
  int numSuns;
  
  SatelliteSystem(int numberSatellites, int numberSuns) {
    suns = new ArrayList<Sun>();
    for (int i = 0; i < numberSuns; i++){
      suns.add(new Sun((width-6.0)/2.0, (0.63*height)/2.0*(0.4*i+0.6)));
    }
    
    generation = 0;
    numSats = numberSatellites;
    numSatsLife = numberSatellites;
    stepsLeft = 3500;
    numSuns = numberSuns;
    
    selfCarSystem = new ArrayList<Satellite>();
    for (int i=0; i<numberSatellites; i++){
      selfCarSystem.add(new Satellite(numberSuns));
    }
  }
  
  void run() {
    
    if(stepsLeft == 0 || numSatsLife == 0){
      restart();
    }
    
    // run all satellites
    
    numSatsLife = 0;
    for (int i = 0; i < selfCarSystem.size(); i++) {
      Satellite sat = selfCarSystem.get(i);
      // array with suns positions
      ArrayList<PVector> sunPositions =  new ArrayList<PVector>();
      float[] sunMass = {};
      for (int j = 0; j < suns.size(); j++) {
        Sun sun = suns.get(j);
        sunMass = append(sunMass, sun.getMass());
        sunPositions.add(sun.getPosition());
      }
      sat.run(sunMass, sunPositions);
      if (sat.isLife()) {
        numSatsLife +=1;
        //selfCar.remove(i);
        //sat.reallocate();
      }
      
    }
    
    //sort cars comparing fitness
    //old = selfCarSystem;
    selfCarSystem = sortCars(selfCarSystem);
    
    // suns
    for (int i = 0; i < suns.size(); i++) {
      Sun sun = suns.get(i);
      sun.run();
    }
    
    stepsLeft --;
    
  }
  
  void addParticle() {
    selfCarSystem.add(new Satellite(numSuns));
  }
  
  //sort method
  ArrayList<Satellite> sortCars(ArrayList<Satellite> old){
    ArrayList<Satellite> sorted = new ArrayList<Satellite>();
    for (int i = old.size()-1; i>=0; i--)
    {
      float max_score=-1000000000.0;
      int index = -1;
      for (int j = old.size()-1; j>=0; j--)
      {
        if (old.get(j).getFitness()>max_score)
        {
          max_score = old.get(j).getFitness();
          index = j;
        }
      }
      sorted.add(old.get(index));
      old.remove(index);
    }
    return sorted;
  }
  
  // GA == genetic algorithm
  //void GA(){
  //  for(int i = 5; i<selfCarSystem.size(); i++){
  //    selfCarSystem.get(i).geneticAlgotithm(selfCarSystem.get(0), selfCarSystem.get(1));
  //  }
  //}
  
  Satellite getSatellite(int i){
    return selfCarSystem.get(i);
  }
  
  int getStepsLeft(){
    return stepsLeft;
  }
  
  int numSatLife(){
    return numSatsLife;
  }
  
  int generation(){
    return generation;
  }
  
  void restart(){
    for(int i = 0; i<selfCarSystem.size(); i++){
      //new pos, vel, 
      selfCarSystem.get(i).reallocate();
      if(i > 5){      
        //voose between top 5
        int sat1 = int(random(0, 5));
        int sat2 = int(random(0, 5));
        selfCarSystem.get(i).geneticAlgotithm(selfCarSystem.get(sat1), selfCarSystem.get(sat2));
      }
    }
    stepsLeft = 3500;
    numSatsLife = numSats;
    generation++;
  }
  
}