
float a = 0;
float b = 0;
float c = 0;
float d = 0;

void setup()
{
  //size(1000, 1000);
  fullScreen();
  background(0);
  
  noStroke();
  
}

void draw()
{
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
  
  if(mousePressed){
    fill(0);
  }
  else {
    fill(random(220,255), random(200,255), random(240,255), random(200,255));
  }
  
  a = random(0,300) + mouseX;
  b = random(0,300) + mouseY;
  c = random(0,300) + mouseX;
  d = random(0,300) + mouseY;
  
  triangle(mouseX, mouseY, a, b, c, d);
  triangle(mouseX, mouseY, a, b-200, c-200, d);
  triangle(mouseX, mouseY, a-200, b-100, c-200, d-200);
  
}
