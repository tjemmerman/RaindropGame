// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-10: The raindrop catching game

class Catcher {
  color col; // color
  float x,y; // location
  float r; //radius of catcher
  
  Catcher(float tempR) {
    r = tempR;
    col = color(50,10,10,150);
    x = 0;
    y = 0;
  }
  
  void setLocation(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }

  void display() {
    stroke(0);
    fill(col);
    ellipse(x,y,r*2,r*2);
  }
  
  // A function that returns true or false based on
  // if the catcher intersects a raindrop
    boolean intersectDrop(Drop d) {
    //iterate through sphere of the raindrop
    for (int i = 2; i < 18; i++){
      // Calculate distance
      float distance = dist(x,y,d.x,d.y+(i*4)); 
      // Compare distance to sum of radii
      if (distance < r + i) { 
        return true;
      }   
    }
    return false;
  }
  
  boolean intersectPowerUp(PowerUp p) {
    float distance = dist(x,y,p.x,p.y);
    if (distance < r + 20) {
      return true;
    }
    else {
      return false;
    }
  }
  
}
