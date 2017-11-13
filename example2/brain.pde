

class Brain {
  
  int numOutputs;
  float [] outPuts;
  int numInputs;
  float [] inputs;
  int numHiddenNeurons1;
  int numHiddenNeurons2;
  float[][] weight1;
  float[][] weight2;
  float[][] weight3;
  float[] bias1;
  float[] bias2;
  
  float[] hiddenNeurons1;
  float[] hiddenNeurons2;
  
  
  float maxInpulse;
  float mutation;
  
  Brain(int numSuns){
    // NOTE: two out puts
    numOutputs = 2;
    outPuts = new float[numOutputs];
    // satellite pos, satellite vell, (sun pos) * number of suns
    numInputs = 2+2+2*numSuns;
    inputs = new float[numInputs];
    numHiddenNeurons1 = 5;
    numHiddenNeurons2 = 3;
    weight1 = new float[numInputs][numHiddenNeurons1];
    weight2 = new float[numHiddenNeurons1][numHiddenNeurons2];
    weight3 = new float[numHiddenNeurons2][numOutputs];
    bias1 = new float[numHiddenNeurons1];
    bias2 = new float[numHiddenNeurons2];
    initWeights();
    hiddenNeurons1 = new float[numHiddenNeurons1];
    hiddenNeurons2 = new float[numHiddenNeurons2];
    
    mutation = 0.05;
    maxInpulse = 0.001;
  }
  
  void initWeights(){
    //weight1
    for(int i = 0; i<numInputs; i++){
      for(int j = 0; j<numHiddenNeurons1; j++) {
        weight1[i][j] = random(-1.0, 1.0);
      }
    }
    
    //weight2
    for(int i = 0; i<numHiddenNeurons1; i++){
      for(int j = 0; j<numHiddenNeurons2; j++) {
        weight2[i][j] = random(-1.0, 1.0);
      }
    }
    
    //weight3
    for(int i = 0; i<numHiddenNeurons2; i++){
      for(int j = 0; j<numOutputs; j++) {
        weight3[i][j] = random(-1.0, 1.0);
      }
    }
    
    //bias 1
    for(int i = 0; i<numHiddenNeurons1; i++){
      bias1[i] = random(-1.0, 1.0);
    }
    
    //bias 2
    for(int i = 0; i<numHiddenNeurons2; i++){
      bias2[i] = random(-1.0, 1.0);
    }
    
  }
  
  PVector getInpulse(PVector satPos, PVector satVel, ArrayList<PVector> sunsPos){
     
    // get inputs and normaliz 
    inputs[0] = satPos.x/width;
    inputs[1] = satPos.y/(0.63*height);
    inputs[2] = satVel.x/maxInpulse;
    inputs[3] = satVel.y/maxInpulse;
    for(int i=4; i<(4+sunsPos.size()); i++){
      PVector sunPos = sunsPos.get(i-4);
      inputs[i] = sunPos.x/width;
      inputs[i] = sunPos.y/(0.63*height);
    }
    
    // calculate hidden neurons
    // layer 1
    for(int i = 0; i<numHiddenNeurons1; i++){
      hiddenNeurons1[i] = 0.0;
      for(int j = 0; j<numInputs; j++){
        hiddenNeurons1[i] += weight1[j][i]*inputs[j];
      }
      hiddenNeurons1[i] = activationFunction(hiddenNeurons1[i]+bias1[i]);
    }
    
    // layer 2
    for(int i = 0; i<numHiddenNeurons2; i++){
      hiddenNeurons2[i] = 0.0;
      for(int j = 0; j<numHiddenNeurons1; j++){
        hiddenNeurons2[i] += weight2[j][i]*hiddenNeurons1[j];
      }
      hiddenNeurons2[i] = activationFunction(hiddenNeurons2[i]+bias2[i]);
    }
    
    //calculate output
    for(int i = 0; i<numOutputs; i++){
      outPuts[i] = 0.0;
      for(int j = 0; j<numHiddenNeurons2; j++) {
        outPuts[i] += weight3[j][i]*hiddenNeurons2[j];
      }
    }
    
    // check max and min possible valors
    for(int i = 0; i<numOutputs; i++){
      if(outPuts[i]>maxInpulse)
        outPuts[i] = maxInpulse;
       else if (outPuts[i]<-maxInpulse)
         outPuts[i] = -maxInpulse;
    }
     
    // transfor out put to PVector
    PVector inpulse = new PVector(0.0, 0.0);
    
    inpulse.x = outPuts[0];
    inpulse.y = outPuts[1];
    
    return inpulse;
  }
  
