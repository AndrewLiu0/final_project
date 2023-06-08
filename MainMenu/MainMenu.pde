private int selection  = 0; 
PImage MainMenuImage;
PFont ArcadeFont;
PFont ArcadeSolidFont;
// 0 is main menu, 1 is tictactoe, 2 is snake game



public void setup() {
  surface.setResizable(true);
  MainMenuImage = loadImage("ArcadeBackground.png");
  ArcadeFont = createFont("ARCADE.TTF",20,true);
  ArcadeSolidFont = createFont("ARCADESOLID.TTF", 24 , true);
  
  size(500, 500);
  TSetup();
  SSetup();
  windowResize(500, 500);
}

public void draw() {
  if(selection == 0){
    windowResize(500,500);
    mainMenuDraw();
  }
  else if (selection == 1){
    windowResize(500, 500);
    TDraw();
  }
  else if (selection == 2){
    
    windowResize(1080, 720);
    SDraw();
  }
}

public void mousePressed() {
  TMousePressed();
}

public void keyPressed() {
  if(selection == 0 && keyCode == 84){
    selection = 1;   
    cellsLeft = 9;
    game = 1;
    TSetup();
  }
  else if (selection == 0 && keyCode == 83){
    selection = 2;
    SSetup();
  }
  else if (selection == 1){
    TKeyPressed();
  }
  else if (selection == 2){
    SnakeKeyPressed();
  }
}

public void mainMenuDraw(){
    fill(255);
    image(MainMenuImage, 0 , 0, width, height);
    textFont(ArcadeSolidFont);
    text("Main Menu" , width/2 - width/5, height/3.3);
    textFont(ArcadeFont);
    text("TicTacToe [T]", width/2 - width/4.3, height/2.3);
    text("Snake [S]" , width/2 - width/6, height/2);
  
}
