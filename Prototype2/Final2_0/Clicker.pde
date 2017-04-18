class Clicker {
  //CLASS VARIABLES
  Agent from =null;
  Agent to =null;
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
          //println(n.number);
        }
      }
    }

    if (mouseButton==LEFT) {
      for (Agent n : agents) {
        float d= position.dist(n.position);
        if (d<n.size/2) {
          to = agents.get(n.number);

          if (from != null) {
            talks.add(new Talk(from, to,0));
          }
        }
      }
    }
  }
}