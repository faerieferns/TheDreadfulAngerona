
class Boss {

  int x;
  int y;
  int d;

  int xSpeed;
  int ySpeed;

  int hp = 30;

  color c;

  int top;
  int bottom;
  int left;
  int right;

  int beamW;
  int beamH;

  PImage[] heroImages;
  Animation heroAnimation;

  PImage[] movingLeftImages;
  Animation movingLeft;

  PImage[] heroAttack;
  Animation heroAttacking;

  boolean shouldRemove;
  boolean isMovingRight;

  Boss() {

    x = width/2;
    y = height/2;
    d = 50;

    c = color(#FC8FD8);

    xSpeed = 30;
    ySpeed = 30;

    shouldRemove = false;
    hp = 5;

    beamW = 10;
    beamH = height/2;

    heroImages = new PImage[4];

    for (int index = 0; index <= heroImages.length-1; index++) {

      heroImages[index] = loadImage("hero_" + str(index) + ".png");
    }

    heroAnimation = new Animation(heroImages, 1, 1);

    movingLeftImages = new PImage[4];

    for (int index = 0; index <= movingLeftImages.length-1; index++) {

      movingLeftImages[index] = loadImage("heroLeft_" + str(index) + ".png");
    }

    movingLeft = new Animation(movingLeftImages, 1, 1);
  }

  Boss(int startingX, int startingY, int startingD, color startingC, int speed) {
    x = startingX;
    y = startingY;
    d = startingD;

    c = startingC;

    xSpeed = speed;
    ySpeed = speed;

    heroImages = new PImage[4];

    for (int index = 0; index <= heroImages.length-1; index++) {

      heroImages[index] = loadImage("hero_" + str(index) + ".png");
    }

    heroAnimation = new Animation(heroImages, 0.6, 0.6);

    movingLeftImages = new PImage[4];

    for (int index = 0; index <= movingLeftImages.length-1; index++) {

      movingLeftImages[index] = loadImage("heroLeft_" + str(index) + ".png");
    }

    movingLeft = new Animation(movingLeftImages, 0.6, 0.3);

    heroAttack = new PImage[4];

    for (int index = 0; index <= heroAttack.length-1; index++) {

      heroAttack[index] = loadImage("heroAttack_" + str(index) + ".png");
    }

    heroAttacking = new Animation(heroAttack, 1, 0.65);
  }

  void drawBoss() {

    if (isMovingRight == true) {
      bossShoot.stop();
      heroAnimation.display(x, y);
      heroAnimation.isAnimating = true;
    } else {
      bossShoot.stop();
      movingLeft.display(x, y);
      movingLeft.isAnimating = true;
    }
  }

  void drawBossAttack() {
    heroAttacking.display(x, y);
    heroAttacking.isAnimating = true;
    bossShoot.play();
  }

  void move() {
    x += xSpeed;
    y += ySpeed;

    top = y-d/2;
    bottom = y+d/2;
    right = x+d/2;
    left = x-d/2;
  }

  void wallDetect() {
    // detects wall detection for the right wall
    if (x+d/2 >= width) {
      xSpeed = -abs(xSpeed);
      isMovingRight = false;
    }
    // wall detection for left wall
    if (x-d/2 <= 0) {
      xSpeed = abs(xSpeed);
      isMovingRight = true;
    }

    // wall detection for the bottom wall
    if (y+d/2 >= height) {
      ySpeed = -abs(ySpeed);
    }
    // wall detection for left wall
    if (y-d/2 <= 300) {
      ySpeed = abs(ySpeed);
    }
  }

  void attack(Player aPlayer) {
    aPlayer.health = aPlayer.health-30;
  }

  void attackRender() {
    fill(#E5F7FC);
    stroke(#E5F7FC);
    rect(width/2, height/2-beamH/2, beamW, beamH);
  }
}
