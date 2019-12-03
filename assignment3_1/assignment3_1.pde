
////////////////////////
/////   LIBRARIES  /////
////////////////////////
import java.util.Arrays;
import ddf.minim.analysis.*;
import ddf.minim.*;

////////////////////////
///// DECLARATIONS /////
////////////////////////

// CERTAIN VISUALS ON / OFF  //
boolean displaySoundVizOn = true;
boolean displayEncTextOn = true;
boolean displayModelsOn = false;
boolean displayTitleOn = true;
boolean displayTitleBOn = false;
boolean displayTitleCOn = false;

//  AUDIO DECLARATIONS  //
Minim minim;
AudioPlayer jingle;
AudioInput input;
FFT fft;
int[][] colo=new int[300][3];

//  SCROLLING ENCRYPTION TEXT DECLARATIONS  //
String txt;
String txt2;
String txt3;
float yText = 0;
float dText = 0;
PFont Courier;

//  LOADING BAR DECLARATIONS  //
int barI= 0;
int barTimer = 0;
String Loading;

//  MODEL DECLARATIONS  //
float time = 0, timeFree = 0;
float progress = 1;

//  IMAGE  //
PImage titlepic;
PImage titlepicB;
PImage titlepicC;

class Vec3 {
  public float x, y, z;
}
class Ind3 {
  public int x, y, z;
}

String[] objLines;
Vec3[] vertices = new Vec3[0];
Ind3[] faces = new Ind3[0];

//void setupObj() {
//  objLines = loadStrings("car_03.obj"); //load in 3D model
//  processData();
//}

////////////////////////
/////     SETUP    /////
////////////////////////
void setup() {
  //  MODEL SETUP  //
  int selector = int(random(0, 10));  //local var to select a random model at start
  switch(selector){
  case 0:
    objLines = loadStrings("CO2_02.obj");
    break;
  case 1:
    objLines = loadStrings("tesla.obj");
    break;
  case 2:
    objLines = loadStrings("explosion.obj");
    break;
  case 3:
    objLines = loadStrings("lamp.obj");
    break;
  case 4:
    objLines = loadStrings("clothes.obj");
    break;
  case 5:
    objLines = loadStrings("sofa.obj");
    break;
  case 6:
    objLines = loadStrings("chair.obj");
    break;
  case 7:
    objLines = loadStrings("chair2.obj");
    break;
  default:
    objLines = loadStrings("CO2_02.obj");
    break;
  }
  
  // the first model that appears
  //objLines = loadStrings("CO2_02.obj");
  //objLines = loadStrings("car_03.obj");  //don't use
  processData();  //always process the data after loading in to objLines

  //  SOUND SETUP  //
  minim = new Minim(this);
  input = minim.getLineIn();
  fft = new FFT(input.bufferSize(), input.sampleRate());

  //  SCROLLING ENC. TEXT SETUP  //
  String[] lines = loadStrings("encryptiontext2.txt");
  txt = join(lines, "\n");

  String[] lines2 = loadStrings("encryptiontext2.txt");
  txt2 = join(lines2, "\n");

  String[] lines3 = loadStrings("encryption3.txt");
  txt3 = join(lines3, "\n");


  //  TEXT SETUP  //
  Courier = createFont("Courier", 12);
  
  //  TITLE IMAGE  //
  titlepic = loadImage("Assignment3_TextBackground.png");
  titlepicB = loadImage("Assignment3_TextBackgroundSOFTWAREUPDATES.png");
  titlepicC = loadImage("Assignment3_TextBackgroundENCRYPTION.png");


  //  SKETCH SETUP  //
  //size(displayWidth, displayHeight, P3D);  //take up the whole screen
  size(720, 900, P3D);  //poster size
  //frameRate(30);  //lower framerate if it gets too laggy
  smooth(5);  //adds a little lag but makes the screen look more smooth
}

