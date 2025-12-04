
class Enemy {

  PVector pos;
  PVector vel;
  int size;

  float left;
  float right;
  float top;
  float bottom;

  boolean shouldRemove;

  PImage[] soldierImages;
  Animation soldierAnimation;

  Enemy(float startX, float startY, float speed, Player aPlayer) {
    pos = new PVector(startX, startY);
    vel = (new PVector(aPlayer.x, aPlayer.y)).sub(pos);

    vel.normalize();
    vel.setMag(speed);

    size = 50;

    shouldRemove = false;

    soldierImages = new PImage[2];

    for (int index = 0; index <= soldierImages.length-1; index++) {

      soldierImages[index] = loadImage("soldier" + str(index) + ".png");
    }

    soldierAnimation = new Animation(soldierImages, 0.1, 0.7);
  }

  void render() {

    soldierAnimation.display(pos.x, pos.y);
    soldierAnimation.isAnimating = true;
  }

  void move() {
    pos.add(vel);

    float currentX = pos.x;
    float currentY = pos.y;

    right = currentX+size/2;
    left = currentX-size/2;
    top = currentY-size/2;
    bottom = currentY+size/2;
  }
}
