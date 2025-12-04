
class Bullet {

  // variables!!
  PVector pos;
  PVector vel;
  int d;

  int speed;

  float top;
  float bottom;
  float left;
  float right;

  PImage[] bulletImages;
  Animation bulletAnimation;

  boolean shouldRemove;

  // constructor!!
  Bullet(int startX, int startY, int destinationX, int destinationY) {
    pos = new PVector(startX, startY);
    vel = (new PVector(destinationX, destinationY)).sub(pos);

    // normalize the velocity vector!!
    speed = 8;
    vel.normalize();
    vel.setMag(speed);

    d = 15;




    bulletImages = new PImage[9];

    for (int index = 0; index <= bulletImages.length-1; index++) {

      bulletImages[index] = loadImage("black_hole" + str(index) + ".png");
    }

    bulletAnimation = new Animation(bulletImages, 1, 0.7);
  }

  void render() {
    fill(#A5142F);
    stroke(#A5142F);
    circle(pos.x, pos.y, d);

    bulletAnimation.display(pos.x, pos.y);
    bulletAnimation.isAnimating = true;
  }

  void move() {
    pos.add(vel);

    float currentX = pos.x;
    float currentY = pos.y;

    right = currentX+d/2;
    left = currentX-d/2;
    top = currentY-d/2;
    bottom = currentY+d/2;
  }

  void collision(Enemy anEnemy) {
    if (right >anEnemy.left &&
      top <anEnemy.bottom &&
      left <anEnemy.right &&
      bottom >anEnemy.top) {
      anEnemy.shouldRemove = true;
      shouldRemove = true;
      enemyDeath.play();
    }

    if (pos.x < 0 && pos.x > width
      && pos.y < 0 && pos.y > height) {
      shouldRemove = true;
    }
  }

  void collision2(Boss aBoss) {

    if (right >aBoss.left &&
      top <aBoss.bottom &&
      left <aBoss.right &&
      bottom >aBoss.top) {
      aBoss.hp = aBoss.hp-1;
      shouldRemove = true;
      enemyDeath.play();
      if (aBoss.hp <= 0) {
        state = 8;
      }
    }
  }
}
