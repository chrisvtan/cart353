int count;
String[] names;
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
    float r = random(255);
    float g = random(255);
    float b = random(255);
    int inf = int(random(100));
    int x = int(random(6));
    String suspect = names[x];
    npcs[i] = new NPC(new PVector(width/(count+1)*(i+1), width/2), 30, names[i], r, g, b, inf, suspect);
    npcs[i].setImage("photo"+i+".png");
  }
}


void draw() {
  background(122);
  int avR =0;
  int avG =0;
  int avB =0;
  for (NPC n : npcs) {
    n.run();
    avR += n.r;
    avG += n.g;
    avB += n.b;
  }
  avR =avR/count;
  avG =avG/count;
  avB =avB/count;
  fill(0);
  text(avR, width/4, height-100);
  text(avG, width/2, height-100);
  text(avB, (width/4)*3, height-100);
  player.run();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      for (NPC n : npcs) {
        // n.suspect1 = n.decide();
        printArray(n.suspects);
      }
      //player.applyForce(up);
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