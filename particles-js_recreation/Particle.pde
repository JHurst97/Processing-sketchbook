class Particle {

  PVector loc;
  float speed, angle, size, conDist;

  Particle() {
    init();
  }

  void init() {
    loc = new PVector(random(0, width), random(0, height));
    angle = random(0, TWO_PI);
    speed = 5;
    size = 5;
    conDist = 200;
  }

  void update() {
    loc.x += cos(angle) * speed;
    loc.y += sin(angle) * speed;
  }

  void show() {
    ellipse(loc.x, loc.y, size, size);
  }
}
