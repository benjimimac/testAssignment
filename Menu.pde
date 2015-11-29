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
          boolean buttonSelected = button.checkPressed();
          tempCount++;
          if (buttonSelected) {
            pressed = true;
            if (menu == 0) {
              menu = tempCount;
              subMenu = 0;
            } else {
              subMenu = tempCount;
            }
          }
        }
      } else {
        if (i % 2 == 0) {
          button.setButtonY((height / 2) + button.getButtonH() * i);
          button.setLabel(buttonLabel[tempCount]);
          button.renderButton();
          boolean buttonSelected = button.checkPressed();
          tempCount++;
          if (buttonSelected) {
            pressed = true;
            if (menu == 0) {
              menu = tempCount;
              subMenu = 0;
            } else {
              subMenu = tempCount;
            }
          }
        }
      }
    }
    if (menu != 0) {
      returnButton.setButtonX(width / 2.0f);
      returnButton.setButtonY(height - 30.0f);
      returnButton.setLabel("Return");
      returnButton.renderButton();
      boolean backOne = returnButton.checkPressed();
      if (backOne) {
        if (subMenu != 0) {
          subMenu = 0;
          pressed = true;
        }
        else{
         menu = 0;
         pressed = true;
        }
      }
    }
  }
}