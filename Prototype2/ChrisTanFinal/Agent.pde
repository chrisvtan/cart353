class Agent {
  String name;
  ArrayList<Thought> thoughts= new ArrayList<Thought>();
  int number;
  PVector position;
  color myColor;
  int size =80;
  int extroversion;
  float trustChange = 2;
  Type myType = new Villager();

  PImage villager = loadImage("villager.png");  
  PImage maybe = loadImage("maybe.png");  
  PImage witch = loadImage("witch.png"); 



  Agent(String _name, int _number, PVector _position) {
    name = _name;
    number= _number;
    position= _position;
    myColor=setColor(_number);
    extroversion = int(random(1, 4));
  }



  void run() {

    display();

    for (Thought t : thoughts) {
      if (t.agent.name==name) {
        t.witchMeter=0;
      }
    }
  }



  void display() {
    fill(myColor);
    noStroke();
    ellipse(position.x, position.y, size, size);
    fill(0);
    textAlign(CENTER, CENTER);
    text(name, position.x, position.y+size/2+10);
  }

  void passItOn(Talk talk) {

    int newTo = int(random(0, agents.size()+1));
    int newFrom = int(random(0, agents.size()));

    if (talk.subject.agent.number==number) {
      for (Thought t : thoughts) {
        if (talk.from.number == t.agent.number) {
          ////println(talk.from.name+" Talks shit about me: "+name);
          //println(t.trust+" is what I used to think");
          t.trust -= trustChange;  
          //println(t.trust+" is what i now think");

          return;
        }
      }
    }

    if (talk.subject.agent.number!=number&&talk.iteration<passTimes) {
      talk.iteration++;
      for (int i=0; i<extroversion; i++) {
        talks.add(new Talk(agents.get(number), getNewTarget(talk), talk.iteration, talk.subject));
      }
    }
  }
  Agent getNewTarget(Talk talk) {

    int r = int(random(0, agentNumber));
    if (r != talk.from.number&& r !=talk.to.number) {
      return agents.get(r);
    } else if (r == talk.from.number|| r ==talk.to.number) {
      return getNewTarget(talk);
    } else { 
      return null;
    }
  }
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

  void setWitch() {
    myType = new Witch();
  }

  void setThoughts() {

    for (int i=0; i<agents.size(); i++) {
      float trust = random(10, 20);
      float witchMeter = random(50);
      if (i==number) {
        trust=99;
        witchMeter=-99;
      }
      thoughts.add(new Thought(agents.get(i), trust, witchMeter, new Unknown()));
    }
  }

  void updateBeliefs(Talk infoIn) {
    Thought tOnSub = null;
    Thought tOnFrom=null;

    //println("================================================");
    for (Thought t : thoughts) {
      if (infoIn.subject.agent == t.agent) {
        tOnSub=t;
        // //println(theirT.subject.agent.number+" SHOULD EQUAL " + t.agent.number);
      }

      if (infoIn.from == t.agent) {
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
        //println(name+" thinks that "+infoIn.from.name +" is right");
        for (Thought t : thoughts) {
          if (infoIn.subject.agent.number == t.agent.number) {
            t.witchMeter+=tOnFrom.trust/10;

            //println( tOnSub.agent.name+ "is witchy" );
          }

          if (tOnFrom.agent.number == t.agent.number) {
            t.trust+=trustChange;
          }
        }
      }
    }
    //println(name+" thinks that "+infoIn.from.name +" is right");
  }
}