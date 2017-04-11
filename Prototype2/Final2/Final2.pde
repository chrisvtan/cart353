
//Global Variables 
//Arraylist of Agents
ArrayList<NPC> npcs = new ArrayList<NPC>();
//String Array containing the names for Agents (names.txt goes to 26 names)
String[] names;
//set number of agents to use
int maxNpcs =8;
PVector mousePos= new PVector(mouseX, mouseY);
//declare and instantiate a new panel
Panel panel = new Panel();
//declare and instantiate a new panel
Clicker clicker = new Clicker();
NPC select;
NPC held;
NPC rec;
int roll=0;
boolean started =false;
boolean startedMid =false;
boolean startedRight =false;

PVector gossiperLoc = new PVector(50, 50);
PVector subjectLoc = new PVector(280, 50);
PVector recLoc = new PVector(450, 50);
PImage accused;
PImage bg;
//=======================================================================================================================================
//SETUP
void setup() {
  //CANVAS SETUP
  size(1200, 700);
  //load txt file into string array
  names = loadStrings("names.txt");
  //for each spot in the array...
  for (int i =0; i < maxNpcs; i++) {
    //... get a vector using the getX&Y functions
    PVector spot = new PVector (getX(i), getY(i));
    //set the distance away from the origin by 200
    spot.setMag(200);
    //add a new npc with (name, location, and number)
    npcs.add(new NPC(names[npcs.size()], spot, i ));
  }
  //call setPeer function after every npc is nstantiated so peers list can access all npc objects
  for (NPC n : npcs) {
    n.setPeers();
  }
  held = npcs.get(0);
  select = npcs.get(0);
  rec = npcs.get(0);
  accused= loadImage("0.jpg");
  bg= loadImage("back.jpg");
}
//=======================================================================================================================================

void draw() {
  //Run the clicker's funtions
  clicker.run();
  //refresh the background
  image(bg, 0, 0);
  //for each npc, run
  for (NPC n : npcs) {
    n.run();
  }
  if (started) {
    select.setLocation(gossiperLoc);
    fill(255, 0, 0);
    textSize(20);
    text("Gossips to", 170, 70);
    text("that", 350, 70);
    text("is", 550, 70);
  }
  if (startedMid) {
    held.setLocation(recLoc);
  }

  if (startedRight) {
    rec.setLocation(subjectLoc);
  }
  image (accused, 600, 10, 75, 75);
  //run the panel
  panel.run();
}
//=======================================================================================================================================
//on mousepressed...
void mousePressed() {
  if (mouseButton==CENTER) {
    startedMid=true;
    for (NPC n : npcs) {
      //check if the mouse is over it
      float c = clicker.position.dist(n.location);
      if (c<n.size/2) {
        //if it is, set that npc to selected
        held =npcs.get(n.number);
      }
    }
  }

  if (mouseButton==RIGHT) {
    startedRight= true;
    for (NPC n : npcs) {
      //check if the mouse is over it
      float c = clicker.position.dist(n.location);
      if (c<n.size/2) {
        //if it is, set that npc to selected
        rec =npcs.get(n.number);
      }
    }
  }

  if (mouseButton==LEFT) {
    started = true;
    for (NPC n : npcs) {
      //check if the mouse is over it
      float c = clicker.position.dist(n.location);
      if (c<n.size/2) {
        //if it is, set that npc to selected
        select =npcs.get(n.number);
        float t =0;

        for (Peer p : select.peers) {
          if (p.name==held.name) {
            t=p.trust;
          }
        } 
        n.receiveGossip(select, held, t, roll);
        println(select.name+ " gossips about " + held.name +" to "+ n.name+ "saying" +t );
      }
    }
  }
}

//=======================================================================================================================================
void keyPressed() {
  if (key == 'b' || key == 'B') {
    float randTrust = random(-1, 1);
    int randRoll = int(random (0, 8));
    int randAccuser = int(random (0, 8));
    int randRecipint = int(random (0, 8));
    int randSubject = int(random (0, 8));
    accused = loadImage(str(randRoll)+".jpg");

    npcs.get(randAccuser).receiveGossip(npcs.get(randRecipint), npcs.get(randSubject), randTrust, randRoll);
    rec =npcs.get(randRecipint);
    held =npcs.get(randSubject);
    select =npcs.get(randAccuser);
  }
  if (key=='0') { 
    accused = loadImage("0.jpg");
  }  
  if (key=='1') { 
    accused = loadImage("1.jpg");
  }  
  if (key=='2') { 
    accused = loadImage("2.jpg");
  }  
  if (key=='3') { 
    accused = loadImage("3.jpg");
  }  
  if (key=='4') { 
    accused = loadImage("4.jpg");
  }  
  if (key=='5') { 
    accused = loadImage("5.jpg");
  }  
  if (key=='6') { 
    accused = loadImage("6.jpg");
  }  
  if (key=='7') { 
    accused = loadImage("7.jpg");
  }
}

//=======================================================================================================================================
//funtion to set X position relative to origin Based on 8 npcs lots of magic numbers
int getX(int n) {
  if (n == 0||n==4) { 
    return 0;
  } else if (n<4) { 
    return -1;
  } else if (n>4) {
    return 1;
  } else return 0;
}


//funtion to set Y position relative to origin Based on 8 npcs lots of magic numbers
float getY(int n) {
  if (n == 2||n==6) { 
    return 0;
  } else if (n<6&&n>2) { 
    return -1;
  } else return 1;
}