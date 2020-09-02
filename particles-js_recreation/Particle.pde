class Particle {

  PVector loc;
  PVector vel;
  PVector acc;
  float speed, maxSpeed, angle, size, conDist;

  Particle(PVector loc_) {
    loc = loc_;
    init();
  }

  void init() {
    speed = 1;
    vel = new PVector(random(-speed, speed), random(-speed, speed));
    angle = random(0, TWO_PI);
    size = 5;
    conDist = 75;
  }

  void update() {
    loc.add(vel);
    attract();
    checkEdges();
  }

  void show(ArrayList<Particle> particles, Particle currPar) {
    stroke(255);
    ellipse(loc.x, loc.y, size, size);
    connect(particles, currPar);
  }

  void connect(ArrayList<Particle> particles, Particle currPar) {
    for (Particle p : particles) {
      if (p != currPar) {
        //distance from other particle
        float d = dist(loc.x, loc.y, p.loc.x, p.loc.y);
        if (d < conDist) {
          stroke(255, map(d, 0, conDist, 255, 0));
          line(loc.x, loc.y, p.loc.x, p.loc.y);
        }
      }
    }
  }

  void attract() {
    PVector mouse = new PVector(mouseX, mouseY);

    //distance from mouse
    float d = dist(mouseX, mouseY, loc.x, loc.y);

    //attraction
    if (d < 100) {
      maxSpeed = 10;
      PVector dir = PVector.sub(mouse, loc);

      dir.normalize();

      dir.mult(-10);

      acc = dir;

      vel.add(dir);
      vel.limit(speed);
      loc.add(vel);
    }
    maxSpeed = 1;
  }

  void checkEdges() {
    if (loc.x > width || loc.x < 0) {
      vel.x = -vel.x;
    }  
    if (loc.y > height || loc.y < 0) {
      vel.y = -vel.y;
    }
  }
}
