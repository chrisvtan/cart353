class Agent {
  ArrayList<Thought> thoughts= new ArrayList<Thought>();
  int number;
  PVector position;
  color myColor;
  int size =50;
  int extroversion;
  Type myType = new Villager();



  Agent(int _number, PVector _position) {

    number= _number;
    position= _position;
    myColor=setColor(_number);
    extroversion = int(random(1, 4));

    
   
  }



  void run() {

    display();
  }



  void display() {
    fill(myColor);
    noStroke();
    ellipse(position.x, position.y, size, size);
  }

  void passItOn(Talk talk) {
    println("GOT IT");
    int newTo = int(random(0, agents.size()+1));
    int newFrom = int(random(0, agents.size()));
    if (talk.iteration<passTimes) {
      talk.iteration++;
      for (int i=0; i<extroversion; i++) {
        talks.add(new Talk(agents.get(number), getNewTarget(talk), talk.iteration));
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
  
  void setThoughts(){
  
  for (int i=0; i<agents.size(); i++) {
      float trust = random(10);
      thoughts.add(new Thought(agents.get(i), trust, new Unknown()));
    }}
}