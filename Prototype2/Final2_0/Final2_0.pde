Clicker clicker =  new Clicker();
ArrayList <Agent> agents = new ArrayList<Agent>();
int agentNumber = 8;
ArrayList<Talk> talks = new ArrayList<Talk>();
Panel panel= new Panel();
int passTimes= 2;
void setup() {
  size(1200, 700);
  PVector offSet = new PVector(height/2, height/2);
  for (int i =0; i < agentNumber; i++) {
    //... get a vector using the getX&Y functions
    PVector agentPos = new PVector (getX(i), getY(i));
    //set the distance away from the origin by 200
    agentPos.setMag(200);

    agentPos.add(offSet);
    //add a new npc with (name, location, and number)
    agents.add(new Agent(i, agentPos));
  }
  int witch = int(random(0,agentNumber));
  agents.get(witch).setWitch();
  
  for (Agent n : agents) {
    n.setThoughts();
  }
}

void draw() {
  background(255);
  clicker.run();
  panel.run();
  for (Agent n : agents) {
    n.run();
  }

  for (int i=0; i<talks.size(); i++) {

    talks.get(i).run();
  }
}

void mousePressed() {

  clicker.pressed();
}


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