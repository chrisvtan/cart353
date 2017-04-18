//Agent class that holds information and functionality for the Villagers who populate the town
class Agent {
  //Variables
  //String for the Agent name
  String name;
  //arraylist of each agent's thoughts
  ArrayList<Thought> thoughts= new ArrayList<Thought>();
  //agent id number used in checks
  int number;
  //agent position
  PVector position;
  //agent color
  color myColor;
  //agent size
  int size =80;
  //agent extroversion
  int extroversion;
  //the amount that gossip will alter the agent's trust of eachother
  float trustChange = 2;
  //declare a new type for the agent
  Type myType = new Villager();
  //load the images to be used
  PImage villager = loadImage("villager.png");  
  PImage maybe = loadImage("maybe.png");  
  PImage witch = loadImage("witch.png"); 


  //Constructor takes a name, number, and position
  Agent(String _name, int _number, PVector _position) {
    //set object variables to the constructors values
    name = _name;
    number= _number;
    position= _position;
    myColor=setColor(_number);
    //randomize an extroverison form 1-3
    extroversion = int(random(1, 4));
  }


  //each time run is called
  void run() {
    //display the agent
    display();
    //set their meantal model of themself to be 0 witchiness
    for (Thought t : thoughts) {
      if (t.agent.name==name) {
        t.witchMeter=0;
      }
    }
  }


  //function for all graphic elements of an Agent object
  void display() {
    //set the color to the unique ID color
    fill(myColor);
    noStroke();
    //draw the agent's circle
    ellipse(position.x, position.y, size, size);
    //in black, have their name below them
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, position.x, position.y+size/2+10);
  }
  //Function to process& possibly spread gossip received,takes a talk action as an arguemnt
  void passItOn(Talk talk) {

    // the gossip is about me
    if (talk.subject.agent.number==number) {
      for (Thought t : thoughts) {
        //trust the talker less
        if (talk.from.number == t.agent.number) {
          ////println(talk.from.name+" Talks shit about me: "+name);
          //println(t.trust+" is what I used to think");
          t.trust -= trustChange;  
          //println(t.trust+" is what i now think");
          //exit the funtion
          return;
        }
      }
    }
    //if the subject is not the agent receiving and the gossip is hasn't been assed too much
    if (talk.subject.agent.number!=number&&talk.iteration<passTimes) {
      //update the 'age' of the gossip
      talk.iteration++;
      //send out a gossip for each extroversion
      for (int i=0; i<extroversion; i++) {
        talks.add(new Talk(agents.get(number), getNewTarget(talk), talk.iteration, talk.subject));
      }
    }
  }

  //function to find new gossip targets
  Agent getNewTarget(Talk talk) {
    //get a random number between 0,7
    int r = int(random(0, agentNumber));
    //if the number isnt the received gossip's speaker and receiver
    if (r != talk.from.number&& r !=talk.to.number) {
      //send the gossip to the new random receiver
      return agents.get(r);
      //else if the number is the same as the previous talks' to and from,
    } else if (r == talk.from.number|| r ==talk.to.number) {
      //reroll
      return getNewTarget(talk);
    } else { 
      //if an error, retunr null
      return null;
    }
  }

  //Funtion to set the color based in the id number
  color setColor(int n) {
    color c =0;
    if (n==0) { 
      c=#468966;
    }
    if (n==1) { 
      c= #FFB03B;
    }
    if (n==2) { 
      c= #B64926;
    }
    if (n==3) { 
      c=#72B917;
    }
    if (n==4) { 
      c=#E75C84;
    }
    if (n==5) { 
      c=#9861E7;
    }
    if (n==6) { 
      c=#2980B9;
    }
    if (n==7) { 
      c=#851F00;
    }

    return c;
  }

  //funtion to change self type to witch
  void setWitch() {
    myType = new Witch();
  }
  //funtion to fill the thoughts array
  void setThoughts() {
    //for every agent
    for (int i=0; i<agents.size(); i++) {
      //set a random trust
      float trust = random(10, 20);
      //set a random witchiness
      float witchMeter = random(50);
      //if the thought is about me
      if (i==number) {
        //trust myself implicitly
        trust=99;
        witchMeter=-99;
      }
      //add a new thought about the agent with the newly rolled values for trust and witchiness
      thoughts.add(new Thought(agents.get(i), trust, witchMeter, new Unknown()));
    }
  }
  //Function to update beliefs
  void updateBeliefs(Talk infoIn) {
    //local thought variables
    Thought tOnSub = null;
    Thought tOnFrom=null;
    //for each thought
    for (Thought t : thoughts) {
      //if the thought is the same subject as the one being talked from
      if (infoIn.subject.agent == t.agent) {
        //set the local varible
        tOnSub=t;
        // //println(theirT.subject.agent.number+" SHOULD EQUAL " + t.agent.number);
      }
      //if the thought is the same subject as the one being talked to
      if (infoIn.from == t.agent) {
        //set the local varible
        tOnFrom=t;
        // //println(theirT.subject.agent.number+" SHOULD EQUAL " + t.agent.number);
      }
    }
    //if the gossip isnt about me
    if (tOnSub.agent.number != number) {
      //if I trust the subject more than the sender
      if (tOnSub.trust>tOnFrom.trust) {
        //go throught my thoughts 
        for (Thought t : thoughts) {
          //and find the liar
          if (infoIn.from.number == t.agent.number) {
            //println(name+" thinks that "+infoIn.from.name +" is A LIAR!");
            t.trust-=trustChange/5;
          } //if I trust the sender more than the subject
        }
      } else {
        //if the gossiper is reliable
        for (Thought t : thoughts) {
          //think about the subject
          if (infoIn.subject.agent.number == t.agent.number) {
            //and suspect them by 10% of my trust in the gossiper
            t.witchMeter+=tOnFrom.trust/10;

            //println( tOnSub.agent.name+ "is witchy" );
          }
          //trust the gossiper more since they gave me juicy news
          if (tOnFrom.agent.number == t.agent.number) {
            t.trust+=trustChange;
          }
        }
      }
    }
    //println(name+" thinks that "+infoIn.from.name +" is right");
  }
}