class Dot {
  int xpos, ypos, iVal, jVal;
  color cA, cB;
  boolean isPicA;
  int size =20;


  Dot(int _xpos, int _ypos, color _cA, color _cB, boolean _isPicA, int _iVal, int _jVal) {
    xpos = _xpos;
    ypos = _ypos;
    cA = _cA;
    cB = _cB;
    isPicA=_isPicA;
    iVal = _iVal;
    jVal = _jVal;
  }



  void display() {
    if (isPicA) {
      fill(cA);
    } else {
      fill(cB);
    }
    noStroke();
    ellipse(xpos, ypos, size, size);
  }

  
  void flipColor() {
    float d = dist(this.xpos, this.ypos, mouseX, mouseY);
    if (d<=this.size/2) {
      isPicA =!isPicA;
    }
  }
  
    void flipRow() {
    float d = dist(this.xpos, this.ypos, mouseX, mouseY);
    if (d<=this.size/2) {
      isPicA =!isPicA;
    }
  }
}