class Particle {

  PVector xBounds, yBounds;
  PVector loc;
  PVector vel;
  PVector acc;
  float maxSpeed;
  float alpha;
  float r, g, b;
  float rad;
  float time;
  float maxTime;
  int lap;
  int maxLaps = 10;
  boolean alive;

  Particle() {
    alive = true;
    lap = 0;
    resetEverything();
  }

  void applyForce(PVector force_) {
    acc.add(force_);
  }

  void update() {
    vel.limit(maxSpeed);
    vel.add(acc);
    loc.add(vel);
    //acc.mult(0); //0 speed
    time+=0.1;
  }

  void show() {
    stroke(0); //white
    strokeWeight(0.1);
    fill(r, g, b); //rainbow
    ellipse(loc.x, loc.y, rad, rad);
  }

  void checkEdges() {
    if (time > maxTime) {
      resetEverything();
    }
    if (loc.x > xBounds.y) {
      //loc.x = 0;
      resetEverything();
    }
    if (loc.x < xBounds.x) {
      //loc.x = width;
      resetEverything();
    }
    if (loc.y > yBounds.y) {
      //loc.y = 0;
      resetEverything();
    }
    if (loc.y < yBounds.x) {
      //loc.y = height;
      resetEverything();
    }
  }

  void resetEverything() {
    if (lap < maxLaps) {
      xBounds = new PVector(random(90,110), random(width-110, width-90));
      yBounds = new PVector(random(90,110), random(height-110, height-90));
      loc = new PVector(random(100,width-100), random(100, height-100));
      vel = new PVector(0, 0);
      acc = new PVector(0, 0);
      alpha = 0;
      maxSpeed = 1;
      r = random(50, 80);
      g = random(50, 80);
      b = random(30,70);
      rad = random(1, 5);
      time = 0;
      maxTime = random(1,3);
      lap++;
    }
    else{
      alive = false;
    }
  }

  /*void sortAlpha() {
   float aInc = 0.2;
   float maxA = 10;
   if (loc.x > width-100 && vel.x > 0) {
   alpha-=aInc;
   } else if (loc.x < 100 && vel.x < 0) {
   alpha-=aInc;
   } else if (alpha < maxA) {
   alpha+=0.1;
   }
   }*/
}
