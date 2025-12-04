class Animation {
  // variables
  PImage[] images;
  float speed;
  float scale;

  float index;
  boolean isAnimating;

  // constructor
  Animation(PImage[] tempImages, float tempSpeed, float tempScale) {
    images = tempImages;
    speed = tempSpeed;
    scale = tempScale;

    index = 0;
    isAnimating = false;

    for (int index = 0; index <= images.length-1; index++) {
      images[index].resize(int(images[index].width*scale),
        int(images[index].height*scale));
    }
  }

  // updates the index which image to display for
  // the animation
  void next() {
    index += speed;

    // resets the index if it is too big
    if (index >= images.length) {
      index=0;
      isAnimating=false;
    }
  }

  // display an image of the animation
  void display(float x, float y) {
    imageMode(CENTER);
    if (isAnimating) {
      int imageIndex = int(index);
      PImage img = images[imageIndex];
      image(img, x, y, img.width*scale, img.height*scale);

      // increment the index of the images to display
      next();
    } else {
      PImage img = images[1];
      image(img, x, y, img.width*scale, img.height*scale);
    }
  }
}
