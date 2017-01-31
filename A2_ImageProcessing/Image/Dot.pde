//DotClass
class Dot {
  //vars to track position, and i&j values from nested loop(used as id tags)
  int xpos, ypos, iVal, jVal;
  //colours a&b
  color cA, cB;
  //boolean to track which image to display
  boolean isPicA;
  //dot size
  int size =20;

  //constructor
  Dot(int _xpos, int _ypos, int _size, color _cA, color _cB, boolean _isPicA, int _iVal, int _jVal) {
    //assign position...
    xpos = _xpos;
    ypos = _ypos;
    //...colours...
    cA = _cA;
    cB = _cB;
    //...image to display...
    isPicA=_isPicA;
    //...coordiantes in array...
    iVal = _iVal;
    jVal = _jVal;
    //...and size
    size = _size;
  }


  //display function
  void display() {
    //if dipalying pic A...
    if (isPicA) {
      //...fill with A color
      fill(cA);
    } else {
      //...else fill with B
      fill(cB);
    }

    noStroke();
    //draw the dot
    ellipse(xpos, ypos, size, size);
  }

  //flip colur function takes mouse coordiantes as arguemnts

  void flipColor(int Rlow, int Clow) {
    //calculate how far mouse is from the dot
    float d = dist(this.xpos, this.ypos, mouseX, mouseY);
    //if within the dot...
    if (d<=this.size/2) {
      //...and at topleft dot...
      if (Rlow==0&& Clow ==0) {
        //...and displaying picB
        if (clicked) {
          //change each dot to display pic A
          for (Dot dot : dots) {
            dot.isPicA=true;
          }
          //else change each dot to display pic 2
        } else {
          for (Dot dot : dots) {
            dot.isPicA=false;
          }
        }
        //flip the boolean tracking the pic
        clicked =!clicked;
      } else
        //if not in topleft but in top...
        if (Rlow==0) {
          //flip all dots in same row
          flipRow(this.jVal);
          //if not in row but in coumnl...
        } else if (Clow==0) {
          //flip all dots in same column
          flipCol(this.iVal);
        } else {
          //if any other dot, just flit that dot
          isPicA =!isPicA;
        }
    }
  }

  //function to fully flip to a complete image
  void flipColor2() {
    isPicA =!isPicA;
  }

  //randomize function
  void rando() {
    //grab a random int 0 or 1
    int rand=int(random(2));
    //if 1...
    if (rand==1) {
      //choose colour from picA
      isPicA =true;
    } else {
      //else choose colour from picB
      isPicA =false;
    }
  }
}