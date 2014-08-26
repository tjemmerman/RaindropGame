class PowerUp {
  float x,y;  // coordinates
  float speed;  // the speed that the PowerUp falls at
  boolean onScreen;  // true if PowerUp is on screen
  
  PowerUp() {
    x = random(width);
    y = -20;    
    speed = random(1,5);  
    onScreen = true;
  } 
    void move() {
    y += speed; 
  }
 
  void display() {
    fill(255,255,0);
    noStroke();
    ellipse(x,y,40,40);
    reachedBottom();
  }
 
   boolean reachedBottom() {
     if (y > height + 20 && onScreen) {
       onScreen = false;
         println(this + " bottom"); 
         return true;
       } else {
         return false;
    }
        
  }
  
  
 void caught(Catcher catcher)
 {
  catcher.setR(catcher.getR()+5);
  speed = 0; 
  y = - 1000;
 }
}
