int score;
int timeLeft;
int moleX;
int moleY;
int moleSize;
boolean moleVisible;
int highScore;
String highScoreFilePath = "highscore.txt"; 
boolean MGameStarted;
boolean gameEnded;

final int gameDuration = 10;


void MSetup(){
  windowResize(400, 400);
  score = 0;
  timeLeft = gameDuration;  // Game duration in seconds
  moleSize = 50;
  moleVisible = false;
  gameStarted = false;
  gameEnded = false;
  loadHighScore();
}

void MDraw() {
  background(220);
  
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

void MKeyPressed() {
    if (key == ENTER ) {
      MResetGame();
      MGameStarted = true;
    }
}

void MMousePressed() {
  // Check if mole was hit
  if (gameStarted && !gameEnded && moleVisible && dist(mouseX, mouseY, moleX, moleY) < moleSize/2) {
    score++;
    moleVisible = false;
  }
}

void startScreen() {
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Welcome to Whack-a-Mole!", width/2, height/2 - 20);
  textSize(16);
  text("Press Enter to Start", width/2, height/2 + 20);
  text("How to Play:", width/2, height/2 + 60);
  textSize(14);
  text("Click on the mole when it appears to whack it.", width/2, height/2 + 90);
  text("Try to whack as many moles as you can within the time limit.", width/2, height/2 + 110);
}


void playGame() {
  // Display score and time left
  textSize(20);
  textAlign(LEFT);
  text("Score: " + score, 10, 30);
  text("Time: " + timeLeft, 10, 60);
  text("High Score: " + highScore, 10, 90);
  
  if (timeLeft > 0) {
    // Update time left
    if (frameCount % 60 == 0) {
      timeLeft--;
    }
    
    // Display mole
    if (moleVisible) {
      fill(255, 0, 0);
      ellipse(moleX, moleY, moleSize, moleSize);
    } else {
      newMole();
    }
  } else {
    gameEnded = true;
  }
}

void endScreen() {
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Game Over!", width/2, height/2 - 20);
  text("Final Score: " + score, width/2, height/2 + 20);
  textSize(16);
  text("Press Enter to Restart", width/2, height/2 + 60);
  
  // Check if the current score is higher than the stored high score
  if (score > highScore) {
    highScore = score;
    saveHighScore();
  }
}

void newMole() {
  // Generate new mole position
  moleX = int(random(moleSize, width - moleSize));
  moleY = int(random(moleSize, height - moleSize));
  moleVisible = true;
}

void MResetGame() {
  score = 0;
  timeLeft = gameDuration;
  gameStarted = true;
  gameEnded = false;
  newMole();
}

void loadHighScore() {
  String[] lines = loadStrings(highScoreFilePath);
  if (lines != null && lines.length > 0) {
    highScore = Integer.parseInt(lines[0]);
  } else {
    highScore = 0;
  }
}

void saveHighScore() {
  String[] lines = new String[1];
  lines[0] = String.valueOf(highScore);
  saveStrings(highScoreFilePath, lines);
}
