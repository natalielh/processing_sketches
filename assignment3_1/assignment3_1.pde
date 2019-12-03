/* [ Unstable Teapot   ] 
 [        by Blokatt ] 
 [  03/12/2017 1AM   ] */

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

//  MODEL DECLARATIONS  //
float time = 0, timeFree = 0;
float progress = 1;

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
      fill(0, 255, 200);
      //blendMode(LIGHTEST);
      ellipse(j, 100, 3, fft.getBand(j) * 200);
      
      if(j > 8 && fft.getBand(j) > 30){
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
    fill(0, 255, 0);
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
    fill(249, 245, 100);
    //turquoise
    //fill(128,255,234);
    //tint(200, 200); 
    textSize(random(10, 50));
    text(txt3, 4, dText);
    //dText = dText - 2;
    popStyle();
  }
  //


  //  USER INPUT KEYS  //
  //if (keyPressed){
  //  switch(key){
  //    case '1':
  //      println("KEY PRESSED: " + key);
  //      objLines = loadStrings("car_03.obj"); //load in 3D model
  //      processData();
  //      break;
  //    case '2':
  //      println("KEY PRESSED: " + key);
  //      objLines = loadStrings("teapot.obj"); //load in 3D model
  //      processData();
  //      break;
  //    case '3':
  //      println("KEY PRESSED: " + key);
  //      objLines = loadStrings("CO2_02.obj"); //load in 3D model
  //      processData();
  //      break;
  //    case '4':
  //      println("KEY PRESSED: " + key);
  //      setup();
  //      break;
  //    case 'q':
  //      println("KEY PRESSED: " + key);
  //      displaySoundVizOn = !displaySoundVizOn;
  //      break;
  //  }
  //} else {
  //   timeFree += .0025;
  //   time = timeFree % 1 - .25; //PAUSES IT. IF A BUTTON IS PRESSED, CLOCK DOESN'T TICK.
  //}


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
      fill((time * 25 + x * y * .008 + 250) % 255, 255 - x * y * .05, 50 * (1 - a), 140 * (1 - a)); //fill changes
      //fill((time * 25 + x * y * .008 + 100) % 255, 255 - x * y * .05, 50 * (1 - a), 140 * (1 - a)); //fill changes
      stroke((time * 25 + x * y * .008 + 250) % 255, 255 - x * y * .05, 50 * (1 - a), 225 * (1 - a)); //stroke changes
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
  //for (String line : objLines) {
  //  //if (line.length() > 0) {
  //    String[] coords = line.split("\\s+");
  //    switch (coords[0]) {
  //    case "v": 
  //      vertices = Arrays.copyOf(vertices, vertices.length + 1);
  //      vertices[vertices.length - 1] = new Vec3();
  //      vertices[vertices.length - 1].x = Float.parseFloat(coords[1]);
  //      vertices[vertices.length - 1].y = Float.parseFloat(coords[2]);
  //      vertices[vertices.length - 1].z = Float.parseFloat(coords[3]);       
  //      break;
  //    case "f": 
  //      faces = Arrays.copyOf(faces, faces.length + 1);
  //      faces[faces.length - 1] = new Ind3();
  //      faces[faces.length - 1].x = Integer.parseInt(coords[1]) - 1;
  //      faces[faces.length - 1].y = Integer.parseInt(coords[2]) - 1;
  //      faces[faces.length - 1].z = Integer.parseInt(coords[3]) - 1;      
  //      break;
  //    default:
  //      break;
  //    }
  //  //}
  //}
  
  for(int i=0; i<objLines.length; i++){
    //objLines[i] = (0);
  }
}

//I'm not really sure what this does v
boolean FullScreen() {
  return true;
}
