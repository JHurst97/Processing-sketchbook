
void setup() {
  size(400, 400);
  background(255);
  map = new int[width][height];
  for (int i=0; i < height; i++) {
    for (int j=0; j < width; j++) {
      map[j][i] = 0;
    }
  }

  for (int n = 0; n < 20; n++) {
    ants.add(new Ant((int)random(0, width), (int)random(0, height)));
  }
}

Ant ant;
ArrayList<Ant> ants = new ArrayList<Ant>();
int moves = 0;
int[][] map;
int currX;
int currY;

void draw() {
  for (int speed = 0; speed < 50; speed++) {
    for (int currAnt = 0; currAnt < ants.size(); currAnt++) {
      currX = ants.get(currAnt).getX();
      currY = ants.get(currAnt).getY();
      int state = map[currX][currY];
      if (state == 1) {
        ants.get(currAnt).turnLeft();
        map[currX][currY] = 0;
        ants.get(currAnt).moveForward();
        ants.get(currAnt).show(state);
      } else if (state == 0) {
        ants.get(currAnt).turnRight();
        map[currX][currY] = 1;
        ants.get(currAnt).moveForward();
        ants.get(currAnt).show(state);
      }
    }
  }

  moves++;
  println(moves);
  //loadPixels();
  //for (int i = 0; i < height; i++) {
  //  for (int j=0; j < width; j++) {
  //    int index = i * width + j;
  //      if (map[currX][currY] == 0) {
  //      pixels[index] = color(0);
  //    } else {
  //      pixels[index] = color(255);
  //    }
  //  }
  //}

  //updatePixels();
}
