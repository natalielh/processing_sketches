/* [ Unstable Teapot   ] 
   [        by Blokatt ] 
   [  03/12/2017 1AM   ] */ 

import java.util.Arrays;
import ddf.minim.analysis.*;
import ddf.minim.*;
 
Minim minim;
AudioPlayer jingle;
AudioInput input;
FFT fft;
int[][] colo=new int[300][3];
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

//void setupObj() {
//  objLines = loadStrings("car_03.obj"); //load in 3D model
//  processData();
//}

void setup() {
  //model stuff
  //objLines = loadStrings("teapot.obj"); //load in 3D model
  objLines = loadStrings("CO2_02.obj"); //load in 3D model
  //objLines = loadStrings("car_03.obj"); //load in 3D model
  processData();
  
  //sound stuff
  minim = new Minim(this);
  input = minim.getLineIn();
  fft = new FFT(input.bufferSize(), input.sampleRate());
  
  size(displayWidth, displayHeight, P3D);
  smooth(5);
}

//void keyReleased(){
//  //BUTTON CONTROLS
//      switch(key){
//      case 1:
//        println("KEY PRESSED: 1");
//        break;
//      case 2:
//        println("KEY PRESSED: 2");
//        break;
//      case 3:
//        break;
//    }
//}

void draw() {
  
  //SOUNDWAVE AUDIO VISUALIZER
  fft.forward(input.mix);
  for(int j = 0; j < fft.specSize() + displayWidth; j += 2) {
    fill(0,255,0);
    //blendMode(LIGHTEST);
    ellipse(j, 200, 1, fft.getBand(j) * 50); 
  }
  
  if (keyPressed){
    switch(key){
      case '1':
        println("KEY PRESSED: 1");
        objLines = loadStrings("car_03.obj"); //load in 3D model
        processData();
        break;
      case '2':
        println("KEY PRESSED: 2");
        objLines = loadStrings("teapot.obj"); //load in 3D model
        processData();
        break;
      case '3':
        println("KEY PRESSED: 3");
        objLines = loadStrings("CO2_02.obj"); //load in 3D model
        processData();
        break;
      case '4':
        println("KEY PRESSED: 4");
        setup();
        break;
    }
  } else {
     timeFree += .0025;
     time = timeFree % 1 - .25; //PAUSES IT. IF A BUTTON IS PRESSED, CLOCK DOESN'T TICK.
  }
  
  //timeFree += .0025;
  //time = timeFree % 1 - .25;
  float s = sin(time * TAU) / 2. + .5;
  float x, y;
  fill(0, 125); //clear canvas for next frame
  rect(0, 0, width, height);
  stroke(255);
  fill(0);
  pushMatrix();
  translate(width / 2, height / 2, 443 + (1 - s) * 100);
  rotateY(-(TAU * time) * 1 + 1.3);
  rotateZ((TAU * time * 1) * (1 - s));
  rotateX((TAU * time) * 1.5 + 1 - .8);
  pushMatrix();
  fill(100, 0, 255, 100);
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

//I'm not really sure what this does v
boolean FullScreen() {
return true;
}
