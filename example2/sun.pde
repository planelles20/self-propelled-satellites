
class Sun {
  PVector position;
  float mass;
  
  Sun(float posx, float posy){
    position = new PVector(posx,posy);
    mass = 1000.0;
  }
  
  void run() {
    update();
    display();
  }
  
  float getMass(){
    return mass;
  }
  
  void update() {
  }
  
  void display() {
    stroke(0);
    fill(#ffff00);
    ellipse(position.x, position.y, 20, 20);
  }
  
  PVector getPosition(){
    return position;
  }
  
}