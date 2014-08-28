class PowerUp {
  float x,y;  // coordinates
  float speed;  // the speed that the PowerUp falls at
  boolean onScreen;  // true if PowerUp is on screen
  boolean slowed;
  boolean accelerated;
  
  PowerUp() {
    x = random(width);
    y = -20;    
    speed = random(1,5);  
    onScreen = true;
    slowed = false;
    accelerated = false;
  } 
    void move() {
    y += speed; 
  }
 
  void display() {
    fill(255,255,0);
    noStroke();
    ellipse(x,y,40,40);
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
  catcher.r+=5;
  speed = 0; 
  y = - 1000;
 }
}
