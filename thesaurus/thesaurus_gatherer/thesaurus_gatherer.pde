/**
 * Builds a synonmy graph for a word
 *
 * Takes an input word and a maximum diameter,
 * then recursively searches for synonyms, using
 * them to build a graph. Will be tree-ish, giving
 * special designation to edges that point to words
 * already discovered in earlier iterations.
 * 
 * Thesaurus service provided by words.bighugelabs.com
 */

import controlP5.*;

// request strings
String apiKey;
String URL;
String entry = "";

// app ui
ControlP5 cp5;
PFont font   = createFont("Myrad Pro", 20);

void setup() {
  size(700,400);
  
  apiKey = loadStrings("api_key.txt")[0];
  URL = "http://words.bighugelabs.com/api/2/" + apiKey + "/";
  //println("api key fetched: " + apiKey);
  
  cp5 = new ControlP5(this);
  
  cp5.addTextfield("entry")
     .setPosition(20,170)
     .setSize(200,40)
     .setFont(font)
     .setAutoClear(false);
  
  textFont(font);     
}

void draw() {
  background(0);
  fill(255);
  text(entry, 360, 180);
}


void controlEvent(ControlEvent event) {
  println("got control event from ctrler w/ id " + event.getController().getId());
  
  if (event.isFrom(cp5.getController("entry"))) {
    println("this event was triggered by Controller \"entry\"");
    println("  ... the new value for String \"entry\" is: " + entry);
  }
}
