//Class for thought object
class Thought {

  //Thougt is about an agent
  Agent agent;
  //holds how trusted they are
  float trust;
  //tracks how suspicious they are
  float witchMeter;
  //tracks their type
  Type type;

  //Constructor takes agent, trust, witchiness, and type
  Thought(Agent _agent, float _trust, float _witchMeter, Type _type) {
    //assign all ariables
    agent = _agent;
    trust =_trust;
    type = _type;
    witchMeter = _witchMeter;
  }



  void update() {
  }

  //display a thought takes a PVector as an argument
  void display(PVector xy) {
    //fill it with the subject's color
    fill(agent.myColor);
    //draw a outliner circle
    ellipse(xy.x, xy.y, agent.size, agent.size);
    //set text info size and color
    fill(0);
    textSize(12);
    //write the agent's name
    text(agent.name, xy.x, xy.y+50);
    //write the agent's trust
    text("Trust: "+nf(trust, 2, 2), xy.x, xy.y+70);
    //write the agent;s witchiness
    text("Witch: "+nf(witchMeter, 2, 2), xy.x, xy.y+85);
    //set the image mode to center
    imageMode(CENTER);
    //if they are not suspicious
    if (witchMeter<suspectMin) {
      //draw a vilalger
      image(villager, xy.x, xy.y, agent.size-10, agent.size-10);
      //if they are a little suspicous
    } else if (witchMeter<witchMin) {
      //show a sketchy villager
      image(maybe, xy.x, xy.y, agent.size-10, agent.size-10);
    } else {
      //if they are more, show the witch image
      image(witch, xy.x, xy.y, agent.size-10, agent.size-10);
    }
  }
}