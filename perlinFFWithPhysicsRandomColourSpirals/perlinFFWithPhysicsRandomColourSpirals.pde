void setup() {
  colorMode(HSB, 100);
  size(600, 1000);
  background(100);
  baseNoise = 0;
  rows = height/spacing;
  cols = width/spacing;
  ff = new FlowField(spacing);
  particles = new Particle[total];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
  calcAngles();
}

FlowField ff;
Particle[] particles;
int total = 2000;
int rows, cols;
int spacing = 10;
float baseNoise, time;
float inc = 0.01;

void draw() {
  //background(0);
  //ff.show();


  for (Particle p : particles) {
    if (p.alive) {
      PVector desired = new PVector(sin(ff.lookup(p.loc)), cos(ff.lookup(p.loc)));

      p.applyForce(desired.div(20));
      p.update();
      p.checkEdges();
      p.show();
    }
  }

  println(frameRate);
}

void alphaBackground(color c_, float alpha_) {
  fill(c_, alpha_);
  rect(-100, -100, width+100, height+100);
}

void calcAngles() {
  float xOff = 0;
  for (int i = 0; i < cols; i++) {
    float yOff = 0;  
    for (int j = 0; j < rows; j++) {
      float n = map(noise(xOff, yOff, baseNoise), 0, 1, 0, TWO_PI*4);
      ff.cells[i][j] = new PVector(i*spacing, j*spacing, n);
      yOff+=inc;
    }
    xOff+=inc;
    baseNoise+=0.00001;
  }
}


void keyPressed() {
  saveFrame("/output/line-######.png");
  println("screenshot!");
}
