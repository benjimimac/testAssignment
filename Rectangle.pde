class Rectangle extends Button{
  //Fields
  private String label;
  
  //Constructor method
  Rectangle(){
    buttonW = width / 3.0f;
    buttonH = 40.0f;
  }
  
  void renderRectangle(/*int index*/){
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    fill(255);
    rect(x1, y1, buttonW, buttonH);
    fill(0);
    textSize(20);
    text(label, x1, y1);
    textSize(12);
  }
  
  float getButtonH(){
   return buttonH; 
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