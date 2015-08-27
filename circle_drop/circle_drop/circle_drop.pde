/**
 * Simple exercise to get the juices flowing.
 *
 */
 
 static final color BACKGROUND_COLOR    = #999966;
 static final color CIRCLE_FILL_COLOR   = #CBCBCB;
 static final color CIRCLE_STROKE_COLOR = #AAAAAA;
 
 static final int APP_WIDTH  = 800;
 static final int APP_HEIGHT = 550;
 
 static final PVector ACCELERATION = new PVector(0,0.05);

class Circle {
  PVector location;
  PVector velocity  = new PVector(0,0);
  float   radius    = 0;
  boolean radiusSet = false;
  
  Circle(float x, float y) {
    location = new PVector(x, y);
  }
  
  void changeRadius(float radius) {
    this.radius = radius;
  }
  
  void setRadius() { radiusSet = true; }
  
  void draw() {
    ellipse(location.x, location.y, radius, radius);
  }
  
  void fall() {
    if (radiusSet) {
      velocity.add(ACCELERATION);
      location.add(velocity);
    }
  }
  
  // must the circle exist?
  boolean offScreen() {
    float lowestRenderVal = location.y - radius;
    return lowestRenderVal > APP_HEIGHT;
  }
}



ArrayList<Circle> circles;

void setup() {
  size(APP_WIDTH, APP_HEIGHT);
  stroke(CIRCLE_STROKE_COLOR);
  fill(CIRCLE_FILL_COLOR);
  circles = new ArrayList<Circle>();
}

void draw() {
  background(BACKGROUND_COLOR);
  
  Circle c;
  for(int i = 0; i < circles.size(); i++) {
    c = circles.get(i);
    c.fall();
    if (c.offScreen()) {
      circles.remove(i);
    } else {
      c.draw();
    }
  }
}

void mousePressed() {
  int x = mouseX;
  int y = mouseY;
  Circle c = new Circle(x, y);
  float r;
  while(mousePressed) {
    r = dist(x, y, mouseX, mouseY);
    c.changeRadius(r);
  }
  c.setRadius();
}
