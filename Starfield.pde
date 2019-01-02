ArrayList<Particle> p = new ArrayList<Particle>();
ArrayList<Particle> p2 = new ArrayList<Particle>();
ArrayList<JumboParticle> p3 = new ArrayList<JumboParticle>();
boolean normalParticle = false;
boolean jumboParticle = false;
int r = 0;
int g = 0;
int b = 0;
int counter = 0;
int stopper = 0;
int interval = 0;
boolean shrink = false; // Used in jumbo
int counter2 = 0; // Used in jumbo
double newX = 0; // Jumbo
double newY = 0; // Jumbo
double newSpd = 0; // Jumbo
int newSiz = 0; // Jumbo
double newAng = 0; // Jumbo
void setup() {
  noStroke();
  background(0);
  size(1000, 800);
  frameRate(60);
}
void draw() { 
  interval++;
  if (interval == 90) {
    interval = 0;
    jumboParticle = true;
    for (int q = 0; q < 21; q++) {
      p3.add(new JumboParticle(q * ((Math.PI * 2)/20), 5, 5, 500, 400));
    }
  }
  fill(0, 0, 0, 10);
  rect(0, 0, 1000, 800);
  if (normalParticle == true)
  {
    explosion();
  }
  //if (jumboParticle == true) {
    for (int i = 0; i < p3.size(); i++) {
      p3.get(i).move();
      p3.get(i).grow();
      newX = p3.get(i).getXpos();
      newY = p3.get(i).getYpos();
      newSpd = p3.get(i).getSpeed();
      newSiz = p3.get(i).getSize();
      newAng = p3.get(i).getAngle();
      p3.set(i, (new JumboParticle(newAng, newSpd, newSiz, newX, newY)));
      p3.get(i).show();
    }
 // }
}

void explosion() {
  while (counter < 49) {
    counter++;
    if (counter < 21) {
      p.get(counter).move();
    }
    p2.get(counter).move();
    if (counter < 21) {
      p.get(counter).show();
    }
    p2.get(counter).show();
  }
  stopper++;
  counter = 0;
  if (stopper == 49) {
    normalParticle = false;
    reset();
  }
}

void reset() {
  stopper = 0;
  counter = 0;
  jumboParticle = false;
  for (int z = 0; z < 50; z++) {
    if (z < 21) {
      p.remove(0);
    }
    p2.remove(0);
  }
  for (int z = 0; z < p3.size(); z++) {
    p3.remove(z);
  }
}

interface Particle {
  void move();
  void show();
}

class NormalParticle implements Particle {
  double x;
  double y;
  double speed;
  double angle;
  int size;
  public NormalParticle(double ang, double spd, int siz, double xpos, double ypos) {
    angle = ang;
    speed = spd;
    size = siz;
    x = xpos;
    y = ypos;
  }

  void move() {
    x += Math.cos(angle) * speed;
    y += Math.sin(angle) * speed;
    angle += .125;
  }
  void show() {
    fill(r, g, b);
    ellipse((float)x, (float)y, size, size);
  }
}
class OddballParticle implements Particle {
  void move() {
  }
  void show() {
  }
}

class JumboParticle extends NormalParticle {

  double x;
  double y;
  double speed;
  double angle;
  int size;
  public JumboParticle (double ang, double spd, int siz, double xpos, double ypos) {
    super(ang, spd, siz, xpos, ypos);
  }
  void grow() {
    if (shrink == false) {
      counter2++;
      super.size += 2;
      super.speed--;
      if (counter == 5) {
        shrink = true;
      }
    }
    if (shrink == true) {
      counter2--;
      super.speed++;
      super.size -= 2;
      if (counter2 == 0) {
        shrink = false;
      }
    }
  }
  int getSize() {
    return super.size;
  }
  double getSpeed() {
    return super.speed;
  }
  double getXpos() {
    return super.x;
  }
  double getYpos() {
    return super.y;
  }
  double getAngle() {
    return super.angle;
  }
}

void mousePressed() {
  if (normalParticle == false) {
    r = round(random(255));
    g = round(random(255));
    b = round(random(255));
    normalParticle = true;
    for ( int z = 0; z < 50; z++) {
      if (z < 21) {
        p.add(new NormalParticle(z * ((Math.PI * 2)/20), 5, 20, mouseX, mouseY));
      }
      p2.add(new NormalParticle(z + 5 * ((Math.PI * 2)/20), 10, 50, mouseX, mouseY));
    }
  }
}
