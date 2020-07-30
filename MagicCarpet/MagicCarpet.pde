void setup() {
  size(600, 600, P3D);
  noFill();
  stroke(255);
  cols = width/res;
  rows = height/res;
  terrain = new float[cols][rows];
}

int cols;
int rows;
int res = 20;
float noiseStart = 0;
float[][] terrain;
int w = 1000;
int h = 500;

void draw() {
  background(51);

  translate(0, height/2);
  rotateX(PI/2.8);
  translate(0, -height/2);

  float xOff = noiseStart;
  for (int i = 0; i < rows; i++) {
    float yOff = 0;
    for (int j = 0; j < cols; j++) {
      terrain[j][i] = map(noise(xOff, yOff), 0, 1, -50, 50);
      yOff+=0.1;
    }
    xOff+=0.1;
  }
  noiseStart-=0.1;

  for (int i = 0; i < rows-1; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < cols; j++) {
      vertex(j*res, i*res, terrain[j][i]);
      vertex(j*res, (i+1)*res, terrain[j][i+1]);
    }
    endShape();
  }

  println(frameRate);
}
