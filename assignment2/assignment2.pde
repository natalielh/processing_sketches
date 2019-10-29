////////////////////////////
///////  INITIALIZE  ///////
////////////////////////////

float speed = 1.0;

Button[] buttons; // Declare the array
int numButtons = 20;
int currentButton = 0;


///////////////////////
///////  SETUP  ///////
///////////////////////

void setup(){
  fullScreen();
  noSmooth();
  background(255);
  cursor(HAND);
  
  pixelDensity(1);
  strokeWeight(2);
  
  buttons = new Button[numButtons]; // Create the array
  
  for (int i = 0; i < buttons.length; i++) {
    buttons[i] = new Button(); // Create each object
    buttons[i].x = int(random(0, width));
    buttons[i].y = int(random(0, height));
    buttons[i].diameter = 30;
    buttons[i].on = true;
  }
  
}

///////////////////////
///////  DRAW   ///////
///////////////////////

void draw(){
  background(255);
  
  renderDotGrid();
  
  for (int i=0; i<buttons.length; i++){
    buttons[i].display();
  }

}

/////////////////////////
///////  CLASSES  ///////
/////////////////////////

class Clock {

  void display(){
    
  }
}

class InputArea {
  float x, y;
  
  void display(){
    
  }
}

class Button {
  float x, y;
  float diameter;
  //color col = (255,255,255);
  boolean on = true;  //always start with button activated so it shows up
  
  //void create(float xpos, float ypos){
  //  x = xpos;
  //  y = ypos;
  //  diameter = 10;
  //  on = true;
  //}
  
  void display(){
    if (on == true){
      fill(0,255,0);
      stroke(0);
      ellipse(x, y, diameter, diameter);
      
      //now the decoration to make the button stand out!
      fill(255);
      noStroke();
      ellipse(x-(diameter/5), y-(diameter/5), int(diameter/5), int(diameter/5));
    }
    
  }
}

///////////////////////////
///////  FUNCTIONS  ///////
///////////////////////////

void renderDotGrid(){
  int separatingSpace = 16; //SETTABLE
  fill(200);
  noStroke();
  
  int rows = int(height/separatingSpace);
  int columns = int(width/separatingSpace);
  
  for(int r=0; r<rows; r++){
    for(int i=0; i<columns; i++){
      rect(separatingSpace*i, separatingSpace*r, 2, 2);
    }
  }
}


///// REFERENCE MATERIAL /////
//
// * ARRAYS:
//      https://processing.org/tutorials/arrays/
//
//////////////////////////////
