class Panel {
  //CLASS VARIABLES
  PVector origin = new PVector (700, 0);
  PVector size = new PVector (500, 700);
  //=======================================================================================================================================
  //CONSTRUCTOR
  Panel() {
  }




  void run() {
    board();
    if (started) {
      subject(select);
    }
  }
  void board() {
    fill(0);
    rect(origin.x, origin.y, size.x, size.y);
  };

  void subject(NPC n) {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(30);
    text(n.name, origin.x+(size.x/2), origin.y+ 30);
    text(n.number, origin.x+(size.x/2), origin.y+ 60);
    //CHANGE ME!
    image(n.icon, origin.x+(size.x/2)-100, origin.y+ 100);
    int offset = 50;
    //println(n.peers.size());
    for (int i=0; i<n.peers.size(); i++) {
      textSize(20);
      fill(n.peers.get(i).myColor);
      text(n.peers.get(i).name, origin.x+(size.x/2)-100, height/2+ offset*i);
      text(n.peers.get(i).trust, origin.x+(size.x/2)+50, height/2+ offset*i);
      n.peers.get(i).location = new PVector (origin.x+(size.x/2)+150, height/2+ offset*i);
      n.peers.get(i).display();
      //n.peers.get(i).upVote.active=true;
      //n.peers.get(i).downVote.active=true;
    }
  }
}