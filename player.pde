
class Player {

  // vars!!
  int x;
  int y;
  int d;

  int top;
  int bottom;
  int left;
  int right;

  int health = 100;

  PImage[] angeImages;
  Animation angeAnimation;

  /// constructor!!!
  Player() {
    x = width/2;
    y = 100;
    d = 100;

    top = y-d;
    bottom = y+d;
    right = x+d;
    left = x-d;

    angeImages = new PImage[7];

    for (int index = 0; index <= angeImages.length-1; index++) {

      angeImages[index] = loadImage("angerona_sprite" + str(index) + ".png");
    }

    angeAnimation = new Animation(angeImages, 0.3, 1);
  }

  void render() {
    angeAnimation.display(width/2, 125);
    angeAnimation.isAnimating = true;
  }

  void collision(Enemy anEnemy) {
    if (right >anEnemy.left &&
      top <anEnemy.bottom &&
      left <anEnemy.right &&
      bottom >anEnemy.top) {
      health = health - 20;
      println(health);
      anEnemy.shouldRemove = true;
    }
  }
}