/////////////////////////////////////////////////////
/////     USER INPUT: KEY RELEASED, NOT HELD    /////
/////////////////////////////////////////////////////
void keyReleased() {
  //BUTTON CONTROLS
  switch(key) {
  case '1':
    println("KEY PRESSED: " + key);
    objLines = loadStrings("CO2_02.obj"); //load in 3D model
    processData();
    break;
  case '2':
    println("KEY PRESSED: " + key);
    objLines = loadStrings("lamp.obj"); //load in 3D model
    processData();
    break;
  case '3':
    println("KEY PRESSED: " + key);
    objLines = loadStrings("explosion.obj"); //load in 3D model
    processData();
    break;
  case '4':
    println("KEY PRESSED: " + key);
    objLines = loadStrings("clothes.obj"); //load in 3D model
    processData();
    break;
  case '5':
    println("KEY PRESSED: " + key);
    objLines = loadStrings("tesla.obj"); //load in 3D model
    processData();
    break;
  case '6':
    println("KEY PRESSED: " + key);
    objLines = loadStrings("chair.obj"); //load in 3D model
    processData();
    break;
  case 'q':
    println("KEY PRESSED: " + key);
    displaySoundVizOn = !displaySoundVizOn;
    break;
  case 'w':
    println("KEY PRESSED: " + key);
    displayEncTextOn = !displayEncTextOn;
    break;
  case 'e':
    println("KEY PRESSED: " + key);
    displayModelsOn = !displayModelsOn;
    break;
  case 'r':
    println("KEY PRESSED: " + key);
    displayTitleOn = !displayTitleOn;
    //clearData();
    break;
  case 't':
    println("KEY PRESSED: " + key);
    displayTitleBOn = !displayTitleBOn;
    //clearData();
    break;
  case 'y':
    println("KEY PRESSED: " + key);
    displayTitleCOn = !displayTitleCOn;
    //clearData();
    break;
  }
}

////////////////////////
/////     DRAW     /////
////////////////////////
void draw() {
  
  fill(0, 125); //clear canvas for next frame //MOVED OUT OF THE MODELS SECTION
  rect(0, 0, width, height);  //clear canvas for next frame //MOVED OUT OF THE MODELS SECTION

  //  SOUNDWAVE AUDIO VISUALIZER  //
  if (displaySoundVizOn) {
    fft.forward(input.mix);
    for (int j = 0; j < fft.specSize() + displayWidth; j += 2) {
      //fill(0);
      //strokeWeight(1);
      //stroke(0,255,200);
      fill(0, 255, 200, 150);
      //blendMode(LIGHTEST);
      ellipse(j, height-150, 3, fft.getBand(j) * 200);
      
      if(j > 8 && fft.getBand(j) > 25){
        displayModelsOn = true;
      }
      //turn on the display of models
    }
  }

  //  ENCRYPTION TEXT VISUALIZER  //
  //if(displayEncTextOn && frameCount % 10 == 0){  //tried to slow it down, still doesn't work great
  if (displayEncTextOn) {
    //green encryption text
    pushStyle();
    fill(0, 255, 200, 120);
    textSize(12);
    //textAlign(LEFT);
    //PFont Courier = createFont("Courier", 12);
    textFont(Courier);
    text(txt, 0, yText);
    //blendMode(LIGHTEST);
    if (frameCount % 10 == 0) {
      yText -= 10;
    }
    if (yText < -1000) {
      yText = 0;
    }  //made the text file shorter, and now it will loop instead
    popStyle();

    pushStyle();
    //unicode encryption text
    textFont(Courier);
    //yellow
    fill(249, 245, 100, 100);
    //turquoise
    //fill(128,255,234);
    //tint(200, 200); 
    textSize(random(10, 50));
    text(txt3, 4, dText);
    //dText = dText - 2;
    popStyle();
  }
  //
  
  //  LOADING BAR VIS  //
  rect(10, 10, barI, 20);
  barI += 5;
  if (barI >= displayWidth - 730){barI = 0;}
  //loading to 99%
  int barTimer = 0 + millis();
  textSize(12);
  //fill(249,245,100);
  text(barTimer, 800, 50);
  if (barTimer == 90) {barTimer = 0;}
  String Loading = "L O A D I N G .................................................................................." + barTimer + "%";
  //fill(249,245,100);
  textFont(Courier);
  textSize(12);
  text(Loading, 6, 50);


  //  TITLE IMG  //
  if(displayTitleOn){
    image(titlepic, 0, 0);
  }
  
  if(displayTitleBOn){
    image(titlepicB, 0, 0);
  }
  
    if(displayTitleCOn){
    image(titlepicC, 0, 0);
  }


  //  TIME UPDATE FOR MODEL ANIMATION  //
  timeFree += .0025;
  time = timeFree % 1 - .25;
  //  TIME UPDATE FOR MODEL ANIMATION  //


  //  MODELS  //
  if (displayModelsOn) {
    float s = sin(time * TAU) / 2. + .5;
    float x, y;
    //fill(0, 125); //clear canvas for next frame //MOVED OUT OF THE MODELS SECTION
    //rect(0, 0, width, height);  //clear canvas for next frame //MOVED OUT OF THE MODELS SECTION
    stroke(255);
    fill(0);
    pushMatrix();
    translate(width / 2, height / 2, 443 + (1 - s) * 100);
    rotateY(-(TAU * time) * 1 + 1.3);
    rotateZ((TAU * time * 1) * (1 - s));
    rotateX((TAU * time) * 1.5 + 1 - .8);
    pushMatrix();
    //fill(255, 0, 50, 100);
    //colorMode(HSB);
    //blendMode(ADD);
    beginShape(TRIANGLE);

    float dist = 50;
    for (int i = 0; i < faces.length; i++) {
      Ind3 face = faces[i];
      float a =  max(0, (i - map(sin(time * TAU), -1, 1, 0, faces.length)) * .05);
      dist = 50 + a * 50;
      strokeWeight(map(sin(time * TAU), -1, 1, 0, 1.5) * (max(0, 1 - a)));
      x = cos(time * TAU * 10 + i * .1) * (1 - s) * dist;
      y = - sin(time * TAU * 10 + i * .1) * (1 - s) * dist;
      //fill((time * 25 + x * y * .008 + 250) % 255, 255 - x * y * .05, 50 * (1 - a), 140 * (1 - a)); //fill changes
      fill((time * 25 + x * y * .008 + 250) % 255, 255 * (1 - a), 230 - x * y * .01, 140 * (1 - a)); //fill changes
      //stroke((time * 25 + x * y * .008 + 250) % 255, 255 - x * y * .05, 50 * (1 - a), 225 * (1 - a)); //stroke changes
      stroke((time * 25 + x * y * .008 + 250) % 255, 255 * (1 - a), 230 - x * y * .01, 140 * (1 - a)); //stroke changes
      vertex(vertices[face.x].x + x, vertices[face.x].y + y, vertices[face.x].z);  
      x = cos(time * TAU * 10 + (i + .33) * .1) * (1 - s) * dist;
      y = - sin(time * TAU * 10 + (i + .33) * .1) *  (1 - s) * dist;
      vertex(vertices[face.y].x + x, vertices[face.y].y + y, vertices[face.y].z);
      x = cos(time * TAU * 10 + (i + .66) * .1) * (1 - s) * dist;
      y = - sin(time * TAU * 10 + (i + .66) * .1) * (1 - s) * dist;
      vertex(vertices[face.z].x + x, vertices[face.z].y + y, vertices[face.z].z);
    }

    endShape();
    popMatrix();
    popMatrix();
    //blendMode(NORMAL);
  }
  
  
}  // << END OF DRAW LOOP

