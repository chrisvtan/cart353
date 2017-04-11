class NPC {

  //CLASS VARIABLES
  //arraylist containing a mental model of each other agent
  ArrayList<Peer> peers = new ArrayList<Peer>();
  //agent name
  String name;
  //agent location
  PVector location;
  //agent color
  color myColor;
  //agent size
  int size;
  //agent number
  int number;
  //boolean 
  boolean selected = false;
  //held NPC


  PImage icon;
  PImage villager;

  //=======================================================================================================================================
  //CONSTRUCTOR
  NPC(String _name, PVector _loc, int _num) {
    //set variables based on parameters
    name =_name;
    location = _loc;
    number = _num;

    //Turn number into string for picture
    String h = str(number);
    //load image
    icon = loadImage(h+".jpg"); 

    villager = loadImage("vil.jpg"); 
    //set location to center
    location.add(height/2, height/2+70);
    //randomize color
    myColor = color(random(100), random(100), random(100));
    //set size
    size = 75;


    println(held);
  }

  //=======================================================================================================================================

  void run() {
    display();
    update();
  }
  //function to fill peer array
  void setPeers() {

    for (NPC n : npcs) {
      //if peer int self add them to array
      if (n.name != name) {
        peers.add(new Peer(n.name, n.myColor));
      }
    }
  }

  //display function
  void display() {
    if (selected) {
      fill(255, 0, 0);
    } else {
      fill(myColor);
    }
    image(villager, location.x-size/2, location.y-size/2, size, size);
    //ellipse(location.x, location.y, size, size );
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(name, location.x, location.y+50);
  }
  void setLocation(PVector n) {
    fill(myColor);

    ellipse(n.x, n.y, size, size );
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(name, n.x, n.y);
  }
  void update() {
  }

  void receiveGossip(NPC talker, NPC subject, float _t, int _r) {
    String talkerName =talker.name;
    float talkerTrust=0;
    String subjectName=subject.name;
    float subjectTrust=0;
    float t = _t;
    for (Peer p : peers) {
      if (p.name == talkerName) {
        talkerTrust = p.trust;
        println (talkerTrust+ " TakerTrust");
      }

      if (p.name == subjectName) {
        subjectTrust = p.trust;
        println (subjectTrust+ " SUBJECTTrust");
      }
    }
    //If the agent being gossiped about is more trustworthy than the gossiper...
    if (subjectTrust>talkerTrust) {
      //..look at the mental model 
      for (Peer p : peers) {
        //if the talker...
        if (p.name == talkerName) {
          //was being mean...
          if (t<0) {
            //trust them less
            println (p.trust+ " PTRUST1");
            p.trust -=.2;
            println (p.trust+ " PTRUST2");
          } else {
            //if not, trust them a little more
            println (p.trust+ " PTRUST1");
            p.trust +=.1;
            println (p.trust+ " PTRUST2");
          }
        }
      }
    } else //if the person gossiping is more trustworthy
    {
      for (Peer p : peers) {
        if (p.name == subjectName) {
          float trustBump = abs(p.trust-t);
          println (trustBump+ " TRUST IS BUMPIN");

          println (p.trust+ " PREBUMP");


          p.trust+= trustBump;
          println (p.trust+ " POSTBUMP");
          p.roll=_r;
        }
      }
    }
     println("===============================");
  }
 
}