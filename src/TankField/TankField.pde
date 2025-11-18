PImage img;     // tank
PImage img2;    // obstacle

Obstacle obstacle; 

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
  img2 = loadImage("Obstacle.png");
// images are temporary
  obstacle = new Obstacle(200, 200, img2);  // creates the obstacle
  imageMode(CENTER);
}

void draw() {
  background(255);

 
  obstacle.display();

  // movement
  float moveX = 0;
  float moveY = 0;

  if (wDown) moveY -= 1;
  if (sDown) moveY += 1;
  if (aDown) moveX -= 1;
  if (dDown) moveX += 1;

  // updates the angle when moving
  if (moveX != 0 || moveY != 0) angle = atan2(moveY, moveX);

  // makes diagonal movement normal
  if (moveX != 0 || moveY != 0) {
    float mag = sqrt(moveX*moveX + moveY*moveY);
    moveX /= mag;
    moveY /= mag;

    x += moveX * speed;
    y += moveY * speed;
  }

  // draw tank
  pushMatrix(); //saves the current drawing screen
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

