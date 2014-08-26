Catcher catcher;    
Timer dropTimer;
Drop[] drops;      
int totalDrops = 0; 
Timer powerUpTimer;
PowerUp[] powerUps;
int totalPowerUps = 0;

void setup() {
  size(1000,400);
  smooth();
  catcher = new Catcher(32); 
  drops = new Drop[1000];
  dropTimer = new Timer(300);   
  dropTimer.start();  
  powerUps = new PowerUp[1000]; 
  powerUpTimer = new Timer(3000);
  powerUpTimer.start();
}

void draw() {
  background(255);

  catcher.setLocation(mouseX,mouseY); 

  catcher.display(); 
  
    if (powerUpTimer.isFinished()) 
  {
    if (int(random(3)) == 0)
    {
      println("chundrabindu");
      powerUps[totalPowerUps] = new PowerUp();
      totalPowerUps++;
    }
  if (totalPowerUps >= powerUps.length) {
     totalPowerUps = 0;
  }      
    powerUpTimer.start();
  }
  
  for (int i = 0; i < totalPowerUps; i++) {
    powerUps[i].move();
    powerUps[i].display();
   if (catcher.intersectPowerUp(powerUps[i])) {
     powerUps[i].caught(catcher);
   }
  }
  
  if (dropTimer.isFinished()) {

    drops[totalDrops] = new Drop();

    totalDrops ++ ;

    if (totalDrops >= drops.length) {
      totalDrops = 0;
    }
    dropTimer.start();
  }

  for (int i = 0; i < totalDrops; i++ ) {
    drops[i].move();
    drops[i].display();
    if (catcher.intersectDrop(drops[i])) {
      drops[i].caught();
    }
  }
}
