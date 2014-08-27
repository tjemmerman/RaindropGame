Catcher catcher;    
Timer dropTimer;
Drop[] drops;      
int totalDrops = 0; 
Timer powerUpTimer;
PowerUp[] powerUps;
int totalPowerUps = 0;
Player player;
PFont labelFont;
color labelColor;
boolean lost;

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
  player = new Player();
  labelFont = createFont("Helvetica", 30, true);
  labelColor = color(0,85);
  boolean lost = false;
}

void draw() {
  background(255);
  
  if (!lost) {
    catcher.setLocation(mouseX,mouseY); 
    catcher.display();
    textFont(labelFont);
    fill(labelColor);
    text("Lives: " + player.lives,10,30);
    text("Score: " + player.score,10,60);
  }
 
  
    if (powerUpTimer.isFinished()) 
  {
    if (int(random(3)) == 0)
    {
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
    powerUps[i].reachedBottom();
   if (catcher.intersectPowerUp(powerUps[i]) && !lost) {
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
    if (drops[i].reachedBottom()) {
      player.lives--;
      if (player.lives == 0) {
        lost = true;
      }
    }
    if (catcher.intersectDrop(drops[i]) && !lost) {
      drops[i].caught();
      player.score++;
    }
  }
  
  if (lost) {
    noStroke();
    fill(160,85);
    rect(0,0,width,height);
    
    noStroke();
    fill(0);
    rect(450,140,100,60);
    
    fill(0);
    rect(450,220,100,60);
    
    for (int i = 0; i < totalDrops; i++)
    {
      if (!drops[i].slowed) {
        println("Drop " + i + " " + drops[i].slowed);
        drops[i].speed=drops[i].speed/2.0;
        drops[i].slowed = true;
      }
    }
    for (int i = 0; i < totalPowerUps; i++)
    {
      if (!powerUps[i].slowed) {
        powerUps[i].speed=powerUps[i].speed/2.0;
        powerUps[i].slowed = true;
      }
    }
  }
}
