//Endscren class to show a end game state
class EndScreen {
  //local thought to anounce the loser
  Thought loser;
  //Constructor takes a thought as an argument
  EndScreen(Thought t) {
    //set the loser to be the thought passed in
    loser = t;
  }

  //game end screen
  void display() {
    //make the screne black
    fill(0);
    rect(0, 0, width, height);
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255, 0, 0);
    //tell user who got voted as witch
    text(" We the townsfolk find "+loser.agent.name+" guilty of witchcraft", width/2, height/2);
  }
}