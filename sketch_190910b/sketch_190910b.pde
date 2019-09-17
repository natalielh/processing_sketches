void setup()
{
  size(480, 480);
}

void draw()
{
  if(mousePressed){
    fill(165);
  }
  else {
    fill(255);
  }
  
  ellipse(mouseX, mouseY, 120, 120);
}
