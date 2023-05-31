class Cell {
  private int x; // x coord of top left
  private int y; // y coord of top left
  private int w; // width of cell
  private int h; // height of cell
  private int state= 0; // 0 is empty, 1 is circle, 2 is X
  
  // constructor 
   Cell (int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void setState(int x){
    state = x;
  }
  
  // getter methods
  public int getState() {
    return state;
  }
  
  public boolean isEmpty(){
    return state == 0;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public void clear() {
    state = 0;
    cellsLeft -= 1;
  }
  
  private void display() {
    // drawing out the cell
    noFill();
    stroke(255);
    strokeWeight(3);
    rect(x, y, w, h);
    
    // draw out the circle
    if (state == 1) {
      ellipseMode(CORNER);
      stroke(0, 0, 255);
      ellipse(x + width/12, y + height/12, w/2, h/2);
    } 
    //  draw out the x
    else if ( state == 2) {
      stroke(255, 0, 0);
      line(x + width/12, y + height/12, x+w - width/12, y+h - height/12);
      line(x+w - width/12, y + height/12, x + width/12, y+h - height/12);
    }
  }

  private void click(int px, int py) {
    // if mouseClick is on the cell and the cell is empty
    if (px > x && px < x+w && py > y && py < y+h && state == 0) {
      if (player == 0) {
        state = 1;
        cellsLeft -= 1;
        player = 1;
      } else if (player == 1) {
        state = 2;
        cellsLeft -= 1;
        player = 0;
        
      }
      // if one player mode, make a move
      if(mode == 1 && cellsLeft >0){
          //delay(200);
          randomPlayMove();
       }
    }
  }



  
}
