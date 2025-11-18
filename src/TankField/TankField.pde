PImage img;     // tank image
PImage img2;    // obstacle image

float x = 400;
float y = 250;
float angle = 0;
float speed = 2.5;
float scaleFactor = 0.4;

//Key states
boolean wDown = false;
boolean aDown = false;
boolean sDown = false;
boolean dDown = false;

void setup() {
  size(800, 500);

  img = loadImage("tanksdsd.png");
  img2 = loadImage("Obstacle.png");   // <-- load your obstacle image

  imageMode(CENTER);
}

void draw() {
  background(255);

  //  draw the obstacle BEFORE the tank
  image(img2, 200, 200);   // choose any x,y to place it

  // movement
  float moveX = 0;
  float moveY = 0;

  if (wDown) moveY -= 1;
  if (sDown) moveY += 1;
  if (aDown) moveX -= 1;
  if (dDown) moveX += 1;

  // update angle when moving
  if (moveX != 0 || moveY != 0) {
    angle = atan2(moveY, moveX);
  }

  // normalize diagonal
  if (moveX != 0 || moveY != 0) {
    float mag = sqrt(moveX*moveX + moveY*moveY);
    moveX /= mag;
    moveY /= mag;

    x += moveX * speed;
    y += moveY * speed;
  }

  // draw tank
  pushMatrix();
  translate(x, y);
  rotate(angle); 
  scale(scaleFactor);
  image(img, 0, 0);
  popMatrix();
}

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
