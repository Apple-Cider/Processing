// The essence of any spaghetti dinner

class Noodle {
  static final double LENGTH    = 20;
  static final double L_W_RATIO = 0.01;
  static final double WIDTH     = LENGTH * L_W_RATIO;
  static final int MAX_SEGMENTS = 4;
  
  // initial points
  double x;
  double y;
  // how long did the noodle get cooked? [0,1]
  // (affects curvature)
  double softness;
  // parametric equations comprising noodle
  ArrayList<NoodleSegment> segments;
  
  void draw() {
    
  }
}
