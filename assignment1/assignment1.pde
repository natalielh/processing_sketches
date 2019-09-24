// organic tree generation
// references:
// https://processing.org/examples/tree.html
//

float angle;

color c1;
color c2;

void setup(){
  //frameRate(30);
  fullScreen();
  background(255);
}

void draw(){

}

void mouseReleased(){
  //stroke(100, 0, 100, 50);

  angle = random(0.1, 0.3);
  
  //randomized 'before' colour
  c1 = color(
    random(200, 255),
    0,
    random(0, 100)
  );
  
  //randomized 'after' colour
  c2 = color(
    random(0, 50),
    0,
    random(200, 255)
  );
  
  translate(mouseX, height);
  
  line(0, 0, 0, -20);
  translate(0, -20);
  tree((height-mouseY)/6);
}

void tree(float len){

  len *= random(0.8, 0.9);
  
  if (len > 12){
    
    //colour and stroke change
    stroke(lerpColor(c1, c2, map(len, 10, 50, 0, 1)));
    strokeWeight(map(len, 10, 50, 0.5, 3));
    
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
