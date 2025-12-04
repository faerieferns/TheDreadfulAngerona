
class Button {

  /// initializing vars!
  int buttonX;
  int buttonY;

  int buttonWidth;
  int buttonLength;
  color buttonC;

  boolean isItBetween;
  boolean isMouseInButton;

  Button(int x, int y, color c) {
    buttonX = x;
    buttonY = y;
    buttonC = color(c);

    buttonWidth = 140;
    buttonLength = 70;
  }

  // functions!

  boolean isItBetween(int posn, int min, int max) {

    if (posn > min && posn < max) {
      return true;
    } else {
      return false;
    }
  }

  boolean isMouseInButton(int buttonX, int buttonY, int buttonW, int buttonH) {

    int buttonLeft = buttonX - buttonW/2;
    int buttonRight = buttonX + buttonW/2;
    int buttonTop = buttonY - buttonH/2;
    int buttonBottom = buttonY + buttonH/2;

    // if the mouse is within the button bounds, return true.
    if (isItBetween(mouseX, buttonLeft, buttonRight)&&
      isItBetween(mouseY, buttonTop, buttonBottom)) {
      return true;
      // otherwise, return false! :)
    } else {
      return false;
    }
  }

  boolean inButtonDetect() {
    if (isMouseInButton(buttonX, buttonY, buttonWidth, buttonLength) == true) {
      return true;
    } else {
      return false;
    }
  }

  void drawButton() {
    fill(buttonC);
    stroke(buttonC);
    rect(buttonX, buttonY, buttonWidth, buttonLength);
  }
}
