class Particle {

  PVector startSpeed, speed;
  PVector loc;
  PVector vel;
  PVector acc;
  float  maxSpeed, angle, size, conDist, mouseRadius;

  Particle(PVector loc_) {
    loc = loc_;
    init();
  }

  void init() {
    startSpeed = new PVector(random(1, 5), random(-1, 1));
    speed = new PVector(startSpeed.x, startSpeed.y);
    vel = new PVector(speed.x, speed.y);
    angle = random(0, TWO_PI);
    size = 5;
    conDist = 50;
    mouseRadius = 75;
  }

  void update() {
    loc.add(vel);
    attract();
    checkEdges();
  }

  void show(ArrayList<Particle> particles, Particle currPar) {
    stroke(#89E520);
    strokeWeight(0.1);
    //ellipse(loc.x, loc.y, size, size);
    connect(particles, currPar);
  }

  void connect(ArrayList<Particle> particles, Particle currPar) {
    for (Particle p : particles) {
      if (p != currPar) {
        //distance from other particle
        float d = dist(loc.x, loc.y, p.loc.x, p.loc.y);
        if (d < conDist) {
          stroke(#89E520, map(d, 0, conDist, 255, 0));
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
    if (d < mouseRadius) {
      maxSpeed = 5;
      vel.limit(maxSpeed);
      PVector dir = PVector.sub(mouse, loc);
      dir.mult(1);
      acc = dir;
      vel.add(dir);
      vel.limit(maxSpeed);
      loc.add(vel);
    }
    vel.limit(startSpeed.x);
    if (d > mouseRadius) {
      vel.x = startSpeed.x;
    }
    if (loc.x > mouseX) {
      vel.y = startSpeed.y;
    }
  }
  
  void repel() {
    PVector mouse = new PVector(mouseX, mouseY);
    //distance from mouse
    float d = dist(mouseX, mouseY, loc.x, loc.y);
    //attraction
    if (d < mouseRadius) {
      maxSpeed = 5;
      vel.limit(maxSpeed);
      PVector dir = PVector.sub(mouse, loc);
      dir.mult(-1);
      acc = dir;
      vel.add(dir);
      vel.limit(maxSpeed);
      loc.add(vel);
    }
    vel.limit(startSpeed.x);
    if (d > mouseRadius) {
      vel.x = startSpeed.x;
    }
    if (loc.x > mouseX) {
      vel.y = startSpeed.y;
    }
  }

  void checkEdges() {
    if (loc.x < 0) {
      loc.x = width;
    } else if (loc.x > width) {
      loc.x = 0;
    } else if (loc.y < 0) {
      loc.y = height;
    } else if (loc.y > height) {
      loc.y = 0;
    }

    //bounce on edge:
    //if (loc.x > width || loc.x < 200) {
    //  vel.x = -vel.x;
    //}  
    //if (loc.y > height || loc.y < 0) {
    //  vel.y = -vel.y;
    //}
  }
}
