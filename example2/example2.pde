SatelliteSystem satelliteSys;

int numSatellites = 100;
int numSuns = 3;

void setup() {
  size(1200, 800);
  frameRate(2000);
  satelliteSys = new SatelliteSystem(numSatellites, numSuns);
}

void draw() {
  background(150);
  //carsys.addParticle();
  satelliteSys.run();
  noFill();
  stroke(0);
  rect(3, 3, width-6, 0.63*height);
  drawTopBoard();
  drawGraph();
  text("Steps left: "+satelliteSys.getStepsLeft(), 10, 20);
  text("live satellites: "+satelliteSys.numSatLife(), 10, 40);
  text("generation : "+satelliteSys.generation(), 10, 60);
}

  // d
void drawTopBoard(){
   //draw TOP 10
  textSize(16);
  stroke(0);
  fill(0);
  text("1st "+nf(satelliteSys.getSatellite(0).getFitness(),0,1), 10, 534);
  text("2nd "+nf(satelliteSys.getSatellite(1).getFitness(),0,1), 10, 554);
  text("3rd "+nf(satelliteSys.getSatellite(2).getFitness(),0,1), 10, 574);
  for(int i=4; i<=10; i++)
    text(i+"th "+nf(satelliteSys.getSatellite(i).getFitness(),0,1), 10, 514+(20*i));
}

int[] x = new int[3501];
float[] y = new float[3501];
int iterator = 0;
int[] xGen = {};
float[] yGen = {};
int generation = -1;

void drawGraph(){
   
  iterator++;
  noFill();
  stroke(0);
  rect(width*0.15, 0.64*height , (1.0-0.15)*width-3, (1-0.64)*height-3);  
  
  x[iterator] = iterator;// = append(x, iterator);
  y[iterator] = -satelliteSys.getSatellite(0).getFitness();
  
  
  if(iterator > 1) {
    for(int i = 1; i < iterator; i++) {
      line(0.75*x[i-1]/iterator*width+width/5, y[i-1]+height/1.1, 0.75*x[i]/iterator*width+width/5, y[i]+height/1.1);
    }
  }
  
  stroke(255);
  if(generation > 1) {
    for(int i = 1; i < generation; i++) {
      line(10.0*xGen[i-1]+width/5, yGen[i-1]+height/1.1, 10.0*xGen[i]+width/5, yGen[i]+height/1.1);
    }
  }
  
  //println(y[iterator-1]);
   if(generation < satelliteSys.generation()){
    generation = satelliteSys.generation();
    
    xGen = append(xGen, generation);
    yGen = append(yGen, y[iterator-1]);
    
    iterator = -1;
  }
}