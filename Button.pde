class Button {
  //Fields
  float x1, x2, x3;
  float y1, y2, y3;
  color colour;
  private String label;
  protected float buttonW;
  protected float buttonH;

  //Getters and setters
  float getButtonW() {
    return buttonW;
  }

  float getButtonH() {
    return buttonH;
  }
  
  
  
  
  
  
  //Constructor method
  Button(){
    buttonW = width / 3.0f;
    buttonH = 40.0f;
  }
  
  void renderButton(/*int index*/){
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    fill(255);
    rect(x1, y1, buttonW, buttonH);
    fill(0);
    textSize(20);
    text(label, x1, y1);
    textSize(12);
  }
  
  boolean checkPressed(){
    if((mousePressed) && (mouseButton == LEFT) && (mouseX > x1 - (buttonW / 2.0f)) && (mouseX < x1 + (buttonW / 2.0f)) && (mouseY > y1 - (buttonH / 2.0f)) && (mouseY < y1 + (buttonH / 2.0f))){
     //println("Mouse clicked");
     //menu = 2;
     return true;
    }
    return false;
  }
  
  void setLabel(String label){
  this.label = label; 
  }
  
  void setButtonX(float x){
  x1 = x;
  }
  
  void setButtonY(float y){
   y1 = y;
  }
}