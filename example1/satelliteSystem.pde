
// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

import java.util.Arrays;

class SatelliteSystem {
  ArrayList<Satellite> selfCarSystem;
  Sun sun;
  int generation;
  int numSats;
  int numSatsLife;
  int stepsLeft;
  
  SatelliteSystem(int n) {
    sun = new Sun();
    generation = 0;
    numSats = n;
    numSatsLife = n;
    stepsLeft = 3500;
    selfCarSystem = new ArrayList<Satellite>();
    for (int i=0; i<n; i++){
      selfCarSystem.add(new Satellite());
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
      sat.run(sun.getMass(), sun.getPosition());
      if (sat.isLife()) {
        numSatsLife +=1;
        //selfCar.remove(i);
        //sat.reallocate();
      }
    }
    
    //sort cars comparing fitness
    //old = selfCarSystem;
    selfCarSystem = sortCars(selfCarSystem);
    
    // sun
    sun.run();
    stepsLeft --;
    
  }
  
  void addParticle() {
    selfCarSystem.add(new Satellite());
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
        // not reapeat sat
        while(sat1 == sat2){
          sat2 = int(random(0, 5));
        }
        selfCarSystem.get(i).geneticAlgotithm(selfCarSystem.get(sat1), selfCarSystem.get(sat2));
      }
    }
    stepsLeft = 3500;
    numSatsLife = numSats;
    generation++;
  }
  
}