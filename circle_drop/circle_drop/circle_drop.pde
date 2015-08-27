/**
 * Simple exercise to get the juices flowing.
 *
 */
 
 static final color BACKGROUND_COLOR    = #B0C4DE;
 static final color CIRCLE_FILL_COLOR_A = #CBCBCB;
 static final color CIRCLE_FILL_COLOR_B = #999999;
 static final color CIRCLE_STROKE_COLOR = #333333;
 static final color POINT_COLOR         = #000080;
 static final color RADIUS_COLOR        = #4682B4;
 
 static final int APP_WIDTH  = 800;
 static final int APP_HEIGHT = 550;
 
 static final PVector ACCELERATION = new PVector(0,0.08);
 static final int POINT_DIAMETER   = 3;

class Circle {
  PVector location;
  PVector velocity  = new PVector(0,0);
  float   radius    = 0;
  boolean radiusSet = false;
  color   fillColor = CIRCLE_FILL_COLOR_A;
  
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
    fillColor = CIRCLE_FILL_COLOR_B;
  }
  
  // the rendering function for the circle
  void draw() {
    // draw circle
    stroke(CIRCLE_STROKE_COLOR);
    fill(fillColor);
    ellipse(location.x, location.y, radius * 2, radius * 2);
    
    if (!radiusSet) {
      // draw circle center point
      fill(POINT_COLOR);
      ellipse(location.x, location.y, POINT_DIAMETER, POINT_DIAMETER);
      // draw mouse point
      ellipse(mouseX, mouseY, POINT_DIAMETER, POINT_DIAMETER);
      // draw circle radius
      stroke(RADIUS_COLOR);
      line(location.x, location.y, mouseX, mouseY);
      noStroke();
    }
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
  newCircle.changeRadius(r);
}

void mouseReleased() {
  Circle newCircle = circles.get(circles.size() - 1);
  newCircle.setRadius();
}
