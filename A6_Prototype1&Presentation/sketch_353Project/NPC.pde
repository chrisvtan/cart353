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

  NPC(PVector _loc, float _size, String _id, float _r, float _g, float _b, int _inf) {
    loc = _loc;
    size = _size;
    id = _id;
    r =_r;
    g = _g;
    b = _b;
    inf = _inf;
    c = color(r, g, b);
    suspects = new Suspect[count];
    for (int i=0; i<count; i++) {
      int trust=int(random(50));
      if (names[i]==id) {
        trust =100;
      }
      suspects[i]= new Suspect(names[i], trust);
    }
  }




  void run() {
    display();
    update();
  }



  void display() {

    if (getDist(player.loc)) {
      fill(0, 200, 150);
      ellipse(loc.x, loc.y, 2*size, 2*size);
      displayID();
      player.changeColor(r,g,b,inf);

      println("Villager: " + id +" suspects: " + getSuspect() );
    }


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
    for (int i=0; i<count; i++) {
      text(names[i], 300, 30+map(i, 0, count-1, 0, 140));
      //text(suspectName(i), 500, 30+map(i, 0, count-1, 0, 140));
    }
  }
}