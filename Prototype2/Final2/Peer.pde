class Peer {
  //CLASS VARIABLES
  PVector location = new PVector(0, 0);
  String name;
  String type;
  float trust;
  color myColor;
  boolean active = false;
  int roll;




  Peer(String _name, color _myColor) {
    name = _name;
    trust = random(-1, 1);
    myColor = _myColor;
  }

  void display() {
    fill(myColor);
    ellipse(location.x, location.y, 50, 50);
  };
}