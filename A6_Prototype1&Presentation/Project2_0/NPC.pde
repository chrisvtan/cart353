//NPC Class
class NPC {

  //vars for location,size and name
  PVector location;
  float size;
  String name;
  //RGB values
  int r;
  int g;
  int b;
  //color
  color myColor;
  //to be uses later
  int minDist;
  //charisma determines force of output info
  int charisma;
  //wisdom determines resistance to input info
  int wisdom;


  //constructor
  NPC(PVector _location, float _size, String _name) {
    //set name, size and location
    location = _location;
    size= _size;
    name = _name;
    //set color
    setColor();
    //set WIS and CHA
    charisma = setCharisma();
    wisdom = setWisdom();
  }
  //run all continuous functions
  void run() {
    display();
  }


  void display() {
    //draw a square at position using color
    getColor();
    fill(myColor);
    noStroke();
    rect(location.x, location.y, size, size);
    //write the Ability scores in balck
    fill(0);
    textAlign(CENTER, CENTER);
    text("CHA: "+charisma, location.x+size/2, location.y+size/3);
    text("CWIS: "+wisdom, location.x+size/2, location.y+(size/3)*2);
  }

  //To be used later
  boolean getDist(PVector p) {
    float d = p.dist(location);
    if (d<minDist) {
      return true;
    } else return false;
  }

  //set an initial random color
  void setColor() {
    int _r =int(random(100, 255));
    int _g =int(random(100, 255));
    int _b =int(random(100, 255));
    r= _r;
    g =_g;
    b = _b;    

    myColor = color(r, g, b);
  }
  //return the color I am
  color getColor() {
    myColor = color(r, g, b);
    return myColor;
  }
  //setter and getter for wisdom
  int setWisdom() {
    int w = int(random(30, 100));
    return w;
  }
  int getWisdom() {
    return wisdom;
  }
  //setter and getter for charisma
  int setCharisma() {
    int c = int(random(50));
    return c;
  }
  int getCharisma() {
    return charisma;
  }
  //learn function
  void learn(int newR, int newG, int newB, int cha) {
    //for each color element take the input val* charisma of clicker and add it to personal val * wisom then devide to get back into 255 range
    int r2= ((newR*cha)+(r*wisdom))/(cha+wisdom);
    int g2= ((newG*cha)+(g*wisdom))/(cha+wisdom);
    int b2= ((newB*cha)+(b*wisdom))/(cha+wisdom);
    //update RGB
    r=r2;
    g=g2;
    b=b2;
  }
}