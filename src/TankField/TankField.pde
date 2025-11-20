PImage img;     // tank
PImage img2;    // obstacle
Obstacle obstacle; 

char screen = 's';
Button btnStartPlay;

float x = 400;
float y = 250;
float angle = 0;
float speed = 2.5;
float scaleFactor = 0.4;

// Key states
boolean wDown = false;
boolean aDown = false;
boolean sDown = false;
boolean dDown = false;

void setup() {
  size(800, 500);

  img = loadImage("Tank13.png");
  img2 = loadImage("Obstacle.png");

  obstacle = new Obstacle(200, 200, img2);  // creates the obstacle
  imageMode(CENTER);

  btnStartPlay = new Button("PLAY GAME", 0, 0, 200, 60); // 
}

void draw() {
  switch(screen) {
    case 's':
      drawStartScreen();
      break;
    case 'p':
      drawPlay();
      break;
  }
}

// ----------------------
// START SCREEN
// ----------------------
void drawStartScreen() {
  background(60, 180, 120);

  textAlign(CENTER);
  fill(255);
  textSize(50);
  text("MY TANK GAME", width/2, 120);

  textSize(22);
  text("Click PLAY to start", width/2, 180);

  // Center button
  btnStartPlay.x = width/2 - btnStartPlay.w/2;
  btnStartPlay.y = 250;
  btnStartPlay.display();
}

void mousePressed() {
  if (screen == 's') {
    if (btnStartPlay.clicked()) {
      screen = 'p';
    }
  }
}

// ----------------------
// PLAY SCREEN
// ----------------------
void drawPlay() {
  background(100);

  obstacle.display();

  // movement
  float moveX = 0;
  float moveY = 0;

  if (wDown) moveY -= 1;
  if (sDown) moveY += 1;
  if (aDown) moveX -= 1;
  if (dDown) moveX += 1;

  if (moveX != 0 || moveY != 0) angle = atan2(moveY, moveX);

  if (moveX != 0 || moveY != 0) {
    float mag = sqrt(moveX*moveX + moveY*moveY);
    moveX /= mag;
    moveY /= mag;

    x += moveX * speed;
    y += moveY * speed;
  }

  pushMatrix();
  translate(x, y);
  rotate(angle);
  scale(scaleFactor);
  image(img,40, 20);
  popMatrix(); 
}

// ----------------------
// KEY HANDLING
// ----------------------
void keyPressed() {
  if (key == 'w' || key == 'W') wDown = true;
  if (key == 'a' || key == 'A') aDown = true;
  if (key == 's' || key == 'S') sDown = true;
  if (key == 'd' || key == 'D') dDown = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wDown = false;
  if (key == 'a' || key == 'A') aDown = false;
  if (key == 's' || key == 'S') sDown = false;
  if (key == 'd' || key == 'D') dDown = false;
}

// ----------------------
// BUTTON CLASS
// ----------------------
class Button {
  String label;
  float x, y, w, h;

  Button(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    if (isHovering()) fill(220);
    else fill(255);

    stroke(0);
    rect(x, y, w, h, 8);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(18);
    text(label, x + w/2, y + h/2);
  }

  boolean isHovering() {
    return mouseX > x && mouseX < x + w &&
           mouseY > y && mouseY < y + h;
  }

  boolean clicked() {
    return isHovering();
  }
}
