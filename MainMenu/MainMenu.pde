private int selection  = 0; 
// 0 is main menu, 1 is tictactoe, 2 is snake game



public void setup() {
  surface.setResizable(true);
  size(500, 500);
  TicTacToeSetup();
  snakeSetup();
  windowResize(500, 500);
}

public void draw() {
  if(selection == 0){
    mainMenuDraw();
  }
  else if (selection == 1){
    windowResize(500, 500);
    TicTacToeDraw();
  }
  else if (selection == 2){
    windowResize(1080, 720);
    snakeDraw();
  }
}

public void mousePressed() {
  TicTacToeMousePressed();
}

public void keyPressed() {
  if(selection == 0 && keyCode == 84){
    selection = 1;   
    cellsLeft = 9;
    game = 1;
  }
  else if (selection == 0 && keyCode == 83){
    selection = 2;
  }
  else if (selection == 1){
    TicTacToeKeyPressed();
  }
  else if (selection == 2){
    SnakeKeyPressed();
  }
}

public void mainMenuDraw(){
    textSize(20);
    fill(255);
    text("Press T for TicTacToe", width/2 - width/5, height/2);
    text("Press S for Snake Game" , width/2 - width/5, height/2 + height/6);
  
}

public void TicTacToeSetup(){
  windowResize(500,500);
  board = new Cell[cols][rows];
  for (int i = 0; i< cols; i++) {
    for ( int j = 0; j < rows; j++) {
      board[i][j] = new Cell(width/3*i, height/3*j, width/3, height/3);
    }
  }
}

public void TicTacToeDraw(){
  background(0);
  fill(155);
  
  if (game == 0) {
    text("Press T for TicTacToe", width/2 - width/5, height/2);
    text("Press S for Snake Game" , width/2 - width/5, height/2 + height/6);
  }

  // choose mode
  if (game == 1) {
    text("Press 1 for one player mode", width/2 - width/4, height /3);
    text("Press 2 for two player mode", width/2 - width/4, 2* (height/3));
  }

  //game start!
  if (game == 2) {
    checkGame();  // check if  player win
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        board[i][j].display();
      }
    }
  }
}

public void TicTacToeMousePressed(){
  // if the game started and no one has won
  if (game == 2 && win == 0) {
    for (int i = 0; i < cols; i ++) {
      for (int j = 0; j < rows; j ++) {
        board[i][j].click(mouseX, mouseY);
      }
    }
  }
}

public void TicTacToeKeyPressed(){
  // 1 is pressed
  if (game == 1 && keyCode == 49) {
    game = 2;
    mode = 1;
  }
  // 2 is pressed
  else if (game == 1 && keyCode == 50) {
    game = 2;
    mode = 2;
  } else if (game == 2 && win == 1 || win == 2 || cellsLeft ==0 && keyCode == ENTER) {
    selection = 0;
    clearBoard();
    game = 1;
  }
}

private void randomPlayMove() {
  boolean moveMade = false;
  while (!moveMade) {
    int x = (int) random(0, cols);
    int y = (int) random(0, rows);
    if (board[x][y].isEmpty()) {
      moveMade = true;
      if (player == 0) {
        board[x][y].setState(1);
        player = 1;
        cellsLeft -= 1;
      } else if (player == 1) {
        board[x][y].setState(2);
        player = 0;
        cellsLeft -= 1;
      }
    }
  }
}


