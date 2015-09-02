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
  background(#B0C4DE);
  clock.draw();
}


interface Clock {
  public void setup();
  public void draw();
}
