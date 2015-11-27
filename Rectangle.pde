class Rectangle extends Button{
  //Fields
  private String label;
  private color colour;
  
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
  
  //void checkPressed(){
  //  if((mousePressed) && (mouseButton == LEFT) && (mouseX > x1 - (buttonW / 2.0f)) && (mouseX < x1 + (buttonW / 2.0f)) && (mouseY > y1 - (buttonH / 2.0f)) && (mouseY < y1 + (buttonH / 2.0f))){
  //   println("Mouse clicked");
  //   menu = 2;
  //  }
  //}
  
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