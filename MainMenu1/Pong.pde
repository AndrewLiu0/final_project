private int paddleWidth = 20;
private int paddleHeight = 80;
private int paddleSpeed = 5;
private int paddle1X;
private int paddle1Y;
private int paddle2X, paddle2Y;
private int paddle1Direction, paddle2Direction;

private int ballSize = 20;
private float ballX, ballY;
private float ballSpeedX, ballSpeedY;

private int player1Score, player2Score;


private boolean gameStarted = false;
private boolean gameOver = false;

private PImage PBackground;

private void PSetup(){
  windowResize(800, 400);
  
  PBackground = loadImage("PongBackground.png");
  
  noStroke();
  rectMode(CENTER);

  paddle1X = paddleWidth;
  paddle2X = width - paddleWidth;
  paddle1Y = paddle2Y = height / 2;

  resetBall();
}


private void PDraw(){
  image(PBackground, 0 , 0, width, height);

  if (gameStarted) {
    drawPaddles();
    drawBall();
    updatePaddles();
    updateBall();
    displayScores();
    checkGameOver();
  } else if (gameOver) {
    displayGameOver();
  } else {
    displayStartScreen();
  }
}


private void PKeyPressed(){
  if (!gameStarted || gameOver) {
    if (keyCode == ENTER) {
      resetGame();
    }
  }
  if(gameOver && keyCode == 77){
    selection = 0;
    PSetup();
    resetGame();
    resetBall();
    textAlign(LEFT);
  }
}



private void displayGameOver() {
  textAlign(CENTER);
  textSize(30);
  fill(255);
  text("Game Over", width / 2, height / 2 - 40);

  textSize(30);
  fill(255);
  if (player1Score > player2Score) {
    fill(255,0,0);
    text("Player 1 Wins!", width / 2, height / 2);
  } 
  else {
    fill(0,0,255);
    text("Player 2 Wins!", width / 2, height / 2);
  }
  textSize(20);
  fill(255);
  text("Restart [ENTER]", width / 2, height / 2 + 40);
  
  text("Main Menu [M]", width/2, height/2 + 80);

}

private void displayStartScreen() {
  textAlign(CENTER);
  textSize(30);
  fill(255);
  text("Press Enter to Start", width / 2, height / 2);

  textSize(20);
  fill(255);
  fill(255,0,0);
  text("Player 1: use W and S KEY ", width / 2, height / 2 + 80);
  fill(0,0,255);
  text("Player 2: use UP and DOWN key", width / 2, height / 2 + 120);
}

private void drawPaddles() {
  fill(255, 0, 0);
  rect(paddle1X, paddle1Y, paddleWidth, paddleHeight);
  fill(0, 0, 255);
  rect(paddle2X, paddle2Y, paddleWidth, paddleHeight);
}

private void drawBall() {
  fill(255);
  ellipse(ballX, ballY, ballSize, ballSize);
}

private void updatePaddles() {
  // Move paddle 1
  if (keyPressed && key == 'w') {
    paddle1Direction = -1;
  } 
  else if (keyPressed && key =='s') {
    paddle1Direction = 1;
  } 
  else {
    paddle1Direction = 0;
  }

  paddle1Y += paddleSpeed * paddle1Direction;
  if (paddle1Y < paddleHeight / 2) {
    paddle1Y = paddleHeight / 2;
  } 
  else if (paddle1Y > height - paddleHeight / 2) {
    paddle1Y = height - paddleHeight / 2;
  }

  // Move paddle 2
  if (keyPressed && keyCode == UP) {
    paddle2Direction = -1;
  } 
  else if (keyPressed && keyCode == DOWN) {
    paddle2Direction = 1;
  } 
  else {
    paddle2Direction = 0;
  }

  paddle2Y += paddleSpeed * paddle2Direction;
  if (paddle2Y < paddleHeight / 2) {
  paddle2Y = paddleHeight / 2;
  } 
  else if (paddle2Y > height - paddleHeight / 2) {
  paddle2Y = height - paddleHeight / 2;
  }
}

private void updateBall() {
  // Move the ball
  ballX += ballSpeedX;
  ballY += ballSpeedY;

  // Check for collision with paddles
  if (ballX - ballSize / 2 <= paddle1X + paddleWidth / 2 &&
      ballY >= paddle1Y - paddleHeight / 2 &&
      ballY <= paddle1Y + paddleHeight / 2) {
    ballSpeedX *= -1;
  }

  if (ballX + ballSize / 2 >= paddle2X - paddleWidth / 2 &&
      ballY >= paddle2Y - paddleHeight / 2 &&
      ballY <= paddle2Y + paddleHeight / 2) {
    ballSpeedX *= -1;
  }

  // Check for collision with walls
  if (ballY - ballSize / 2 <= 0 || ballY + ballSize / 2 >= height) {
    ballSpeedY *= -1;
  }

  // Check for scoring
  if (ballX - ballSize / 2 <= 0) {
    player2Score++;
    resetBall();
  }

  if (ballX + ballSize / 2 >= width) {
    player1Score++;
    resetBall();
  }
}

private void resetBall() {
  ballX = width / 2;
  ballY = height / 2;
  ballSpeedX = 5;
  ballSpeedY = random(-5, 5);
}

private void resetGame() {
  player1Score = 0;
  player2Score = 0;
  gameOver = false;
  gameStarted = true;
  resetBall();
}

private void checkGameOver() {
  if (player1Score >= 3 || player2Score >= 3) {
    gameStarted = false;
    gameOver = true;
  }
}

private void displayScores() {
  textAlign(CENTER);
  textSize(30);
  
  fill(255, 0, 0);
  text(player1Score, width / 4, 40);
  
  fill(0, 0, 255);
  text(player2Score, width * 3 / 4, 40);
  
  fill(255);
  textSize(20);
  text("First to 3 Wins!", width/2, height/12);
}
