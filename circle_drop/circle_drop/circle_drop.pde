/**
 * Simple exercise to get the juices flowing.
 *
 */
 
 static final color BACKGROUND_COLOR    = #B0C4DE;
 static final color CIRCLE_FILL_COLOR   = #CBCBCB;
 static final color CIRCLE_STROKE_COLOR = #333333;
 static final color DEBUG_ALERT_A_COLOR = #FF0000;
 static final color DEBUG_ALERT_B_COLOR = #FFA500;
 
 static final int APP_WIDTH  = 800;
 static final int APP_HEIGHT = 550;
 
 static final PVector ACCELERATION = new PVector(0,0.08);

class Circle {
  PVector location;
  PVector velocity  = new PVector(0,0);
  float   radius    = 0;
  boolean radiusSet = false;
  
  // a circle is initalized with a center point, determined by the user's
  //    mouse coordinates when they clicked (when they chose to create a
  //    circle)
  Circle(float x, float y) {
    location = new PVector(x, y);
  }
  
  // changeRadius, a setter, is called because a user created this circle,
  //    but hasn't decided how large it ought to be (hasn't let go of the
  //    mouse button)
  void changeRadius(float radius) {
    this.radius = radius;
  }
  
  // setRadius is called when a user releases their mouse click,
  //    signifying the circle has the desired radius
  void setRadius() {
    radiusSet = true;
  }
  
  // the rendering function for the circle
  void draw() {
    ellipse(location.x, location.y, radius * 2, radius * 2);
    if (!radiusSet) line(location.x, location.y, mouseX, mouseY);
  }
  
  // once a mouse lets go of a circle, gravity, like time or hunger, becomes
  //   a merciless force that brings the circle to its death
  void fall() {
    if (radiusSet) {
      velocity.add(ACCELERATION);
      location.add(velocity);
    }
  }
  
  // used to determine if the circle should be removed from memory
  boolean offScreen() {
    float lowestRenderVal = location.y - radius;
    //println("  circle off screen? " + (lowestRenderVal > APP_HEIGHT));
    return (lowestRenderVal > APP_HEIGHT);
  }
}


// PROGRAM BEHAVIOR

ArrayList<Circle> circles;

void setup() {
  size(APP_WIDTH, APP_HEIGHT);
  circles = new ArrayList<Circle>();
}

void draw() {
  background(BACKGROUND_COLOR);
  stroke(CIRCLE_STROKE_COLOR);
  fill(CIRCLE_FILL_COLOR);
  
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


// CIRCLE CREATION EVENTS

void mousePressed() {
  Circle newCircle = new Circle(mouseX, mouseY);
  circles.add(newCircle);
}

void mouseDragged() {
  Circle newCircle = circles.get(circles.size() - 1);
  float x = newCircle.location.x;
  float y = newCircle.location.y;
  float r = dist(x, y, mouseX, mouseY);
  //line(x, y, mouseX, mouseY);
  newCircle.changeRadius(r);
  debugMouseDragged(mouseX, mouseY);
}

void mouseReleased() {
  Circle newCircle = circles.get(circles.size() - 1);
  newCircle.radiusSet = true;
}

void debugMouseDragged(int mX, int mY) {
  Circle newCircle = circles.get(circles.size() - 1);
  float x = newCircle.location.x;
  float y = newCircle.location.y;
  float r = dist(x, y, mX, mY);
  
  noStroke();
  fill(DEBUG_ALERT_A_COLOR);
  ellipse(x, y, 2, 2);
  ellipse(mX, mY, 2, 2);
  //stroke(DEBUG_ALERT_B_COLOR);
  //line(x, y, mX, mY);
  
  //println("radius change: " + r);
}
