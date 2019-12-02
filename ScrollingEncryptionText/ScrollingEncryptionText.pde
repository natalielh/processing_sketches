String txt;
String txt2;
String txt3;
float y = 0;
float d = 0;

void setup () {
  size (580, 600);
  frameRate(10);
  String[] lines = loadStrings("encryptiontext2.txt");
  txt = join(lines, "\n");
  
  String[] lines2 = loadStrings("encryptiontext2.txt");
  txt2 = join(lines2, "\n");
  
  String[] lines3 = loadStrings("encryption3.txt");
  txt3 = join(lines3, "\n");
}

  void draw() {
  background(0);
  
  
  //green encryption text
  pushStyle();
  fill(0,255,0);
  textSize(12);
  textAlign(LEFT);
  PFont Courier = createFont("Courier", 12);
  textFont(Courier);
  text(txt, 0, y);
  blendMode(LIGHTEST);
  y = y - 10;
  popStyle();
  
  
  //pushStyle();
  ////yellow encryption text
  //textFont(Courier);
  ////yellow
  //fill(249,245,100);
  ////turquoise
  //fill(128,255,234);
  //tint(200, 200); 
  //textSize(random(50,80));
  //text(txt2, 4, d);
  //d = d - 5;
  //popStyle();
 
 
  pushStyle();
  //unicode encryption text
  textFont(Courier);
  //yellow
  fill(249,245,100);
  //turquoise
  //fill(128,255,234);
  tint(200, 200); 
  textSize(random(10,50));
  text(txt3, 4, d);
  d = d - 2;
  popStyle();
  
  
}
