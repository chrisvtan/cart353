class Talk {
  Agent from;
  Agent to;
  int iteration;
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector destination;
  float topSpeed;
  float size=20;
  boolean passed= false;
  //boolean madeIt = false;
  Talk (Agent _from, Agent _to, int _iteration) {
    from = _from;
    to = _to;
    iteration = _iteration;
    position = from.position.copy();
    destination = to.position.copy();
    velocity = new PVector (0, 0);
    topSpeed =2;
    println("MESSAGE FROM: "+ from.number +" TO "+to.number);
  }
  void run() {
    update();
    display();
    float d= position.dist(destination);
    if (d<10) {
      if (passed== false) {
        // if (iteration<passTimes) {
        println("SEND1");
      
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
    fill(from.myColor);
    ellipse(position.x, position.y, size, size);
  }
}