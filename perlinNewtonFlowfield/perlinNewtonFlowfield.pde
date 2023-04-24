PVector[][] grid;
Particle[] particles;
int cols, rows;
int spc = 5;
int total = 75000;
PVector gravity;
float inc = 0.1;  
float baseNoise = 0;

void setup() {
    background(0);
    size(1000, 1000);
    pixelDensity(2);
    noStroke();
    colorMode(HSB, 255);
    gravity = new PVector(0.1, 0.1);
    cols = width / spc;
    rows = height / spc;
    grid = new PVector[cols][rows];
    
    particles = new Particle[total];
    for (int i = 0; i < particles.length; i++) {
        particles[i] = new Particle();
}
}

void draw() {
    // background(0);
    //fill(0,5);
    //rect(0,0,width,height);
    // println(frameRate);
    float xOff = noise(baseNoise);
    for (int i = 0; i < cols; i++) {
        float yOff = noise(baseNoise);
        for (int j = 0; j < rows; j++) {
            float theta = map(noise(xOff, yOff), 0, 1, 0, TWO_PI);
            grid[i][j] = new PVector(i * spc, j * spc, theta);
            yOff += inc;
        }
        xOff += inc;
}
    //baseNoise+=0.01;
    
    for (Particle p : particles) {
        
        p.follow(this);
        p.update();
        p.checkEdges();
        p.show();
}
println(frameCount);
// saveFrame("video3/img######.png");
}



float lookup(PVector lookup_) {
    int column = int(constrain(lookup_.x / spc, 0, cols - 1));
    int row = int(constrain(lookup_.y / spc, 0, rows - 1));
    return grid[column][row].z;
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode==LEFT) {
saveFrame("output/img######.png");
    } else if (keyCode==RIGHT) {
      println(2);
    }
  }
}