private ArrayList<PVector> snake = new ArrayList<PVector>(); // snake body (not included the head)
private PVector pos; // snake position (position of the head)


private PVector food; // food position

private PVector dir = new PVector(0, 0); // snake direction (up, down, left right)

private int size = 40; // snake and food square size
private int w, h; // how many snakes can be allocated

private int spd = 7; // reverse speed (smaller spd will make the snake move faster)
private int len = 4; // snake body

private PImage SBackground;

private int endState; // 0 is not ended, 1 is ended 



public void SSetup(){
  windowResize(1080, 720);
  w = width/size;
  h = height/size;
  
  rectMode(CORNER);
  
  endState = 0;
  
  SBackground = loadImage("SnakeBackground.png");
  
  pos = new PVector(w/2, h/2); // Initial snake position
  newFood(); // create 2D vector
  
 
  
  
  
  noStroke();
  fill(0);
}

public void SDraw(){
  image(SBackground, 0 , 0, width, height);
  if(endState == 0){
    fill(247,177,245);
    textAlign(CENTER);
    text("Score: " + (len - 4), width/2 , height/2 -19);
    drawSnake();
    drawFood();
  }
  else if (endState == 1){
    drawEndScreen();
    
  }
  
  
  // update snake if frameCount is a multiple of spd which is 20 at the begining
  if(frameCount % spd == 0) {
    updateSnake();   
  }
}

private void drawEndScreen(){ 
  fill(175,82,172);
  textSize(40);
  textAlign(CENTER);
  text("GAME OVER!" , width/2, height/2 - height/4);
  textSize(30);
  text("Your Score: " + (len - 4), width/2 , height/4 + height/6);
  fill(255);
  text("Restart [ENTER]", width/2, height/1.75);
  text("Main Menu [M]", width/2 , height /1.5);
}

private void drawFood() {
  fill(189  , 128, 167); 
  rect(food.x * size, food.y * size, size, size); 
}

private void drawSnake() {
    fill(115,10,112); // set the snake color
    noStroke();
    rect(pos.x * size, pos.y * size, size, size); // draw the snake head square at the current position
    
    
    fill(247,177,245);; // set the snake color
    
    for(PVector bodyPart : snake) { // iterate over the snake body parts
      rect(bodyPart.x * size, bodyPart.y * size, size, size); // draw each body part square at its position
    }
}

private void updateSnake() {
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
    if(spd!=4){
      spd -= 0.5;
    }
    
  }
  // If snake (head) eat itself, gameover, reset()
  for(PVector bodyPart: snake){
    if (bodyPart.x == pos.x && bodyPart.y == pos.y && len > 3 && (dir.x !=0 || dir.y !=0)){
      endState = 1;
    }
  }
  
  for(PVector bodyPart: snake){
    if (bodyPart.x <= 0 || bodyPart.x * (size + 1) >= width || bodyPart.y * (size + 1) >= height || bodyPart.y <= 0 ){
      
      endState = 1;
    }
  }
  
}

private void reset() {
  spd = 7;
  len = 4;
  pos = new PVector(w/2, h/2);
  dir = new PVector(0, 0);
  newFood();
  snake = new ArrayList<PVector>();
}

private void newFood() {
  food = new PVector(int(random(w)), int(random(h)));
}

private void SnakeKeyPressed() {
    
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
    
    else if (endState  == 1 && keyCode == 77){
      selection = 0;
      reset();
    }
    else if (endState == 1 && keyCode == ENTER){
      SSetup();
      selection = 2;
      reset();
    }
  
  
}
