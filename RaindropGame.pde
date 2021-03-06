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
color button1Color;
color button2Color;
Timer delayTimer;
String firstChar;
int level;

void setup() {
  size(1000,600);
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
  lost = false;
  button1Color = color(0,128,255,220);
  button2Color = color(0,128,255,220);
  delayTimer = new Timer(5000);
  delayTimer.start();
  level = 1;
}

void draw() {
  background(255);
  if (!delayTimer.isFinished()) {
    textFont(sentenceFont);
    fill(0);
    textAlign(CENTER,CENTER);
    String delayTimeLeft = Integer.toString(5000-(millis()-delayTimer.savedTime));
    if (delayTimeLeft.length() == 4) {
      firstChar = delayTimeLeft.substring(0,1) + ".";
    }
    else {
      firstChar = "0.";
    }
    text("Level " + level + " starting in\n" + firstChar+delayTimeLeft.substring(1),width/2,height/2);
  }
  dropTimer.totalTime = dropSpawnRate;
  powerUpTimer.totalTime = powerUpSpawnRate;
  
  if (!lost) {
    catcher.setLocation(mouseX,mouseY); 
    catcher.display();
    textFont(sentenceFont);
    fill(sentenceColor);
    textAlign(LEFT,BASELINE);
    text("Lives: " + player.lives,10,30);
    text("Score: " + player.score,10,60);
    dropSpawnRate = 300;
    powerUpSpawnRate = 3000;
  }
 
  if (level == 2) {
    for (int i = 0; i < totalDrops; i++) {
      if (!drops[i].accelerated) {
        drops[i].speed = drops[i].speed*2;
        drops[i].accelerated = true;
      }
    }
  }
  
  
  if (powerUpTimer.isFinished()) {
    if (delayTimer.isFinished()) {
      if (int(random(3)) == 0)
      {
        powerUps[totalPowerUps] = new PowerUp();
        totalPowerUps++;
      }
      if (totalPowerUps >= powerUps.length) {
        totalPowerUps = 0;
      }      
      delayTimer.stop();
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
    if (delayTimer.isFinished()) {
      drops[totalDrops] = new Drop();
      totalDrops++;
      delayTimer.stop();
    }

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
    if (player.lives <= 0) {
      lost = true;
      sentence = "Game over. Your final score was " + Integer.toString(player.score) + ".";
      player.reset();
      level = 1;
    }
    if (player.score >= 100 && level == 1) {
      level = 2;
      reset();
    } 
  }
  
  if (lost) {
    
    noStroke();
    fill(160,85);
    rect(width/2,height/2,width,height);
    textAlign(CENTER,CENTER);
    textFont(sentenceFont);
    fill(sentenceColor);
    text(sentence,500,80); 
    
    rectMode(CENTER);
    fill(button1Color);
    rect(500,170,100,60);
    fill(button2Color);
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
        drops[i].speed=drops[i].speed/(4.0*level);
        drops[i].slowed = true;
      }
    }
    for (int i = 0; i < totalPowerUps; i++)
    {
      if (!powerUps[i].slowed) {
        powerUps[i].speed=powerUps[i].speed/(4.0*level);
        powerUps[i].slowed = true;
      }
    }
  }
}

void reset() {
  player.reset();
  for (int i = 0; i < totalDrops; i++) {
    drops[i].caught();
  }
  for (int i = 0; i < totalPowerUps; i++) {
    powerUps[i].caught(catcher);
  }
  catcher.r = 32;
  delayTimer.start();
}  

void mouseClicked() {
  if (lost) {
    if ((450<mouseX && mouseX<550) && (140<mouseY && mouseY<200)) {
      lost = false;
      reset();
    }
    if ((450<mouseX && mouseX<550) && (220<mouseY && mouseY<280)) {
      exit();
    }
  }
}

void mousePressed() {
  if (lost) {
    if ((450<mouseX && mouseX<550) && (140<mouseY && mouseY<200)) {
      button1Color = color(0,76,153,220);
    }
    if ((450<mouseX && mouseX<550) && (220<mouseY && mouseY<280)) {
      button2Color = color(0,76,153,220);
    }
  }
}

void mouseReleased() {
  if (lost) {
    button1Color = color(0,128,255,220);
    button2Color = color(0,128,255,220);
  }
}
