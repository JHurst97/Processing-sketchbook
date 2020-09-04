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
int total = 100;
FloatList fr;
float average;

void draw() {
  background(20,20,20,1);
  fill(255);
  ellipse(mouseX,mouseY, 10,10);
  manageText();
  
  for (Particle p : particles) {
    p.update();
    p.repel();
    p.show(particles, p);
  }

  trackFramerate();
}

void manageText(){
  textSize(15);
  fill(255,100,100);
  text("Frame rate: " + (int)frameRate, 5, 15);
  text("Mouse affect: Repulse", 5, 30);
  text("# of particles: " + particles.size(), 5, 45);
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
