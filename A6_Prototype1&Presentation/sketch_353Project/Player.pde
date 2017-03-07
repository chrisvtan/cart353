class Player {
  float r=122;
  float g=122;
  float b=122;
  PVector loc;
  PVector vel= new PVector (0, 0);
  PVector acc = new PVector (0, 0);
  float size;
  float maxSpeed =200;
  int myinf =1;
  boolean start = false;
  color c = color(r, g, b);

  Player(PVector _loc, float _size) {
    loc = _loc;
    size = _size;
  }

  void run() {
    display();
    update();
  }



  void display() {
    fill(c);
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
    r=r2;
    g=g2;
    b=b2;
    c = color(r, g, b);
    myinf =inf;
  }
}