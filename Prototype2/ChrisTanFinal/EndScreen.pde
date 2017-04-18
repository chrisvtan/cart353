class EndScreen {
  Thought loser;

  EndScreen(Thought t) {
    loser = t;
  }


  void display() {
    fill(0);
    rect(0,0,width,height);
    textAlign(CENTER,CENTER);
    textSize(40);
    fill(255,0,0);
    text(" We the townsfolk find "+loser.agent.name+" guilty of witchcraft",width/2,height/2);
  }
}