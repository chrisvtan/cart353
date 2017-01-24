int dotArraySize;
Dot[] dots ;
PImage picA,picB;

void setup() {
  size (800, 800);
  picA=loadImage("picA.jpg");
  picB=loadImage("picB.jpg");
  picA.loadPixels();
  picB.loadPixels();
  dotArraySize=1600;
  dots = new Dot[dotArraySize];
  for (int i = 0; i < 40; i++) {  
    for (int j = 0; j < 40; j++) {
color aPixel = picA.pixels[i*20+(j*width*20)];
color bPixel = picB.pixels[i*20+(j*width*20)];
      //println(state);
      dots[j*40+i] = new Dot(10+i*20, 10+j*20, aPixel, bPixel, false,i,j);
    }
  }
}
void draw() {

  background(255);

  for (Dot dot : dots) {
    dot.display();
  }
}
boolean randBool() {
  int flip = int(random(2));
  println(flip);

  if (flip==1) {
    return  true;
  } else {
    return false;
  }
}

void mousePressed() {
  for (Dot dot : dots) {
    dot.flipColor();
  }
  
  
}