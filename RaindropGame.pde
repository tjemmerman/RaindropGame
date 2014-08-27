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
  lost = false;
  button1Color = color(0,128,255,220);
  button2Color = color(0,128,255,220);
  textAlign(CENTER,CENTER);
}

void draw() {
  background(255);
  println(mouseX + " " + mouseY);
  
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
  println(player.lives);
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

void reset() {
  player.reset();
}  

void mouseClicked() {
  if (lost) {
    if ((450<mouseX && mouseX<550) && (140<mouseY && mouseY<200)) {
      println("Play Again Pressed");
      lost = false;
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
