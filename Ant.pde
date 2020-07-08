class Ant {

  int x;
  int y;
  int dir;
  int north = 0;
  int east = 1;
  int south = 2;
  int west = 3;

  Ant(int x_, int y_) {
    x = x_;
    y = y_;
    dir = 0;
  }

  void show(int state_){
    if(state_ == 0){
      stroke(0);
    }
    if(state_ == 1){
      stroke(255);
    }
    point(x,y);
  }

  void turnLeft() { //<>// //<>//
    dir--;
    if (dir < 0) {
      dir = 3;
    }
    if (dir > 3) {
      dir = 0;
    }
  }

  void turnRight() {
    dir++;
    if (dir < 0) {
      dir = 3;
    }
    if (dir > 3) {
      dir = 0;
    }
  }

  void moveForward() {
    if (dir == 0) {
      y--;
    }
    if (dir == 1) {
      x++;
    }
    if (dir == 2) {
      y++;
    }
    if (dir == 3) {
      x--;
    }
    checkEdges();
  }
  
  void checkEdges(){
    if(x < 1){
      x = width -1;
    }
    if(y < 1){
      y = height -1;
    }
    if(x > width - 1){
      x = 1;
    }
    if(y > height -1){
      y = 1;
    }
    
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }
}
