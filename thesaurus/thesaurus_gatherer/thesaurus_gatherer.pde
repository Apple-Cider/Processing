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

static final String apiKey = loadStrings("api_key.txt")[0];
static final String URL    = "http://words.bighugelabs.com/api/2/" + apiKey + "/";

void setup() {
  println("api key fetched: " + apiKey);
}

void draw() {
}
