int y = 0;

void setup()
{
  size (300, 300);
  background(255);
}

// draw() repeats over and over again
void draw()
{
  line(0, y, 300, y);
  y = y + 4;
}
