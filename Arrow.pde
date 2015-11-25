class Arrow extends Button {
  //Constructor method
  Arrow(float x1, float y1, float x2, float y2, float x3, float y3, color colour) {
    this.x1 = x1;
    this.x2 = x2;
    this.x3 = x3;
    this.y1 = y1;
    this.y2 = y2;
    this.y3 = y3;
    this.colour = colour;
  }//end Arrow constructor method

  void renderArrow() {
    fill(colour);
    stroke(colour);
    triangle(x1, y1, x2, y2, x3, y3);
  }//end renderArrow method
}