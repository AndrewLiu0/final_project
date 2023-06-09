private int moleScore;
private int timeLeft;
private int moleX;
private int moleY;
private int moleSize;


private boolean moleVisible;
private int highmoleScore;
private String highmoleScoreFilePath = "highmoleScore.txt"; 
private boolean MGameStarted;
private boolean gameEnded;

private PImage wackBackground;
private PImage mole;

final int gameDuration = 10;


private void MSetup(){
  wackBackground = loadImage("WackBackground.png");
  mole = loadImage("mole.png");
  
  windowResize(400, 400);
  moleScore = 0;
  timeLeft = gameDuration;
  moleSize = 50;
  
  moleVisible = false;
  gameStarted = false;
  gameEnded = false;
  loadHighmoleScore();
}

private void MDraw() {
  image(wackBackground, 0 , 0, width, height);
  
  if (MGameStarted) {
    if (!gameEnded) {
      playGame();
    } 
    else {
      endScreen();
    }
  } 
  else {
    startScreen();
  }
}

private void MKeyPressed() {
    if (key == ENTER ) {
      MResetGame();
      MGameStarted = true;
    }
    else if (key == 'm'){
      MResetGame();
      MGameStarted = false;
      selection = 0;
      MSetup();
      
    }
}

private void MMousePressed() {
  // formula to check if mole was hit
  if (gameStarted && !gameEnded && moleVisible && dist(mouseX, mouseY, moleX, moleY) < moleSize/2) {
    moleScore++;
    moleVisible = false;
  }
}

private void startScreen() {
  
  
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(25);
  text("Whack-a-Mole!", width/2, height/2 - 50);
  
  
  textSize(16);
  text("Press Enter to Start", width/2, height/2 + 20);
  text("How to Play:", width/2, height/2 + 60);
  
  
  textSize(14);
  text("You have 10 seconds to whack ", width/2, height/2 + 90);
  text("as many moles as you can", width/2, height/2 + 110);
  
  
}


private void playGame() {
  textSize(20);
  textAlign(LEFT);
  
  fill(255);
  text("Score: " + moleScore, 10, 30);
  text("High Score: " + highmoleScore, 10, 90);
  
  fill(255,0,0);
  text("Time: " + timeLeft, 10, 60);
  
  if (timeLeft > 0) {
    if (frameCount % 60 == 0) {
      timeLeft--;
    }
    
    if (moleVisible) {
      
      imageMode(CORNER);
      fill(255, 0, 0);
      ellipse(moleX, moleY, moleSize, moleSize);
      imageMode(CENTER);
      image(mole, moleX,moleY, width/6, width/6);
      imageMode(CORNER);
      
      
    } 
    else {
      newMole();
    }
  } 
  else {
    gameEnded = true;
  }
}

private void endScreen() {
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255,0,0);
  text("Game Over!", width/2, height/2 - 20);
  textSize(20);
  fill(255);
  
  
  text("Final Score: " + moleScore, width/2, height/2 + 20);
  text("High Score: " + highmoleScore, width/2, height/2 + 45);
  textSize(16);
  text("Restart [ENTER]", width/2, height/2 + 90);
  text ("Main Menu [M]", width/2, height/2 + 110);
  
  
  
  if (moleScore > highmoleScore) {
    highmoleScore = moleScore;
    saveHighmoleScore();
  }
}

private void newMole() {
  moleX = int(random(moleSize, width - moleSize));
  moleY = int(random(moleSize, height - moleSize));
  moleVisible = true;
}

private void MResetGame() {
  moleScore = 0;
  timeLeft = gameDuration;
  gameStarted = true;
  gameEnded = false;
  newMole();
}

private void loadHighmoleScore() {
  String[] lines = loadStrings(highmoleScoreFilePath);
  
  
  if (lines != null && lines.length > 0) {
    highmoleScore = Integer.parseInt(lines[0]);
  } 
  else {
    highmoleScore = 0;
  }
}

private void saveHighmoleScore() {
  String[] lines = new String[1];
  lines[0] = String.valueOf(highmoleScore);
  saveStrings(highmoleScoreFilePath, lines);
}
