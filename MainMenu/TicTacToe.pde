private Cell[][] board;

private int cols = 3;
private int rows = 3;

private int cellsLeft = 9; // number of remaining empty cells
private int player = 0; //0 = player1, 1 = player2
private int win = 0;  // 1 = player1 X   2 = player2 0
private int game = 0;  // 1 = selection mode, 2 = game started
private int mode =0; // 1 is one player and 2 is two player

private PImage TBackground;

public void TSetup(){
  TBackground = loadImage("TicTacToeBackground.png");
  windowResize(500,500);
  board = new Cell[cols][rows];
  for (int i = 0; i< cols; i++) {
    for ( int j = 0; j < rows; j++) {
      board[i][j] = new Cell(width/3*i, height/3*j, width/3, height/3);
    }
  }
}

public void TDraw(){
  background(0);
  fill(155);
  
  
  if (game == 0) {
    text("Press T for TicTacToe", width/2 - width/5, height/2);
    text("Press S for Snake Game" , width/2 - width/5, height/2 + height/6);
  }

  // choose mode
  if (game == 1) {
    
    fill(255);
    image(MainMenuImage, 0 , 0, width, height);
    textSize(25);
    textFont(ArcadeSolidFont);
    text("SELECTION" , width/2 - width/5, height/3.3);
    textFont(ArcadeFont);
    
    text("ONE PLAYER[1]", width/2 - width/4.4, height /2.4);
    text("TWO PLAYER[2]", width/2 - width/4.4, (height/2));
  }

  //game start!
  if (game == 2) {
    image(TBackground, 0 , 0, width, height);
    checkGame();  // check if  player win
    for (int i = 0; i<cols; i++) {
      for (int j = 0; j<rows; j++) {
        board[i][j].display();
      }
    }
  }
}

public void TMousePressed(){
  // if the game started and no one has won
  if (game == 2 && win == 0) {
    for (int i = 0; i < cols; i ++) {
      for (int j = 0; j < rows; j ++) {
        board[i][j].click(mouseX, mouseY);
      }
    }
  }
}

public void TKeyPressed(){
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
