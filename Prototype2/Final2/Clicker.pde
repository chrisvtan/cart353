class Clicker {
    //CLASS VARIABLES

  PVector position;



//=======================================================================================================================================
//CONSTRUCTOR
  Clicker() {
    position = new PVector(mouseX, mouseY);
  }


//=======================================================================================================================================
  void run() {
    update();
  }

  void update() {
    position.x = mouseX;
    position.y = mouseY;
  }
}