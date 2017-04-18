//Talk class contains info passed between agents in a social interaction
class Talk {
  //Agent to and from hold direction of social forces
  Agent from;
  Agent to;
  //thought containing who is being talked about
  Thought subject;
  //int to track how many times a talkhas been spread
  int iteration;
  //pvectors for position acceleration, velocity, desination
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector destination;
  //tospeed
  float topSpeed;
  //size
  float size=20;
  //boolean to track if the talk has been passed
  boolean passed= false;


  //Constructor takes a to Agent, a From agent, and a thought being passed as well as the iteration of this thought
  Talk (Agent _from, Agent _to, int _iteration, Thought _subject) {
    //set to, from, itteration, and subject
    from = _from;
    to = _to;
    subject = _subject;
    iteration = _iteration;
    //get the same position as the sender
    position = from.position.copy();
    //set the destination to the receiver
    destination = to.position.copy();
    //set velocity to 0
    velocity = new PVector (0, 0);
    //set topspeed to 2
    topSpeed =2;
  }

  //everytime run is called
  void run() {
    //update the position
    update();
    //display the talk
    display();
    //if the talk has arrived...
    float d= position.dist(destination);
    if (d<10) {
      //if it hasn't been passsed on (prevents constant updating once received without deleting the talk)
      if (passed== false) {
        // update the beliefs
        to.updateBeliefs(this);
        //pass on the info
        to.passItOn(this);
        //set passed to true
        passed=true;
        // }
      }
    }
  }



  //change position
  void update() {
    //set a new pvector to desiation from current location
    acceleration =  PVector .sub(destination, position);
    //set acceleration to .2
    acceleration.setMag(0.2);
    //add the acceleration tot he velocity
    velocity.add(acceleration);
    //limit the velocity to the max speed
    velocity.limit(topSpeed);
    //update the position with the velocity
    position.add(velocity);
  }

  //display the talk
  void display() {
    //set the color to the smae as the subject
    fill(subject.agent.myColor);
    //draw A CIRCLE at position
    ellipse(position.x, position.y, size, size);
  }
}