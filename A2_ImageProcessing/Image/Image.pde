/*Image Assignment
 
 Controls: Click top left circle to reset &swap between images
 click a row circle to flip the row
 click a column circle to flip the column
 press space to randomize the image
 press 's' to take a screenshot
 
 */
//array size
int dotArraySize;
//dot array
Dot[] dots ;
//the images used
PImage picA, picB;
//trackes if licked to determine what image to show upon refresh
boolean clicked;
//dot size
int dotsSize;


void setup() {
  size (800, 800);
  //set clicked to true
  clicked =true;
  //assign dot size to 20
  dotsSize=20;
  //load images
  picA=loadImage("picA.jpg");
  picB=loadImage("picB.jpg");
  //load pizels from the images
  picA.loadPixels();
  picB.loadPixels();
  //assign array size
  dotArraySize=width+height;
  //initialize array
  dots = new Dot[dotArraySize];
  //fill with dot objects
  for (int i = 0; i < dotsSize*2; i++) {  
    for (int j = 0; j < dotsSize*2; j++) {
      //get the colour to pass into the new dot
      color aPixel = picA.pixels[i*dotsSize+(j*width*dotsSize)];
      color bPixel = picB.pixels[i*dotsSize+(j*width*dotsSize)];
      //instantiate the dot
      dots[j*dotsSize*2+i] = new Dot(dotsSize/2+i*dotsSize, dotsSize/2+j*dotsSize, dotsSize, aPixel, bPixel, false, i, j);
    }
  }
}
void draw() {

  //println(floor(mouseX/dotsSize));
  background(255);
  //display each dot
  for (Dot dot : dots) {
    dot.display();
  }
}


//when mouse is pressed
void mousePressed() {
  //run the flip colour function on each dot, passing it the coordiantes of the mouse
  for (Dot dot : dots) {
    dot.flipColor(floor(mouseX/dotsSize), floor(mouseY/dotsSize));
  }
}
//when keys are pressed
void keyPressed() {
  //if space key, randomize the dots' colours
  if (key==' ') {
    for (Dot dot : dots) {
      dot.rando();
    }
  }
  //if s, sace a screenshot
  if (key=='s'||key=='S') {
    save("screenshot.jpg");
  }
}

//fliprow function takes the row to flip as an  argument
void flipRow(int rowname) {

  for (Dot dot : dots) {
    //if the dots macth the same row passed in
    if (dot.jVal==rowname) {
      //... flip them
      dot.flipColor2();
    }
  }
}
//flipcol function takes the column to flip as an  argument
void flipCol(int colname) {
  for (Dot dot : dots) {
    //if the dots macth the same column passed in
    if (dot.iVal==colname) {
      //... flip them
      dot.flipColor2();
    }
  }
}