class Panel {

  //set panel size and location
  PVector origin = new PVector (700, 0);
  PVector size = new PVector (500, 700);

  //PImage maybe = loadImage("maybe.png");  
  //agnet to be displayed
  Agent held=null;

  //constructor
  Panel() {
  }

  //everytime run is called
  void run() {
    //draw the backboard
    board();
    //if there is a profile
    if (held!=null) {
      //call the profile display
      profile(held);
    }
    //if the licker id over an aent
    for (Agent n : agents) {
      float d= clicker.position.dist(n.position);

      if (d<n.size/2) {
        //set them to be the profile
        held = agents.get(n.number);
      }
    }
  }
  //draw a black backdrop
  void board() {
    fill (0);
    rect(origin.x, origin.y, size.x, size.y);
  }
  //take an agent as an arguemnt
  void profile(Agent n) {
    //fill with the agent color
    fill(n.myColor);
    textSize(50);
    textAlign(CENTER, CENTER);
    //siplay their info and icon in the top middle of the panel
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
    //set vertical offset
    int offset = 200;
    //thoughts for most/least trusted&witch
    Thought leastTrusted= null;
    Thought mostTrusted=null;
    Thought leastWitch=null;
    Thought mostWitch=null;
    //for each thought in the agent
    for (Thought t : n.thoughts) {
      //if it isnt a self thought
      if (t.agent.name!=n.name) {
        //if the least trusted is null
        if (leastTrusted==null) {
          //fill it with the first thought
          leastTrusted= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        //if the current thought is less trusted it becomes the current least trusted
        if (t.trust<leastTrusted.trust) {
          leastTrusted= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        //if the most trusted is null, fill it with the first thought
        if (mostTrusted==null) {
          mostTrusted= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        //if the current thought is most trusted it becomes the current most trusted
        if (t.trust>mostTrusted.trust) {
          mostTrusted= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        //if the most trusted is null, fill it with the first thought

        if (mostWitch==null) {
          mostWitch= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        //if the current thought is most witchy it becomes the current most witch
        if (t.witchMeter>mostWitch.witchMeter) {
          mostWitch= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        //if the least trusted is null, fill it with the first thought

        if (leastWitch==null) {
          leastWitch= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
        //if the current thought is less witchy it becomes the current least witch
        if (t.witchMeter<leastWitch.witchMeter) {
          leastWitch= new Thought(t.agent, t.trust, t.witchMeter, t.type);
        }
      }
    }
    //Display icon and info for least witchy
    leastWitch.display(new PVector(height+125, height/2+80));
    fill(255);
    textSize(20);
    text("Least Witchy", height+125, height/2+20);
    text(leastWitch.agent.name, height+125, height/2+135);

    //Display icon and info for most witchy
    mostWitch.display(new PVector(width-125, height/2+80));
    fill(255);
    textSize(20);
    text("Most Witchy", width-125, height/2+20);
    text(mostWitch.agent.name, width-125, height/2+135);

    //Display icon and info for most trusted
    mostTrusted.display(new PVector(height+125, height/2+80+offset));
    fill(255);
    textSize(20);
    text("Most Trusted", height+125, height/2+20+offset);
    text(mostTrusted.agent.name, height+125, height/2+135+offset);

    //Display icon and info for least trusted
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