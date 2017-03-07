class Player {
  float r=255;
  float g;
  float b;
  PVector loc;
  PVector vel= new PVector (0, 0);
  PVector acc = new PVector (0, 0);
  float size;
  float maxSpeed =200;
  int myinf =5;

  color col = color(r, g, b);

  Player(PVector _loc, float _size) {
    loc = _loc;
    size = _size;
  }

  void run() {
    display();
    update();
  }



  void display() {
    fill(col);
    ellipse(loc.x, loc.y, size, size);
  }


  void update() {
    loc = new PVector(mouseX, mouseY);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void changeColor(float newr, float newg, float newb, int inf) {
    println("newR="+newr);
    float r2 = ((newr*inf)+(r*myinf))/ (inf+myinf);
    println("r2="+r2);
    float g2 = ((newg*inf)+(g*myinf))/ (inf+myinf);
    float b2 = ((newb*inf)+(b *myinf))/ (inf+myinf);

    col = color(r2, g2, b2);
  }
}