PImage tankImg, obstacleImg;
Obstacle obstacle;
Button btnStart;
Player player;  // creates new player

char screen = 's';

void setup() {
  size(800, 500);
  imageMode(CENTER);

  tankImg = loadImage("Tank13.png");
  obstacleImg = loadImage("Obstacle.png");

  obstacle = new Obstacle(200, 200, obstacleImg);
  player = new Player(tankImg, 400, 250, 0.4, 2.5);  // initialize player

  btnStart = new Button("PLAY GAME", width/2 - 100, 250, 200, 60);
}

void draw() {
  if (screen == 's') drawStart();
  else drawPlay();
}

void mousePressed() {
  if (screen == 's' && btnStart.clicked())
    screen = 'p';
}

void drawPlay() {
  background(100);

  obstacle.display();

  player.update();
  player.display();
}

void keyPressed()  { player.keyUpdate(key, true); }
void keyReleased() { player.keyUpdate(key, false); }
