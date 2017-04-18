class Panel {
  PVector origin = new PVector (700, 0);
  PVector size = new PVector (500, 700);

  //PImage maybe = loadImage("maybe.png");  

  Agent held=null;
  Panel() {
  }


  void run() {
    board();
    if (held!=null) {
      profile(held);
    }
    for (Agent n : agents) {
      float d= clicker.position.dist(n.position);

      if (d<n.size/2) {
        held = agents.get(n.number);
      }
    }
  }
  void board() {
    fill (0);
    rect(origin.x, origin.y, size.x, size.y);
  }

  void profile(Agent n) {
    fill(n.myColor);
    textSize(50);
    textAlign(CENTER, CENTER);
    text(n.name, origin.x+(size.x/2), origin.y+ 20);
    text(n.myType.title, origin.x+(size.x/2), origin.y+ 70);
    ellipse(origin.x+(size.x/2), origin.y+220, 200, 200);
    imageMode(CENTER);
    if (n.myType.title=="Witch") {
      image(witch, origin.x+(size.x/2), origin.y+220, 180, 180);
    }
    if (n.myType.title=="Villager") {
      image(villager, origin.x+(size.x/2), origin.y+220, 180, 180);
    }
    int offset = 200;
    Thought leastTrusted= null;
    Thought mostTrusted=null;
    Thought leastWitch=null;
    Thought mostWitch=null;
    for (Thought t : n.thoughts) {
      if (t.agent.name!=n.name) {
        if (leastTrusted==null) {
          leastTrusted= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        if (t.trust<leastTrusted.trust) {
          leastTrusted= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }

        if (mostTrusted==null) {
          mostTrusted= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        if (t.trust>mostTrusted.trust) {
          mostTrusted= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }

        if (mostWitch==null) {
          mostWitch= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        if (t.witchMeter>mostWitch.witchMeter) {
          mostWitch= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        if (leastWitch==null) {
          leastWitch= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        if (t.witchMeter<leastWitch.witchMeter) {
          leastWitch= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
      }
    }

    leastWitch.display(new PVector(height+125, height/2+80));
    fill(255);
    textSize(20);
    text("Least Witchy", height+125, height/2+20);
    text(leastWitch.agent.name, height+125, height/2+135);

    mostWitch.display(new PVector(width-125, height/2+80));
    fill(255);
    textSize(20);
    text("Most Witchy", width-125, height/2+20);
    text(mostWitch.agent.name, width-125, height/2+135);


    mostTrusted.display(new PVector(height+125, height/2+80+offset));
    fill(255);
    textSize(20);
    text("Most Trusted", height+125, height/2+20+offset);
    text(mostTrusted.agent.name, height+125, height/2+135+offset);

    leastTrusted.display(new PVector(width-125, height/2+80+offset));
    fill(255);
    textSize(20);
    text("Least Trusted", width-125, height/2+20+offset);
    text(leastTrusted.agent.name, width-125, height/2+135+offset);

    //for (int i=0; i<n.thoughts.size(); i++) {
    //  textSize(20);
    //  textAlign(LEFT, CENTER);
    //  fill(n.thoughts.get(i).agent.myColor);
    //  text("name: "+n.thoughts.get(i).agent.name, origin.x+(size.x/2)-230, height/2+100+ offset*i);
    //  fill(255);
    //  text("trust: "+nf(n.thoughts.get(i).trust, 2, 2), origin.x+(size.x/2)-70, height/2+100+ offset*i);
    //  text("suspicion: "+nf(n.thoughts.get(i).witchMeter, 2, 2), origin.x+(size.x/2)+70, height/2+100+ offset*i);
    //}
  }
}