  // GA operations
  void mutation (){
    //weight1
    for(int i = 0; i<numHiddenNeurons1; i++){
      for(int j = 0; j<numInputs; j++) {
        if(mutation <random(0, 1.0))
          weight1[j][i] = random(-1.0, 1.0);
      }
      if(mutation <random(0, 1.0))
          bias1[i] = random(-1.0, 1.0);
    }
    //weight2
    for(int i = 0; i<numHiddenNeurons2; i++){
      for(int j = 0; j<numHiddenNeurons1; j++) {
        if(mutation <random(0, 1.0))
          weight2[j][i] = random(-1.0, 1.0);
      }
      if(mutation <random(0, 1.0))
          bias2[i] = random(-1.0, 1.0);
    }
    
    //weight3
    for(int i = 0; i<numHiddenNeurons2; i++){
      for(int j = 0; j<numOutputs; j++) {
        if(mutation <random(0, 1.0))
          weight3[i][j] = random(-1.0, 1.0);
      }
    }
  }
  
  void crossOver(Satellite sat){
     //weight1
    for(int i = 0; i<numHiddenNeurons1; i++){
      for(int j = 0; j<numInputs; j++) {
        if(0.5 <random(0, 1.0)) 
          weight1[j][i] = weight1[j][i];
        else
          weight1[j][i] = sat.getWeight(1, j, i);
      }
      if(0.5 <random(0, 1.0)) 
        bias1[i] = bias1[i];
      else
        bias1[i] = sat.getBias(1, i);
    }
    
    //weight2
    for(int i = 0; i<numHiddenNeurons2; i++){
      for(int j = 0; j<numHiddenNeurons1; j++) {
        if(0.5 <random(0, 1.0)) 
          weight2[j][i] = weight2[j][i];
        else
          weight2[j][i] = sat.getWeight(2, j, i);
      }
      if(0.5 <random(0, 1.0)) 
        bias2[i] = bias2[i];
      else
        bias2[i] = sat.getBias(2, i);
    }
    
    
    //weight3
    for(int i = 0; i<numHiddenNeurons2; i++){
      for(int j = 0; j<numOutputs; j++) {
        if(0.5 <random(0, 1.0)) 
          weight3[i][j] = weight3[i][j];
        else 
          weight3[i][j] = sat.getWeight(3, i, j);
      }
    }
  }
  
  void reproduction(Satellite sat1, Satellite sat2){
    //weight1
    for(int i = 0; i<numHiddenNeurons1; i++){
      for(int j = 0; j<numInputs; j++) {
        if(0.5 <random(0, 1.0)) 
          weight1[j][i] = sat1.getWeight(1, j, i);
        else
          weight1[j][i] = sat2.getWeight(1, j, i);
      }
    }
    
     //weight2
    for(int i = 0; i<numHiddenNeurons2; i++){
      for(int j = 0; j<numHiddenNeurons1; j++) {
        if(0.5 <random(0, 1.0)) 
          weight2[j][i] = sat1.getWeight(2, j, i);
        else
          weight2[j][i] = sat2.getWeight(2, j, i);
      }
    }
    
    //weight3
    for(int i = 0; i<numHiddenNeurons2; i++){
      for(int j = 0; j<numOutputs; j++) {
        if(0.5 <random(0, 1.0)) 
          weight2[i][j] = sat1.getWeight(2, i, j);
        else 
          weight2[i][j] = sat2.getWeight(2, i, j);
      }
    }
  }
  
  float activationFunction(float x){
    //sigmoid
    return 1.0/(1.0+exp(-x));
  }
  
  float getWeight(int layer, int i, int j){
   if(layer == 1)
      return weight1[i][j];
   else if(layer == 2)
      return weight2[i][j];
   else if(layer == 3)
      return weight3[i][j];
   else {
     println("Error: incorrect layer");
     exit();
     return 0.0;
     }
  }
  
  float getBias(int layer, int i){
   if(layer == 1)
      return bias1[i];
   else if(layer == 2)
      return bias1[i];
   else {
     println("Error: incorrect bias layer");
     exit();
     return 0.0;
     }
  }
  
}