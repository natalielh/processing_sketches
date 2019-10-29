////////////////////////////
///////  INITIALIZE  ///////
////////////////////////////

int stateCounter = 0;
boolean displayNum = false;

Button[] buttons; // Declare the array
Clock clock;

int numButtons = 30;
int currentButton = 0;

int numIndexes = 15;

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
  rectMode(CENTER);
  
  clock = new Clock();
  
  buttons = new Button[numButtons]; // Create the array
  
  for (int i = 0; i < buttons.length; i++) {
    buttons[i] = new Button(); // Create each object
    buttons[i].x = width/4;
    buttons[i].y = i*50 + 300;
    buttons[i].diameter = 36;
    buttons[i].actionIndex = int(random(0, numIndexes));
    buttons[i].circle = true;
    buttons[i].on = false;
  }
  
}

///////////////////////
///////  DRAW   ///////
///////////////////////

void draw(){
  fill(245);
  rect(width/4, height/2, width/2, height);  //do not clear the right side!
  
  renderDotGrid();
  
  for (int i=0; i<buttons.length; i++){
    if( buttons[i].on &&
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
      buttons[i].doAction(i);
      
      //if(mousePressed){
      //  buttons[i].doAction();
      //}
      
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
  
  if(keyPressed){
    if (key == CODED){
      if (keyCode == RIGHT){
        displayNum = true;
      
      }
      if (keyCode == LEFT){
        displayNum = false;
      
      }
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
  float x, y, w, h;
  
  void display(){
    
    
  }
}

/////// BUTTON
/////// BUTTON
/////// BUTTON

class Button {
  float x, y;
  float diameter;
  color buttonColor = color(0,255,150,240);
  int actionIndex;
  boolean circle = true;
  boolean on = true;  //always start with button activated so it shows up
  
  /////// ACTIONS
  
  void doAction(int currentButton){
    switch(actionIndex) {
  case 0:
    fill(10, 255, 10);
    square(random(width/2, width),random(0, height), random(10,30));
    displayNum = false;
    break;
  case 1:
    //make the screen black
    fill(0, 0, 0, 10);
    rect(0.75*width, height/2, width/2, height);
    break;
  case 2:
    fill(0, 0, 240);
    float r = random(0, width/2);
    triangle(width/2+30+r, 75+r, width/2+58+r, 20+r, width/2+86+r, 75+r);
    buttons[int(random(0, buttons.length))].buttonColor = color(0, 250, 200);
    break;
  case 3:
    // randomized blue ellipses
    fill(10, random(150,255), 255);
    ellipse(random(width/2, width), height/2, random(50,300), random(50,300));
    break;
  case 4:
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].grow();
    }
    fill(255, random(0, 50), 240);
    ellipse(0.6*width, random(0, height), 20, 5);
    break;
  case 5:
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].shrink();
    }
    fill(255, 255, random(0, 50));
    ellipse(0.8*width, random(0, height), 50, 10);
    displayNum = true;
    break;
  case 6:
    fill(255, 255, 0);
    circle(random(width/2, width),random(0, height), 20);
    if(buttons[currentButton].x < width/2){
    buttons[currentButton].x++;
    }
    break;
  case 7:
    stroke(255, 30, 255);
    float a = random(0, height);
    line(width/2, a, width, a);
    break;
  case 8:
    stroke(255);
    float b = random(0, height);
    line(width/2, b, width, b);
    break;
  case 9:
    strokeWeight(10);
    line(random(width/2, width), random(width/2, width), random(width/2, width), random(width/2, width));
    break;
  case 10:
    buttons[int(random(0, buttons.length))].circle = true;
    fill(100, 0, 240);
    arc(random(width/2, width), random(0, height), 80, 80, 0, PI+QUARTER_PI + random(0,2), PIE);
    if(buttons[currentButton].x < width/2){
    buttons[currentButton].x++;
    }
    break;
  case 11:
    fill(250, 0, 10);
    float c = random(0, width/2) + width/2;
    circle(c, (random(width/2, width)), 50);
    circle(c+50, (random(width/2, width)), 50);
    circle(c+100, (random(width/2, width)), 50);
    buttons[int(random(0, buttons.length))].circle = false;
    break;
  case 12:
    fill(30, 0, 255);
    float d = random(0, width/2) + width/2;
    circle((random(width/2, width)), d, 50);
    circle((random(width/2, width)), d+50, 50);
    circle((random(width/2, width)), d+100, 50);
    buttons[int(random(0, buttons.length))].circle = false;
    break;
  case 13:
    stroke(255, 20, 255);
    line(0.75*width, height/3, random(width/2, width), random(0, height));
    break;
  case 14:
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].grow();
    }
    fill(255, random(100, 170), 0);
    ellipse(0.75*width, 0, width/2, random(10, 200));
    break;
  default:
    // small circles
    fill(255, random(10,40), 200);
    circle(random(width/2, width),random(0, height), 10);
    buttons[int(random(0, buttons.length))].randomColor();
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
      strokeWeight(2);
      stroke(0);
      
      if (circle){
        circle(x, y, diameter);
      }else{
        square(x, y, diameter);
      }
      
      if (displayNum){
        textSize(diameter/2);
        fill(0);
        text(actionIndex, x-diameter/3, y+diameter/3);
      }
      
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

      if (circle){
        circle(x, y, diameter);
        fill(0, 0, 0, 100);
        circle(x, y, diameter);
      }else{
        square(x, y, diameter);
        fill(0, 0, 0, 100);
        square(x, y, diameter);
      }
      
      if (displayNum){
        textSize(diameter/2);
        fill(255);
        text(actionIndex, x-diameter/3, y+diameter/3);
      }
      
      //now the decoration to make the button stand out!
      fill(255);
      noStroke();
      ellipse(x-(diameter/5), y-(diameter/5), int(diameter/5), int(diameter/5));
    }
    
  }
  
  void grow(){
    if (diameter < 180){
      diameter++;
    }
  }
  
  void shrink(){
    if (diameter > 30){
      diameter--;
    }
  }
  
  void randomColor(){
    buttonColor = color(random(200,255), random(150,255), random(200,255), 240);
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
