class Menu {
  //Menu fields
  private float button1x;
  private float button1y;
  private float button2x;
  private float button2y;
  private float button3x;
  private float button3y;
  private float button4x;
  private float button4y;

  //Constructor methods
  Menu(int noOfButtons) {
    if (noOfButtons == 1) {
      this.button1x = width / (noOfButtons + 1);
      this.button1y = height / (noOfButtons + 1);
    }
  }
}