private void checkGame() {
  int row = 0;

  // checking verticals and horizontal wins
  for (int col = 0; col< cols; col++) {
    if (board[row][col].getState() == 2 && board[row+1][col].getState() == 2 && board[row+2][col].getState() == 2) {
      win = 2;
    } else if (board[col][row].getState() == 2 && board[col][row+1].getState() == 2 && board[col][row+2].getState() == 2) {
      win = 2;
    }
    //
    else if (board[col][row].getState() == 1 && board[col][row+1].getState() == 1 && board[col][row+2].getState() == 1) {
      win = 1;
    } else if (board[row][col].getState() == 1 && board[row+1][col].getState() == 1 && board[row+2][col].getState() == 1) {
      win = 1;
    }
  }

  //checking diagonal wins
  if (board[row][row].getState() == 1 && board[row+1][row+1].getState() == 1 && board[row+2][row+2].getState() == 1) {
    win = 1;
  } else if (board[row][row].getState() == 2 && board[row+1][row+1].getState() == 2 && board[row+2][row+2].getState() == 2) {
    win = 2;
  } else if (board[0][row+2].getState() == 1 && board[1][row+1].getState() == 1 && board[2][row].getState() == 1) {
    win = 1;
  } else if (board[0][row+2].getState() == 2 && board[1][row+1].getState() == 2 && board[2][row].getState() == 2) {
    win = 2;
  }

  if (win == 1 || win == 2) {
    textSize(30);
    if (win == 1) {
      fill(0, 0, 225);
      text("O WINS! ENTER to Start Again", width/2-width/2+23, height/2-height/6-20);
    } else if (win == 2) {
      fill(255, 0, 0);
      text("X WINS! ENTER to Start Again", width/2-width/2+23, height/2-height/6-20);
    }
  }

  if ( win == 0 && cellsLeft == 0) {
    fill(0, 255, 0);
    textSize(35);
    text("TIE! ENTER to Start Again", width/2-width/3, height/2-height/6 - 10);
  }
}

void clearBoard() {
  for (int i = 0; i < cols; i ++) {
    for (int j = 0; j < rows; j ++) {
      board[i][j].clear();
    }
  }
  win = 0;
}


// SNAKE GAME

public void snakeSetup(){
  windowResize(1080, 720);
  w = width/size;
  h = height/size;
  
  pos = new PVector(w/2, h/2); // Initial snake position
  newFood(); // create 2D vector
  
  noStroke();
  fill(0);
}

public void snakeDraw(){
  background(200);
  drawSnake();
  drawFood();
  
  // update snake if frameCount is a multiple of spd which is 20 at the begining
  if(frameCount % spd == 0) {
    updateSnake();   
  }
}
public void drawFood() {
  fill(255, 0, 0); 
  rect(food.x * size, food.y * size, size, size); 
}

void drawSnake() {
  fill(0); // set the snake color
  rect(pos.x * size, pos.y * size, size, size); // draw the snake head square at the current position
  
  for(PVector bodyPart : snake) { // iterate over the snake body parts
    rect(bodyPart.x * size, bodyPart.y * size, size, size); // draw each body part square at its position
  }
}

void updateSnake() {
  // Add current position(head) to snake ArrayList
  snake.add(new PVector(pos.x,pos.y));
  
  // Check the size of snake. Remove some items from snake ArrayList if needed
  while(snake.size()> len){
    snake.remove(0);
  }
  
  // Calculate new position of snake (head). You must use the direction vector for this calculation
  pos.add(dir);
  // If snake (head) hits food, add +1 to the snake size and create a new food
  if(pos.x == food.x && pos.y == food.y){
    len += 1;
    newFood();
    if(spd!=1){
      spd -= 1;
    }
    
  }
  // If snake (head) eat itself, gameover, reset()
  for(PVector bodyPart: snake){
    if (bodyPart.x == pos.x && bodyPart.y == pos.y && len > 3){
      
      reset();
    }
  }
  
  for(PVector bodyPart: snake){
    if (bodyPart.x <= 0 || bodyPart.x * (size + 1) >= width || bodyPart.y * (size + 1) >= height || bodyPart.y <= 0 ){
      reset();
      selection = 0;
    }
  }
  
}

void reset() {
  spd = 20;
  len = 5;
  pos = new PVector(w/2, h/2);
  dir = new PVector(0, 0);
  newFood();
  snake = new ArrayList<PVector>();
}

void newFood() {
  food = new PVector(int(random(w)), int(random(h)));
}

void SnakeKeyPressed() {
  if(key == CODED){
    if(keyCode == UP){
      dir = new PVector(0,-1);
    }
    else if (keyCode == DOWN){
      dir = new PVector(0,1);
    }
    else if (keyCode == LEFT){
      dir = new PVector (-1 ,0);
    }
    else if (keyCode == RIGHT){
      dir = new PVector(1,0);
    }
  }
  // if UP is pressed => dir = new PVector(...)
  // same thing for DOWN, LEFT, RIGHT
  // UP (0, -1)
  // DOWN(0, 1)
  // LEFT(-1,0)
  // RIGHT(1,0)
  
}
