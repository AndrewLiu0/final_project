private ArrayList<PVector> snake = new ArrayList<PVector>(); // snake body (not included the head)
private PVector pos; // snake position (position of the head)

private StringList mode_list = new StringList(new String[] {"border", "no_border"}); // if you implement both functionalities
private int mode_pos = 1; // mode 1 by default - if hits wall wraps around
private String actual_mode = mode_list.get(mode_pos); // current mode name

private PVector food; // food position

private PVector dir = new PVector(0, 0); // snake direction (up, down, left right)

private int size = 40; // snake and food square size
private int w, h; // how many snakes can be allocated

private int spd = 10; // reverse speed (smaller spd will make the snake move faster)
private int len = 4; // snake body



public void SSetup(){
  windowResize(1080, 720);
  w = width/size;
  h = height/size;
  
  pos = new PVector(w/2, h/2); // Initial snake position
  newFood(); // create 2D vector
  
  noStroke();
  fill(0);
}

public void SDraw(){
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
