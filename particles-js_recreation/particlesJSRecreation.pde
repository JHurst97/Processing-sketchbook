void setup() {
  size(1000, 500);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < total; i++) {
    particles.add(new Particle(new PVector(random(0, width), random(0, height))));
  }

  //framerate stuff
  fr = new FloatList();
}

ArrayList <Particle> particles;
int total = 50;
FloatList fr;
float average;

void draw() {
  background(51,51,51,1);

  for (Particle p : particles) {
    p.update();
    p.show(particles, p);
  }

  trackFramerate();
}

void trackFramerate() {
  fr.append(frameRate);
  float sum = 0;
  for (float f : fr)
  {
    sum += f;
  }
  average = sum/fr.size();
  println("FR: " + frameRate + ". AVG: " + average);
}

void mousePressed() {
  for (int i = 0; i < 1; i++) {
    particles.add(new Particle(new PVector(mouseX, mouseY)));
  }
}
void mouseDragged() {
  int r = (int) random(0, 15);
  if (r == 1) {
    for (int i = 0; i < 1; i++) {
      particles.add(new Particle(new PVector(mouseX, mouseY)));
    }
  }
}

void keyPressed() {
  saveFrame("output/line-######.png");
}
