class NPC {
  float r;
  float g;
  float b;
  String id;
  PVector loc;
  PVector vel;
  PVector acc;
  float size;
  PImage photo;
  Suspect[] suspects;
  color c ;
  int inf;
  String suspect1;
  NPC(PVector _loc, float _size, String _id, float _r, float _g, float _b, int _inf, String _s) {
    loc = _loc;
    size = _size;
    id = _id;
    r =_r;
    g = _g;
    b = _b;
    inf = _inf;
    suspect1=_s;
    c = color(r, g, b);
    suspects = new Suspect[count];
    for (int i=0; i<count; i++) {
      int  trust =0;

      suspects[i]= new Suspect(names[i], trust);
    }
  }




  void run() {
    display();
    update();
  }



  void display() {

    if (getDist(player.loc)) {
      fill(255);
      ellipse(loc.x, loc.y, 2*size, 2*size);
      displayID();
      if (player.start) {
        changeColor(player.r, player.g, player.b, player.myinf);
      }
      player.changeColor(r, g, b, inf);

      player.start =true;
      println("Villager: " + id +" suspects: " + getSuspect() );
    }
fill(0);
    text(inf, loc.x, loc.y+size);
    fill(c);
    ellipse(loc.x, loc.y, size, size);
  }


  void update() {
  }

  boolean getDist(PVector p) {
    float d = p.dist(loc);
    if (d<50) {
      return true;
    } else return false;
  }

  void setImage(String s) {
    photo = loadImage(s);
  }


  void displayID() {
    fill(150);
    rect(0, 0, width, 200);
    trustLevels();
    image (photo, 0, 0);
  }

  String getSuspect() {
    String s = "no suspect yet";
    int threshold = 5;
    for (Suspect person : suspects) {

      if (person.trust> threshold)
        s = person.name;
      threshold = person.trust;
    }

    return s;
  }

  String suspectName(int n) {
    return suspects[n].name;
  }

  void trustLevels() {
    fill(255);
    for (int i=0; i<1; i++) {
      text(id, 300, 30+map(i, 0, count-1, 0, 140));
      text(inf, 500, 30+map(i, 0, count-1, 0, 140));
    }
  }


  void changeColor(float newr, float newg, float newb, int _inf) {
    println("newR="+newr);
    float r2 = ((newr*_inf)+(r*inf))/ (inf+_inf);
    println("r2="+r2);
    float g2 = ((newg*_inf)+(g*inf))/ (inf+_inf);
    float b2 = ((newb*_inf)+(b *inf))/ (inf+_inf);
    r=r2;
    g=g2;
    b=b2;
    c = color(r, g, b);
  }

  String decide() {
    String susp = suspect1;



    return susp;
  }
}