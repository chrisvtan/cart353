//declare a NPC array
NPC[] npcs;
//decalare and instantiate a clicker object
Clicker clicker = new Clicker();
//number of npcs we we have
int npcCount=6;
//Strign array containing list of object names
String[] nameList;
//into to track which object we are over
int hoverOver;


void setup() {

  size (600, 400);
  //instantiate npc array 
  npcs = new NPC[npcCount];
  //load names list
  nameList  = loadStrings("nameList.txt");
  //for each index of npcs
  for (int i=0; i<npcCount; i++) {
    //add a new NPC object
    npcs[i] = new NPC(new PVector(i*100, 00), width/npcCount, nameList[i]);
  }
}

void draw() {
  //update hoverover to the index number for the NPC we are hovering over
  hoverOver = floor(mouseX/(width/npcCount));
  //reset the background
  background(255);
  //run each NPC
  for (NPC n : npcs) {
    n.run();
  }
  //sho the clicker
  clicker.display();
}

//when mouse is pressed
void mousePressed() {
  //if a left click...
  if (mouseButton == LEFT) {
    //the fire the learn function of the NPC we are hovering over using the data sored in the clicker
    npcs[hoverOver].learn(clicker.r, clicker.g, clicker.b, clicker.charisma);
    //if right click
  } else if (mouseButton == RIGHT) {
    //load data from NPC we are hovering over into the clicker
    clicker.SetID(npcs[hoverOver].name, npcs[hoverOver].r, npcs[hoverOver].g, npcs[hoverOver].b, npcs[hoverOver].charisma, npcs[hoverOver].wisdom);
  }
}