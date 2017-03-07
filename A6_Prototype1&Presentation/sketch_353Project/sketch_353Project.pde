int count;
String names[];
PVector up = new PVector(0, -1);
PVector down = new PVector(0, 1);
PVector left = new PVector(-1, 0);
PVector right = new PVector(1, 0);

NPC[] npcs;
Player player;

void setup() {
  size (800, 800);
  names  = loadStrings("names.txt");
  count =6;
  npcs = new NPC[count];
  player = new Player(new PVector(width/2, width/2), 30);

  for (int i=0; i<count; i++) {
    npcs[i] = new NPC(new PVector(width/(count+1)*(i+1), width/2), 30, names[i]);
    npcs[i].setImage("photo"+i+".png");
  }
}


void draw() {
  background(255);
  for (NPC n : npcs) {
    n.run();
  }
  player.run();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      println("UP");
      player.applyForce(up);
    }
    if (keyCode == DOWN) {
      println("DOWN");
      player.applyForce(down);
    }
    if (keyCode == LEFT) {
      println("LEFT");
      player.applyForce(left);
    }
    if (keyCode == RIGHT) {
      println("RIGHT");
      player.applyForce(right);
    }
  }
}