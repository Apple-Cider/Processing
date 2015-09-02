/**
 * Clock.
 * 
 * Shows time.
 *
 */
 
Clock clock;

void setup() {
  size(600,600, P2D);
  clock = new AnalogClock();
  clock.setup();
}

void draw() {
  background(200);
  clock.draw();
}


interface Clock {
  public void setup();
  public void draw();
}

class AnalogClock implements Clock {
  int diameter;
  PShape hourHand, minuteHand, secondHand;
  
  public void setup() {
    diameter   = (width < height ? width : height) * 4 / 5;
    hourHand   = createHand(0.25, 0.1, #000000);
    minuteHand = createHand(0.375, 0.0625, #000000);
    secondHand = createHand(0.375, 0.0416, #FF0000);
  }
  
  public void draw() {
    resetMatrix();
    translate(width/2, height/2);
    rotate(PI);
    drawClock();
    drawHourHand();
    drawMinuteHand();
    drawSecondHand();
  }
  
  private void drawClock() {
    pushStyle();
    strokeWeight(5);
    stroke(#333333);
    ellipse(0, 0, diameter, diameter);
    popStyle();
    drawTicks();
  }
  
  private void drawTicks() {
    pushStyle();
    strokeWeight(2);
    stroke(#555555);
    pushMatrix();
    float angle = TWO_PI / 12.0;
    float tickLength  = diameter * 0.0625;
    float tickMargin  = diameter * 0.0625;
    for(int i = 0; i < 12; i++) {
      rotate(angle);
      line(0, diameter / 2 - tickMargin, 0, diameter / 2 - tickMargin - tickLength);
    }
    popMatrix();
    popStyle();
  }
  
  private void drawSecondHand() {
    int s = second(); // [0, 59]
    float t = s / 60.0;
    drawHand(t, secondHand);
  }
  
  private void drawMinuteHand() {
    int m = minute(); // [0, 59]
    float t = m / 60.0;
    drawHand(t, minuteHand);
  }
  
  private void drawHourHand() {
    int h = hour();   // [0, 23]
    int m = minute(); // [0, 59]
    h %= 12;
    float t = (h + m / 60.0) / 12.0;
    drawHand(t, hourHand);
  }
  
  PShape createHand(float h, float b, color c) {
    float x1 = diameter * b / 2,
          y1 = 0,
          x2 = 0,
          y2 = diameter * h,
          x3 = diameter * b / 2 * -1,
          y3 = 0;
    PShape shape = createShape(TRIANGLE, x1, y1, x2, y2, x3, y3);
    shape.setStroke(c);
    shape.setFill(c);
    return shape;
  }
  
  private void drawHand(float t, PShape hand) {
    pushMatrix();
    float angle = TWO_PI * t;
    rotate(angle);
    shape(hand);
    popMatrix();
  }
  
}
