float speed = 1.0;

Button[] buttons; // Declare the array
int numButtons = 50;
int currentButton = 0; 

void setup(){
  fullScreen();
  noSmooth();
  background(255);
  cursor(HAND);
  
  buttons = new Button[numButtons]; // Create the array
  for (int i = 0; i < buttons.length; i++) {
    buttons[i] = new Button(); // Create each object
  }
  
  
  
}

void draw(){


}

class Button {
  float x, y;
  float diameter;
  //color col = (255,255,255);
  boolean on = false;
}
