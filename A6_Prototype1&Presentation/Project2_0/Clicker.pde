//class for the clicker object
class Clicker {
  //position varriable
  PVector position = new PVector(mouseX, mouseY);
  //name variable
  String name;
  //color variable
  color clickerColor;
  //red value 
  int r;
  //green value
  int g;
  //blue value
  int b;
  //held wisdom score. determines resisntace to info INTO an NPC
  int wisdom;
  //held charisma score. detemines influence of info OUT of NPC
  int charisma;

  //constructor
  Clicker() {
  }


  void display() {
    //fill with the held color (black defult)
    fill(clickerColor);
    //draw a circle at mouse position
    ellipse(mouseX, mouseY, 30, 30);
  }
  //set ID (happens on mouse Rihgt click)
  void SetID(String newName, int newR, int newG, int newB, int newCha, int newWis) {
    //take the name from the NPC arguments
    name = newName;
    //take the RGB values
    r=newR;
    g=newG;
    b=newB;
    //set own color to the new RGB
    clickerColor = color(r, g, b);
    //overwrite wisodm
    wisdom = newWis;
    //overwrite charisma
    charisma = newCha;
  }
}