////////////////////////////
///////  INITIALIZE  ///////
////////////////////////////

int stateCounter = 0;

Button[] buttons; // Declare the array
Clock clock;

int numButtons = 30;
int currentButton = 0;

int numIndexes = 20;

int switchInterval = 3000;
int nextThreshold = switchInterval;


///////////////////////
///////  SETUP  ///////
///////////////////////

void setup(){
  fullScreen();
  noSmooth();
  background(255);
  cursor(HAND);
  //frameRate(60);
  
  pixelDensity(1);
  strokeWeight(2);
  
  clock = new Clock();
  
  buttons = new Button[numButtons]; // Create the array
  
  for (int i = 0; i < buttons.length; i++) {
    buttons[i] = new Button(); // Create each object
    buttons[i].x = width/4;
    buttons[i].y = i*50 + 50;
    buttons[i].diameter = 36;
    buttons[i].actionIndex = int(random(0, numIndexes));
    buttons[i].on = false;
  }
  
}

///////////////////////
///////  DRAW   ///////
///////////////////////

void draw(){
  fill(245);
  rect(0, 0, width/2, height);  //do not clear the right side!
  
  renderDotGrid();
  
  for (int i=0; i<buttons.length; i++){
    if(
        (
        (mouseX > buttons[i].x - buttons[i].diameter/2) &&
        (mouseX < buttons[i].x + buttons[i].diameter/2)
        )
        &&
        (
        (mouseY > buttons[i].y - buttons[i].diameter/2) &&
        (mouseY < buttons[i].y + buttons[i].diameter/2)
        )
    ){
      buttons[i].displayHover();
      
      if(mousePressed){
        buttons[i].doAction();
      }
      
    }else{
      buttons[i].display();
    }
  }
  
  ////

  if(millis() >= nextThreshold){
    nextThreshold += switchInterval;
    if (switchInterval > 500){
      switchInterval -= 100;
    }
    stateCounter++;
    
    if(stateCounter > 3){
      for (int i = 0; i < 2; i++) {
        buttons[int(random(0, buttons.length))].x = random(0, width/2);
        buttons[int(random(0, buttons.length))].y = random(0, height);
        buttons[int(random(0, buttons.length))].actionIndex = int(random(0, numIndexes));
      }
    }
    
  }
  if(stateCounter < buttons.length){
    for (int i = 0; i < stateCounter; i++) {
    buttons[i].on = true;
    }
  }
  
  ////

  clock.display();

}

/////////////////////////
///////  CLASSES  ///////
/////////////////////////

class Clock {
  int clockRadius = 50; // SETTABLE

  void display(){
    fill(255);
    stroke(0);
    //float theta = (switchInterval%millis() * 6 * PI / 180);
    //float steps = TWO_PI/switchInterval;
    
    circle(clockRadius+20, clockRadius+20, 2*clockRadius);
    
    line(
      clockRadius+20,
      clockRadius+20,
      (clockRadius) * cos(millis()/100) + clockRadius+20,
      (clockRadius) * sin(millis()/100) + clockRadius+20
    );
    
  }
}

/////// INPUT AREA
class InputArea {
  float x, y;
  
  void display(){
    
  }
}

/////// BUTTON
/////// BUTTON
/////// BUTTON

class Button {
  float x, y;
  float diameter;
  color buttonColor = color(0,255,150);
  int actionIndex;
  boolean on = true;  //always start with button activated so it shows up
  
  /////// ACTIONS
  
  void doAction(){
    switch(actionIndex) {
  case 0:
    fill(10, 255, 200);
    square(random(width/2, width),random(0, height), 100);
    break;
  case 1:
    //make the screen black
    fill(0);
    rect(width/2, 0, width, height);
    break;
  case 2:
    fill(0, 0, 240);
    float r = random(0, width/2);
    triangle(width/2+30+r, 75+r, width/2+58+r, 20+r, width/2+86+r, 75+r);
    break;
  case 3:
    fill(30, random(0,255), 200);
    ellipse(0.75*width, height/2, random(50,300), random(50,300));
    break;
  case 4:
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].grow();
    }
    break;
  case 5:
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].shrink();
    }
    break;
  case 6:
    fill(255, 255, 0);
    circle(random(width/2, width),random(0, height), 20);
    break;
  default:
    // large blue circles
    fill(10, 255, 200);
    circle(random(width/2, width),random(0, height), 100);
    break;
}
  }
  
  //void create(float xpos, float ypos){
  //  x = xpos;
  //  y = ypos;
  //  diameter = 10;
  //  on = true;
  //}
  
  void display(){
    if (on == true){
      fill(buttonColor);
      stroke(0);
      ellipse(x, y, diameter, diameter);
      
      //now the decoration to make the button stand out!
      fill(255);
      noStroke();
      ellipse(x-(diameter/5), y-(diameter/5), int(diameter/5), int(diameter/5));
    }
    
  }
  
    void displayHover(){
    if (on == true){
      fill(buttonColor);
      stroke(0);
      ellipse(x, y, diameter, diameter);
      
      fill(0, 0, 0, 100);
      ellipse(x, y, diameter, diameter);
      
      //now the decoration to make the button stand out!
      fill(255);
      noStroke();
      ellipse(x-(diameter/5), y-(diameter/5), int(diameter/5), int(diameter/5));
    }
    
  }
  
  void grow(){
    if (diameter < 250){
      diameter++;
    }
  }
  
  void shrink(){
    if (diameter > 20){
      diameter--;
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
    for(int i=0; i<columns/2; i++){  //only draw the grid on the left side of the screen.
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
