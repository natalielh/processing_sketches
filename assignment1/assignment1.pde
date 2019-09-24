// organic tree generation
// references:
// https://processing.org/examples/tree.html
//

float angle;

void setup(){
  //frameRate(30);
  fullScreen();
  background(255);
}

void draw(){

}

void mouseReleased(){
  stroke(0, 0, 0, 50);

  angle = random(0.1, 0.3);
  translate(mouseX, height);
  
  line(0, 0, 0, -20);
  translate(0, -20);
  tree((height-mouseY)/6);
}

void tree(float len){

  len *= random(0.8, 0.9);
  
  if (len > 12){
    
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
