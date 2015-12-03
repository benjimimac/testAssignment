class Graph {
  //fields
  private float graphMargin;
  private float graphTop;
  private float graphW;
  private float graphH;
  private color colour[];
  private String[] leagueNames;
  private int graphMax;
  private int graphY;
  private float gap;
  
  //Constructor method
  Graph(String[] leagueNames) {
    graphMargin = width * 0.1f;
    graphTop = height * 0.2f;
    graphW = width - (graphMargin * 2);
    graphH = height - (graphTop * 2);
    this.leagueNames = leagueNames;
    int tempMax = 0;
    for(int i = 0; i < goal.size(); i++){
      for(int j = 0; j < goal.get(i).size(); j++){
        if(goal.get(i).get(j) > tempMax){
          tempMax = goal.get(i).get(j);
        }//end if
      }//end for(j)
    }//end for(i)
    graphMax = tempMax + 500 - (tempMax % 500);
    graphY = graphMax / 10;
    gap = graphW / (goal.size() * 2);
  }//end Graph constructor method
  
  void renderGraph(/*int currentSeason*/){
    background(255);
    stroke(0);
    fill(255, 0, 0);
    line(graphMargin, graphTop, graphMargin, height - graphTop);
    line(graphMargin, height - graphTop, graphMargin + graphW, height - graphTop );
    
    //Draw the Y axis marks and put in the count scale
    textAlign(CENTER, CENTER);
    for(int i = 0; i <= SEASONS; i++){
      line(graphMargin, height - graphTop - ((graphH * 0.1f) * i), graphMargin - 5.0f, height - graphTop - ((graphH * 0.1f) * i));
      text(graphY * i, graphMargin * 0.5f, height - graphTop - ((graphH * 0.1f) * i));
    }//end for(i)
    
    //draw the graph data
    rectMode(CORNER);
    for(int i = 0; i < goal.size(); i++){
      rect(graphMargin + ((gap * 2) * i), height - graphTop, gap, map(goal.get(i).get(currentSeason), 0, graphMax, 0, -graphH));
    }//end for(i)
    
    Button returnButton = new Button();
    returnButton.setButtonX(width / 2.0f);
    returnButton.setButtonY(height - 30.0f);
    returnButton.setLabel("Return");
    returnButton.renderButton();
    boolean backOne = returnButton.checkPressed();
    if(backOne){
      subOption1 = 0;
      pressed = true;
    }
  }//end renderGraph method
}