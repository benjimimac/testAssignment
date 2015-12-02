class Graph {
  //fields
  private float tableMargin;
  private float tableTop;
  private float tableW;
  private float tableH;
  private color colour[];
  private String[] leagueNames;
  
  //Constructor method
  Graph(String[] leagueNames) {
    tableMargin = width * 0.1f;
    tableTop = height * 0.1f;
    tableW = width - (tableMargin * 2);
    tableH = height - (tableTop * 2);
    this.leagueNames = leagueNames;
  }//end Graph constructor method
  
  void renderGraph(int season){
    background(0);
    stroke(255);
    fill(255, 0, 0);
    line(tableMargin, tableTop, tableMargin, height - tableTop);
    line(tableMargin, height - tableTop, tableMargin + tableW, height - tableTop );
    
    for(int i = 0; i < 
  }//end renderGraph method
}