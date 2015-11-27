class Menu {
  //Menu fields
  private int noOfButtons;
  private String[] buttonLabel;
  private String title;

  //Constructor methods
  Menu(int noOfButtons, String buttonLabel[], String title) {
    this.buttonLabel = new String[noOfButtons];
    this.title = title;

    this.noOfButtons = noOfButtons;
    for (int i = 0; i < noOfButtons; i++) {
      this.buttonLabel[i] = buttonLabel[i];
      println(this.buttonLabel[i]);
    }
  }

  //render method
  void renderMenu() {
    background(0, 0, 255);
    Button button = new Button();
    button.setButtonX(width / 2.0f);
    int tempCount = 0;
    textSize(30);
    text(title, width / 2.0f, height * 0.1f);
    textSize(12);
    for (int i = -noOfButtons + 1; i < noOfButtons; i++) {

      if (noOfButtons % 2 == 0) {
        if (i % 2 == 1 || i % 2 == -1) {
          button.setButtonY(((height + 100) / 2) + button.getButtonH() * i);
          button.setLabel(buttonLabel[tempCount]);
          button.renderButton();
          boolean backOne = button.checkPressed();
          println(backOne);
          tempCount++;
          if (backOne) {
            pressed = true;
            menu = tempCount + 1;
          }
        }
      } else {
        if (i % 2 == 0) {
          button.setButtonY((height / 2) + button.getButtonH() * i);
          button.setLabel(buttonLabel[tempCount]);
          button.renderButton();
          boolean backOne = button.checkPressed();
          println(backOne);
          tempCount++;
          if (backOne) {
            pressed = true;
            menu = tempCount + 1;
          }
        }
      }
    }
  }
}