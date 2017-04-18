class Thought {
  Agent agent;
  float trust;
  float witchMeter;
  Type type;

  Thought(Agent _agent, float _trust, float _witchMeter, Type _type) {
    agent = _agent;
    trust =_trust;
    type = _type;
    witchMeter = _witchMeter;
  }



  void update() {
  }

  void display(PVector xy) {
    fill(agent.myColor);
    ellipse(xy.x, xy.y, agent.size, agent.size);
    fill(0);

    textSize(12);
    //text(agent.name, xy.x, xy.y);
    text(agent.name, xy.x, xy.y+50);
    text("Trust: "+nf(trust, 2, 2), xy.x, xy.y+70);
    text("Witch: "+nf(witchMeter, 2, 2), xy.x, xy.y+85);
    imageMode(CENTER);
    if (witchMeter<suspectMin) {
      image(villager, xy.x, xy.y, agent.size-10, agent.size-10);
    } else if (witchMeter<witchMin) {
      image(maybe, xy.x, xy.y, agent.size-10, agent.size-10);
    } else {
      image(witch, xy.x, xy.y, agent.size-10, agent.size-10);
    }
  }
}