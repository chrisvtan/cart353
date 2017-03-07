class Player {
  PVector loc;
  PVector vel= new PVector (0, 0);
  PVector acc = new PVector (0, 0);
  float size;
  float maxSpeed =200;



  Player(PVector _loc, float _size) {
    loc = _loc;
    size = _size;
  }

  void run() {
    display();
    update();
  }



  void display() {
    fill(255, 0, 0);
    ellipse(loc.x, loc.y, size, size);
  }


  void update() {
   loc = new PVector(mouseX,mouseY);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
}