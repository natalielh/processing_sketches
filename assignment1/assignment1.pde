//
// heartstrings: organic tree generation
//
// references:
// https://processing.org/examples/tree.html
//

float angle;

color c1;
color c2;

void setup(){
  //frameRate(30);
  fullScreen();
  //pixelDensity(2);
  //noSmooth();
  //blendMode(DARKEST);
  background(255);
  
  cursor(HAND);
}


void draw(){
}


void mouseReleased(){
  //stroke(100, 0, 100, 50);

  angle = random(0.1, 0.3);
  
  //randomized 'before' colour
  c1 = color(
    random(150, 255),
    0,
    random(0, 150)
  );
  
  //randomized 'after' colour
  c2 = color(
    random(0, 50),
    0,
    random(200, 255)
  );
  
  //move the pen into position
  translate(mouseX, height);
  
  //actual drawing on the canvas begins
  //the first line
  strokeWeight(abs(map((height-mouseY)/5.5, 12, 70, 0.2, 2)));
  line(0, 0, 0, -(height-mouseY)/5.5);
  translate(0, -(height-mouseY)/5.5);
  
  //branch out from the first line
  tree((height-mouseY)/5.5);
  
}

void tree(float len){

  len *= random(0.8, 0.9);
  
  if (len > 12){
    
    //colour and stroke change
    stroke(lerpColor(
      c1,
      c2,
      map(len, 12, 70, 0, 1)),
      150
    );
    strokeWeight(abs(map(len, 12, 70, 0.2, 2)));
    
    //tree branch to the right
    push(); //save
    rotate(angle + random(-0.2, 0.2));
    line(0, 0, 0, -len);
    translate (0, -len);
    tree(len);
    pop(); //restore
    
    // tree branch to the left
    push(); //save
    rotate(-angle + random(-0.2, 0.2));
    line(0, 0, 0, -len);
    translate(0, -len);    
    tree(len);
    pop(); //restore
    
    
  }
}