////////////////////////
/////  FUNCTIONS   /////
////////////////////////
void processData() {
  for (String line : objLines) {
    if (line.length() > 1) {
      String[] coords = line.split("\\s+");
      switch (coords[0]) {
      case "v": 
        vertices = Arrays.copyOf(vertices, vertices.length + 1);
        vertices[vertices.length - 1] = new Vec3();
        vertices[vertices.length - 1].x = Float.parseFloat(coords[1]);
        vertices[vertices.length - 1].y = Float.parseFloat(coords[2]);
        vertices[vertices.length - 1].z = Float.parseFloat(coords[3]);       
        break;
      case "f": 
        faces = Arrays.copyOf(faces, faces.length + 1);
        faces[faces.length - 1] = new Ind3();
        faces[faces.length - 1].x = Integer.parseInt(coords[1]) - 1;
        faces[faces.length - 1].y = Integer.parseInt(coords[2]) - 1;
        faces[faces.length - 1].z = Integer.parseInt(coords[3]) - 1;      
        break;
      default:
        break;
      }
    }
  }
}

void clearData() {
  
  //String[] objLines;
  //Vec3[] vertices = new Vec3[0];
  //Ind3[] faces = new Ind3[0];
  
  for(int i=0; i<vertices.length; i++){
    for(int j=0; j<3; j++){
    }
    //vertices[i] = new Vec3(float[0], float[0], float[0]);
  }
}

// Full-screen
boolean FullScreen() {
  return true;
}

/////////////////////////
/////   REFERENCES  /////
/////////////////////////
/*

“Unstable Teapot”
https://github.com/Blokatt/ProcessingStuff/tree/master/unstableTeapot

“Terrain”
https://github.com/Blokatt/ProcessingStuff/tree/master/terrain

“AnalysingSample”
https://github.com/Blokatt/ProcessingStuff/tree/master/analysingSample

“dvdp”
https://dvdp.tumblr.com/
Just some interesting 2D, black&white inspiration

“Moonlight”
https://www.openprocessing.org/sketch/659742

"Sound Wave"
HTTPS://WWW.YOUTUBE.COM/WATCH?V=XS62CBK9E7W

*/
