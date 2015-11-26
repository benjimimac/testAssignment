class Menu {
  //Menu fields
  private float[] buttonX;
  private float[] buttonY;
  private int noOfButtons;
  private String[] buttonLabel;

  //Constructor methods
  Menu(int noOfButtons, String leagueA, String leagueB, String leagueC, String leagueD) {
    this.buttonX = new float[noOfButtons];
    this.buttonY = new float[noOfButtons];
    buttonLabel = new String[4];
    
    this.noOfButtons = noOfButtons;
    buttonLabel[0] = leagueA;
    buttonLabel[1] = leagueB;
    buttonLabel[2] = leagueC;
    buttonLabel[3] = leagueD;
    
    float tempX = width / 3.0f;
    float tempY = height / (float)(noOfButtons * 2);    
    for(int i = 0; i < noOfButtons; i++){
      buttonX[i] = tempX;
      buttonY[i] = tempY;
      tempY += height / (float)(noOfButtons);
    }
  }
  
  //render method
  void renderMenu(int count){
   background(0, 0, 255);
   ////rectMode(CENTER);
   //textAlign(CENTER, CENTER);
    
   //for(int i = 0; i < noOfButtons; i++){
   //  fill(255);
   //  rect(buttonX[i], buttonY[i], width / 3.0f, (height / 2) / (noOfButtons + 1));
   //  fill(0);
   //  textSize(20);
   //  text(buttonLabel[i], width / 2.0f, buttonY[i] + 30);
   //  textSize(12);
   //}
   //ArrayList<Rectangle> button = new ArrayList<Rectangle>();
   Rectangle button = new Rectangle();
   button.setButtonX(width / 2.0f);
   int tempCount = 0;
   for(int i = -count + 1; i < count; i++){
     
     if(i % 2 == 1 || i % 2 == -1){
       button.setButtonY((height / 2) + button.getButtonH() * i);
       button.setLabel(buttonLabel[tempCount]);
       button.renderRectangle();
       tempCount++;
     }
   }
   
   
  }
}