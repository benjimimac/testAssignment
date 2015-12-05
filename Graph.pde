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
  private float barW;
  private float change;

  //Constructor method
  Graph(String[] leagueNames) {
    graphMargin = width * 0.1f;
    graphTop = height * 0.2f;
    graphW = width - (graphMargin * 2);
    graphH = height - (graphTop * 2);
    this.leagueNames = leagueNames;
    int tempMax = 0;
    for (int i = 0; i < goal.size(); i++) {
      for (int j = 0; j < goal.get(i).size(); j++) {
        if (goal.get(i).get(j) > tempMax) {
          tempMax = goal.get(i).get(j);
        }//end if
      }//end for(j)
    }//end for(i)
    graphMax = tempMax + 500 - (tempMax % 500);
    graphY = graphMax / 10;
    barW = graphW / goal.size();
    color[] colour = {color(255), color(210, 6, 11), color(54, 152, 42), color(0, 70, 143)};
    this.colour = colour;
    change = 10.0f;
  }//end Graph constructor method

  void renderGraph(/*int currentSeason*/) {
    background(255);
    stroke(0);
    fill(0);
    line(graphMargin, graphTop, graphMargin, height - graphTop);
    line(graphMargin, height - graphTop, graphMargin + graphW, height - graphTop );
    moveLeft = false;
    moveRight = false;

    //Draw the Y axis marks and put in the count scale
    textAlign(CENTER, CENTER);
    for (int i = 0; i <= SEASONS; i++) {
      line(graphMargin, height - graphTop - ((graphH * 0.1f) * i), graphMargin - 5.0f, height - graphTop - ((graphH * 0.1f) * i));
      text(graphY * i, graphMargin * 0.5f, height - graphTop - ((graphH * 0.1f) * i));
    }//end for(i)

    if (subOption1 == 1) {
      //draw the graph data
      rectMode(CORNER);
      for (int i = 0; i < goal.size(); i++) {
        int tempPoint = (int)lastPoint[i];
        fill(0);
        float graphY = map(tempPoint, 0, graphMax, 0, -graphH);
        //text(goal.get(i).get(currentSeason), graphMargin + (barW * 0.5f) + (barW * 2 * i), height - graphY);
        textAlign(CENTER, BOTTOM);
        text(tempPoint, graphMargin + (barW * 0.5f) + (barW * i), height - graphTop + graphY);
        textAlign(CENTER, TOP);
        text(leagueNames[i], graphMargin + (barW * 0.5f) + (barW * i), height - graphTop, 0);
        fill(colour[i]);
        rect(graphMargin + ((barW) * i), height - graphTop, barW, graphY);

        //Creates an animation effect on the graph
        if (lastPoint[i] < goal.get(i).get(currentSeason)) {
          if (lastPoint[i] > goal.get(i).get(currentSeason) - change) {
            lastPoint[i] = goal.get(i).get(currentSeason);
            colour1 = arrowOnColour;
            colour2 = arrowOnColour;
          } 
            lastPoint[i] += change;
          
        }

        if (lastPoint[i] > goal.get(i).get(currentSeason)) {
          if (lastPoint[i] < goal.get(i).get(currentSeason) + change) {
            lastPoint[i] = goal.get(i).get(currentSeason);
            colour1 = arrowOnColour;
            colour2 = arrowOnColour;
          } else {
            lastPoint[i] -= change;
          }
        }
      }//end for(i)
    }//end if()

    //Add two toggle buttons to change seasons
    Arrow arrow1 = new Arrow(width * 0.25f, (float)height - 60.0f, width * 0.25f, (float)height - 20.0f, (width * 0.25f) - 40.0f, (float)height - 40.0f, colour1);
    Arrow arrow2 = new Arrow(width * 0.75f, (float)height - 60.0f, width * 0.75f, (float)height - 20.0f, (width * 0.75f) + 40.0f, (float)height - 40.0f, colour2);

    arrow1.renderArrow();
    arrow2.renderArrow();

    color testColor = get(mouseX, mouseY);
    if (testColor == colour1 && mousePressed && (mouseButton == LEFT) && currentX < width * 0.25f && !moveRight) {
      colour1 = arrowOffColour;
      if (currentSeason > 0) {      
        go.rewind();
        go.play();
        moveRight = true;
        currentSeason -= 1;
        testColor = color(0);
      } else {
        //maybe play a soundfile

        colour1 = arrowOnColour;
        stop.rewind();
        stop.play();
        moveRight = false;
      }
      currentX = width / 2;
      currentY = height / 2;
    }

    else if (testColor == colour2 && mousePressed && (mouseButton == LEFT) && currentX > width * 0.75f && !moveLeft) {
      colour2 = arrowOffColour;
      if (currentSeason < SEASONS - 1) {
        go.rewind();
        go.play();
        moveLeft = true;
        currentSeason += 1;
        testColor = color(0);
      } else {
        //maybe play a soundfile
        colour2 = arrowOnColour;

        stop.rewind();
        stop.play();
      }
      currentX = width / 2;
      currentY = height / 2;
    }
  
    println("testColour is " + testColor + ", colour1 is " + colour1 + ", mousePressed is " + mousePressed + ", mouseButton is " + mouseButton + ", currentX is " + currentX + ", moveLeft is " + moveLeft);
  
    //currentX = 0;
    //if (moveRight) {
    // moveRight = false;
    //}//end if()

    //if (moveLeft) {
    // moveLeft = false;
    //}//end if()

    Button returnButton = new Button();
    returnButton.setButtonX(width / 2.0f);
    returnButton.setButtonY(height - 30.0f);
    returnButton.setLabel("Return");
    returnButton.renderButton();
    boolean backOne = returnButton.checkPressed();
    if (backOne) {
      subOption1 = 0;
      pressed = true;
    }
  }//end renderGraph method
}