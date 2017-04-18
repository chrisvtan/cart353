//Declare and Instantiate a new clickerobject
Clicker clicker =  new Clicker();
//Declare and Instantiate a new panel object
Panel panel= new Panel();
//Declare and Instantiate a new endscreen object
EndScreen endscreen = null;
//Declare and Instantiate number of agents in game
int agentNumber = 8;
//Declare and Instantiate the umber of times to pass information
int passTimes= 2;
//Declare and Instantiate a new milli tracker
int time= millis();
//variables to set threashold for minimum suspission an witch beliefs
int suspectMin =39;
int witchMin =49;
//timer for how mong between sporatic gossip
int gossipTimer =5;
//declare and instantiate a new arraylist to hold all of the agents
ArrayList <Agent> agents = new ArrayList<Agent>();
//Declare and Instantiate a new string array for the agent names
String[] names;
//Declare and Instantiate a new talk arraylist for all ofthe gossip objects
ArrayList<Talk> talks = new ArrayList<Talk>();
//Declare a new arraylist of the average thoughts on each agent
ArrayList<Thought> score;
//Boolean variables to lock certain actions
boolean voteOn=true;
boolean done = false;
//Declare new Image Objects for the tpye icons
PImage villager ;
PImage maybe ;
PImage witch ;

//Setup 
void setup() {
  //set size
  size(1200, 700);
  //set text size to 20
  textSize(20);
  //load each icon type
  villager = loadImage("villager.png"); 
  maybe = loadImage("maybe.png");  
  witch = loadImage("witch.png");  
  //load txt file into string array
  names = loadStrings("names.txt");
  //set a new pVector to offset the Agent arrya by
  PVector offSet = new PVector(height/2, height/2+80);
  //for loop to fill the agent array
  for (int i =0; i < agentNumber; i++) {
    //... get a vector using the getX&Y functions
    PVector agentPos = new PVector (getX(i), getY(i));
    //set the distance away from the origin by 200
    agentPos.setMag(200);
    //add the offset
    agentPos.add(offSet);
    //add a new npc with (name, location, and number)
    agents.add(new Agent(names[i], i, agentPos));
  }
  //get a random villager #
  int witchNumber = int(random(0, agentNumber));
  //set that # to be the witch
  agents.get(witchNumber).setWitch();
  //for each agent, call a function to set theri thoughts on eachother
  for (Agent n : agents) {
    n.setThoughts();
  }
  //set the score array
  score = new ArrayList<Thought>();
  //fill the score array with agents
  for (int i =0; i < agentNumber; i++) {
    score.add(new Thought(new Agent(agents.get(i).name, i, new PVector(700/agentNumber*i+50, 50)), 0, 0, new Unknown()));
  }
}
//ON EVERY FRAME
void draw() {
  //refresh the background
  background(255);
  //run the clicker
  clicker.run();
  //run the panel
  panel.run();
  //run each agent
  for (Agent n : agents) {
    n.run();
  }
  //run each talk action
  for (int i=0; i<talks.size(); i++) {

    talks.get(i).run();
  }
  //run the vote function
  vote();

  //if the town has a concensus (>49%), end the game
  if (done) {
    endscreen.display();
  }
  //timer fires a random talk every x seconds
  if (millis() > time + gossipTimer*1000)
  {
    randomGossip();
    println("EVERY2!"); 
    time = millis();
  }

  if (talks.size()>200) {
    talks.remove(0);
  }
}
//WHEN THE MOUSE IS PRESSED
void mousePressed() {
  // call clicker actions
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


void keyPressed() {
  if (key == 'v' || key == 'V') {
    voteOn=true;
    // //println("itTrue!");
  }
}

//Vote function
void vote() {
  //for each agent
  for (Agent n : agents) {
    //check theri thoguhts
    for (Thought t : n.thoughts) {
      //check to thoughts in score
      for (Thought s : score) {
        //if the subject matches in the arrays
        if (t.agent.name==s.agent.name) {
          //add ther agents thoughts on the subjects trust/witchiness to the colective conciousness
          s.trust+=t.trust;
          s.witchMeter+=t.witchMeter;
        }
      }
    }
  }

  //for each thoguth in score

  for (Thought t : score) {
    //divide by the number of agents to get the average trust
    t.trust = t.trust/score.size();
    ////divide by the number of agents to get the average witchmeter
    t.witchMeter = t.witchMeter/score.size();
    //show the thoughts
    t.display(new PVector(t.agent.position.x, t.agent.position.y));
    //if someone is above the threashold
    if (t.witchMeter>witchMin) {
      //end the game with them as the loser
      endscreen =new EndScreen(t);
      done=true;
    }
  }
}
//function to fire a random gossip
void randomGossip() {

  //get an random gossipee
  int randTo = int(random(agentNumber));
  Agent to = agents.get(randTo);
  //get an random gossiper
  int randFrom=getRandFrom(randTo);
  Agent from = agents.get(randFrom);
  //get an random gossip subject

  Thought subject= getRandSub(to, from);

  //for each person on the gossipers mind

  //add a new gossip action
  talks.add(new Talk(to, from, 0, subject ));
}


//Funtion to chose a new gossiper
int getRandFrom(int i) {
  //get a random number
  int r=int(random(agentNumber));
  //if it isnt the same as the arguments #
  if (r!=i) {
    //retunr it
    return r;
  } else {
    //else reroll
    return getRandFrom(i);
  }
}

//Funtion to return a random gossip subject takes the two gossipers as arguments
Thought getRandSub(Agent i, Agent j) {
  //set local varables to copy the agents from the argument
  Agent to = agents.get(i.number);
  Agent from = agents.get(j.number);
  //decalare each sub 
  Thought sub1=null;
  Thought sub2=null;
  Thought sub3=null;
  // go throught the senders array of thoughts
  for (Thought t : from.thoughts) {
    //set the thoughs as thought 1 to avoid errors
    if (sub1==null) {
      sub1 =  new Thought(t.agent, t.trust, t.witchMeter, t.type);
      sub2 =  new Thought(t.agent, t.trust, t.witchMeter, t.type);
      sub3 =  new Thought(t.agent, t.trust, t.witchMeter, t.type);
    }
    //if the current thought has a higher witch score than the 1st subject
    if (t.witchMeter>sub1.witchMeter) {
      //set sub 1 to be the current thought
      sub1 =  new Thought(t.agent, t.trust, t.witchMeter, t.type);
      //else if the current thought has a higher witch score than the 2nd subject
    } else if (t.witchMeter>sub2.witchMeter) {
      //set sub 2 to be the current thought
      sub2 =  new Thought(t.agent, t.trust, t.witchMeter, t.type);
      //else if the current thought has a higher witch score than the 3rd subject
    } else if (t.witchMeter>sub3.witchMeter) {
      //set sub 3 to be the current thought
      sub3 =  new Thought(t.agent, t.trust, t.witchMeter, t.type);
    } else {
      //if none of the above, change nothing
    }
  }

  

  //if the subject isnt the sender or receiver
  if ( sub1.agent.number!= to.number && sub1.agent.number!= from.number) {
    //return 1
    return sub1;
      //else check the 2nd sub. if they arent the sender or receiver
  } else if ( sub2.agent.number!= to.number && sub2.agent.number!= from.number) {
    //return 2
    return sub2;
  } else {
    //else return the 3rd
    return sub3;
  }
}