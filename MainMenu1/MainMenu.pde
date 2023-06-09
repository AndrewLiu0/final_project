

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
  PSetup();
  windowResize(500, 500);
}

public void draw() {
  if(selection == 0){
    windowResize(500,500);
    mainMenuDraw();
  }
  else if (selection == 1){
    rectMode(CORNER);
    windowResize(500, 500);
    TDraw();
  }
  else if (selection == 2){
    windowResize(1080, 720);
    SDraw();
  }
  else if (selection == 3){ 
    windowResize(800, 400);
    PDraw();
  }
  else if  (selection == 4){
    windowResize(400,400);
    MDraw();
  }
}


public void mousePressed() {
  if(selection == 1){
    TMousePressed();
  }
  else if (selection == 4){
    MMousePressed();
  }
}

public void keyPressed() {
  textAlign(LEFT);
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
  else if (selection == 0 && keyCode == 80){
    selection = 3;
    PSetup();
  }
  else if (selection == 0 && keyCode == 87){
    selection = 4;
    MSetup();
  }
  else if (selection == 1){
    TKeyPressed();
  }
  else if (selection == 2){
    SnakeKeyPressed();
  }
  else if (selection == 3){
    PKeyPressed();
  }
  else if (selection == 4){
    MKeyPressed();
  }
  
  
}

public void mainMenuDraw(){
    fill(255);
    image(MainMenuImage, 0 , 0, width, height);
    textFont(ArcadeSolidFont);
    text("Main Menu" , width/2 - width/5, height/3.3);
    textFont(ArcadeFont);
    text("TicTacToe [T]", width/2 - width/4.3, height/2.3);
    text("Snake [S]" , width/2 - width/6, height/2.05);
    text("2P Pong [P]", width/2- width/5, height/1.82);
    textSize(17);
    text("Whac-A-Mole [W]" , width/2 - width/4 + 10, height/1.65);
}
