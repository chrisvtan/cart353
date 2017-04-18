class Thought {
  Agent agent;
  float trust;
  float witchMeter;
  Type type;

  Thought(Agent _agent, float _trust, Type _type) {
    agent = _agent;
    trust =_trust;
    type = _type;
    witchMeter = random(0, 50);
  }



  void update() {
  }
}