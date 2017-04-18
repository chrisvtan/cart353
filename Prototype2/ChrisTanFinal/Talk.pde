class Talk {
  Agent from;
  Agent to;
  Thought subject;
  int iteration;
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector destination;
  float topSpeed;
  float size=20;
  boolean passed= false;
  //boolean madeIt = false;
  Talk (Agent _from, Agent _to, int _iteration, Thought _subject) {
    from = _from;
    to = _to;
    subject = _subject;
    iteration = _iteration;
    position = from.position.copy();
    destination = to.position.copy();
    velocity = new PVector (0, 0);
    topSpeed =2;
  }
  void run() {
    update();
    display();
    float d= position.dist(destination);
    if (d<10) {
      if (passed== false) {
        // if (iteration<passTimes) {

        to.updateBeliefs(this);
        to.passItOn(this);

        passed=true;
        // }
      }
    }
  }
  void updateInfo(Agent newTo) {
    destination= newTo.position;
  }

  void update() {
    acceleration =  PVector .sub(destination, position);
    acceleration.setMag(0.2);

    velocity.add(acceleration);

    velocity.limit(topSpeed);

    position.add(velocity);
  }
  void display() {
    fill(subject.agent.myColor);
    ellipse(position.x, position.y, size, size);
    fill(0);
    textAlign(CENTER, CENTER);
    //text(subject.agent.name,position.x,position.y);
  }
}