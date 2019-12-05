int i = 0;
int Timer = 0;
String Loading;

void setup() { 
  size(720, 900);
} 
 
void draw() { 
  background(0);
  noStroke();
  fill(249,245,100);
  rect(10, 10, i, 20);
  blendMode(SCREEN);
  i = i + 5;
  if (i >= displayWidth - 730) {
  i = 0;
}
  
  //LOADING TO 99%
  int Timer = 0 + millis();
  //int Timer = millis();  
  textSize(12);
  fill(249,245,100);
  text(Timer, 800, 50);
  
  //Timer = Timer + 10;
  
  if (Timer == 90) {
  Timer = 0;
  }
  
  String Loading = "L O A D I N G .................................................................................." + Timer + "%";
  fill(249,245,100);
  PFont Courier = createFont("Courier", 12);
  textFont(Courier);
  textSize(12);
  text(Loading, 6, 50);
  
  
  

  
  
}
