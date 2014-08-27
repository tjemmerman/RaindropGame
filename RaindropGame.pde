Catcher catcher;    
Timer dropTimer;
int dropSpawnRate;
Drop[] drops;      
int totalDrops = 0; 
Timer powerUpTimer;
int powerUpSpawnRate;
PowerUp[] powerUps;
int totalPowerUps = 0;
Player player;
PFont sentenceFont;
color sentenceColor;
boolean lost;
String sentence;
PFont buttonTextFont;

void setup() {
  size(1000,400);
  smooth();
  catcher = new Catcher(32); 
  drops = new Drop[1000];
  dropSpawnRate = 300;
  dropTimer = new Timer(dropSpawnRate);   
  dropTimer.start();  
  powerUps = new PowerUp[1000]; 
  powerUpSpawnRate = 3000;
  powerUpTimer = new Timer(powerUpSpawnRate);
  powerUpTimer.start();
  player = new Player();
  sentenceFont = createFont("Helvetica", 30, true);
  sentenceColor = color(0,125);
  boolean lost = false;
}

void draw() {
  background(255);
  
  dropTimer.totalTime = dropSpawnRate;
  powerUpTimer.totalTime = powerUpSpawnRate;
  
  if (!lost) {
    catcher.setLocation(mouseX,mouseY); 
    catcher.display();
    textFont(sentenceFont);
    fill(sentenceColor);
    text("Lives: " + player.lives,10,30);
    text("Score: " + player.score,10,60);
    dropSpawnRate = 300;
    powerUpSpawnRate = 3000;
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
    totalDrops++;

    if (totalDrops >= drops.length) {
      totalDrops = 0;
    }
    dropTimer.start();
  }

  for (int i = 0; i < totalDrops; i++ ) {
    drops[i].move();
    drops[i].display();
    if (drops[i].reachedBottom() && !lost) {
      player.lives--;
    }
    if (catcher.intersectDrop(drops[i]) && !lost) {
      drops[i].caught();
      player.score++;
    }
  }
  if (player.lives == 0) {
     lost = true;
     sentence = "Game over. Your final score was " + Integer.toString(player.score) + ".";
     player.reset();
  }
  
  if (lost) {
    
    noStroke();
    fill(160,85);
    rect(width/2,height/2,width,height);
    
    textFont(sentenceFont);
    fill(sentenceColor);
    textAlign(CENTER,CENTER);
    text(sentence,500,80); 
    
    rectMode(CENTER);
    fill(0,128,255,220);
    rect(500,170,100,60);
    rect(500,250,100,60);
    fill(255);
    textFont(sentenceFont,16);
    text("Play\nAgain",500,170);
    textFont(sentenceFont,20);
    text("Exit",500,250);
    
    dropSpawnRate = 800;
    powerUpSpawnRate = 8000;
    
    for (int i = 0; i < totalDrops; i++)
    {
      if (!drops[i].slowed) {
        drops[i].speed=drops[i].speed/4.0;
        drops[i].slowed = true;
      }
    }
    for (int i = 0; i < totalPowerUps; i++)
    {
      if (!powerUps[i].slowed) {
        powerUps[i].speed=powerUps[i].speed/4.0;
        powerUps[i].slowed = true;
      }
    }
  }
}
