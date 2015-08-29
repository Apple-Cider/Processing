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

// REST request elements
String URL;
String entry = "";

// app UI
ControlP5 cp5;

void setup() {
  size(700,400);
  
  String apiKey = loadStrings("api_key.txt")[0];
  URL = "http://words.bighugelabs.com/api/2/" + apiKey + "/";
  
  initUI();  
}

void draw() {
  background(0);
  fill(255);
  //text(entry, 360, 200);
}

public void request() {
  entry = cp5.get(Textfield.class, "entry").getText();
  
  if (!entry.isEmpty()) {
    String request = URL + entry + "/json";
    println("Request issued. URL:");
    println(URL + entry + "/json");
  } else {
    println("entry field blank! can't look up a synonym for no word");
  }   
}

void initUI() {
  cp5 = new ControlP5(this);
  
  PFont font = createFont("Myrad Pro", 20);
  PFont labelFont = createFont("Myrad Pro", 12);
  textFont(font);
  
  cp5.addTextfield("entry")
     .setPosition(20, 170)
     .setSize(200, 40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
     .getCaptionLabel()
        .setFont(labelFont);
  
  cp5.addBang("request")
     .setPosition(240, 170)
     .setSize(80, 40)
     .getCaptionLabel()
        .align(ControlP5.CENTER, ControlP5.CENTER)
        .setFont(labelFont);
}
