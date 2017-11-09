
class Sun {
  PVector position;
  float mass;
  
  Sun(){
    position = new PVector((width-6)/2.0, (0.63*height)/2.0);
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