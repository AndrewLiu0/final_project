Cell[][] board;

int cols = 3;
int rows = 3;

int cellsLeft = 9; // number of remaining empty cells
int player = 0; //0 = player1, 1 = player2
int win = 0;  // 1 = player1   2 = player2;
int game = 0;  // 2 = game started
int mode =0; // 1 is one player and 2 is two player

void setup() {
  size(500, 500);
  board = new Cell[cols][rows];
  for (int i = 0; i< cols; i++) {
    for ( int j = 0; j < rows; j++) {
      board[i][j] = new Cell(width/3*i, height/3*j, width/3, height/3);
    }
  }
}

void draw() {
  background(0);
  if (game == 0) {
    fill(255);
    textSize(20);
    text("Press ENTER to Start", width/2-width/4, height/2);
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

void mousePressed(){
  // if the game started and no one has won
  if(game == 2 && win == 0){
    for (int i = 0; i < cols; i ++){
      for(int j = 0; j < rows ; j ++){
        board[i][j].click(mouseX,mouseY);
      }
    }
  }
}

void keyPressed() {
  if (game == 0 && key == ENTER) {
    cellsLeft = 9;
    game = 1;
  }
  // 1 is pressed
  else if (game == 1 && keyCode == 49) {
    game = 2;
    mode = 1;
  }
  // 2 is pressed
  else if (game == 1 && keyCode == 50) {
    game = 2;
    mode = 2;
  }
}



void checkGame() {
}
