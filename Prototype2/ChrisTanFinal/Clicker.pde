
class Clicker {
  //CLASS VARIABLES
  Agent from =null;
  Agent to =null;
  Thought subject =null;
  PVector position;
  //=======================================================================================================================================
  //CONSTRUCTOR
  Clicker() {
    position = new PVector(mouseX, mouseY);
  }


  //=======================================================================================================================================
  void run() {
    update();
  }

  void update() {
    position.x = mouseX;
    position.y = mouseY;
  }

  void pressed() {
    ArrayList<Agent> aL = agents;


    if (mouseButton==RIGHT) {
      for (Agent n : agents) {
        float d= position.dist(n.position);
        if (d<n.size/2) {
          from = agents.get(n.number);
          println("Gossiper: "+from.name);
        }
      }
    }


    //if leftclicked
    if (mouseButton==LEFT) {
      //go through all agents
      for (Agent n : agents) {
        //get the distance between the clicker and the agent
        float d= position.dist(n.position);
        //if the mouse is within the agent
        if (d<n.size/2) {
          //set the receiver to the agent we are over
          to = agents.get(n.number);
          println("Target: "+to.name);
          //go through each though that the sender has
          for (Thought t : from.thoughts) {
            //if the subject hasnt been chosen yet
            if (subject == null) {
              //if the agent i'm thinking of doesn't have the same id as me
              if (t.agent.number != n.number) {
                //set the subject to copy the current agent thought about
                subject = new Thought(t.agent, t.trust, t.witchMeter, t.type);
              }
            } 
            //if the subject isn't null && their witch meter is higher than the current subject's witch meter 
            else if (t.witchMeter>subject.witchMeter) {
              //set the subject to be match the current agent beign thought of
              subject = new Thought(t.agent, t.trust, t.witchMeter, t.type);
            }
          }
          //if there is a sender held in from
          if (from != null) {
            //add a new talk action to the talks array with an iteration of 0 about the subject
            talks.add(new Talk(from, to, 0, subject));
            //println(from.name+ " is gossiping to: "+to.name + " about: " +subject.agent.name);
            subject=null;
          }
        }
      }
    }
  }
}