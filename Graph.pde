class Graph {
  //fields
  private float graphMargin;
  private float graphTop;
  private float graphW;
  private float graphH;
  private color colour[];
  private String[] leagueNames;
  private float graphMax;
  private float graphY;
  private float barW;
  private float change;
  private String[] message;
  private String[] tempMax; 

  //Constructor method
  Graph(String[] leagueNames, String[] message) {
    graphMargin = width * 0.1f;
    graphTop = height * 0.2f;
    graphW = width - (graphMargin * 2);
    graphH = height - (graphTop * 2);
    this.leagueNames = leagueNames;
    int tempMostGoalMax = 0;
    float tempGoalAverage = 0.0f; 
    int tempMostCleansheet = 0;
    for (int i = 0; i < goal.size(); i++) {
      for (int j = 0; j < goal.get(i).size(); j++) {
        if (goal.get(i).get(j) > tempMostGoalMax) {
          tempMostGoalMax = goal.get(i).get(j);
        }//end if
        if (goalAverage.get(i).get(j) > tempGoalAverage) {
          tempGoalAverage = goalAverage.get(i).get(j);
        }
        if (cleansheet.get(i).get(j) > tempMostCleansheet) {
          tempMostCleansheet = cleansheet.get(i).get(j);
        }
      }//end for(j)
    }//end for(i)

    if (subOption1 == 1) {
      graphMax = tempMostGoalMax + 100 - (tempMostGoalMax % 100);
      change = 10.0f;
    } else if (subOption1 == 2) {
      graphMax = tempGoalAverage + 5 - (tempMostGoalMax % 5);
      change = 2.0f;
    } else if (subOption1 == 3) {
      graphMax = tempMostCleansheet + 10 - (tempMostGoalMax % 10);
      change = 5.0f;
    }
    graphY = graphMax / 10;
    barW = graphW / NOOFLEAGUES;
    color[] colour = {color(255), color(210, 6, 11), color(54, 152, 42), color(0, 70, 143)};
    this.colour = colour;
    this.message = message;
    tempMax = new String[NOOFLEAGUES];
  }//end Graph constructor method

  void renderGraph() {
    background(grey);
    stroke(0);
    fill(0);
    line(graphMargin, graphTop, graphMargin, height - graphTop);
    line(graphMargin, height - graphTop, graphMargin + graphW, height - graphTop );
    moveLeft = false;
    moveRight = false;

    textSize(36);
    textAlign(CENTER);
    text(message[subOption1 - 1] + " " + (currentSeason + 2004) + "/" + (currentSeason + 5), width / 2, graphTop / 2);
    textSize(12);

    //Draw the Y axis marks and put in the count scale
    textAlign(CENTER, CENTER);
    for (int i = 0; i <= SEASONS; i++) {
      line(graphMargin, height - graphTop - ((graphH * 0.1f) * i), graphMargin - 5.0f, height - graphTop - ((graphH * 0.1f) * i));
      if (subOption1 == 2) {
        text(nfc(graphY * i, 2), graphMargin * 0.5f, height - graphTop - ((graphH * 0.1f) * i));
      } else if (subOption1 == 1 || subOption1 == 3) {
        text(nf((int)(graphY * i)), graphMargin * 0.5f, height - graphTop - ((graphH * 0.1f) * i));
      }
    }//end for(i)

    rectMode(CORNER);

    String[] tempData = new String[NOOFLEAGUES];
    //draw the graph data
    for (int i = 0; i < goal.size(); i++) {
      if (subOption1 == 1) {
        tempMax[i] = nf(lastPoint[i]);
        tempData[i] = nf(goal.get(i).get(currentSeason));
      } else if (subOption1 == 2) {
        tempMax[i] = nfc(lastPoint[i], 2);
        tempData[i] = nfc(goalAverage.get(i).get(currentSeason), 2);
      } else if (subOption1 == 3) {
        tempMax[i] = nf(lastPoint[i]);
        tempData[i] = nf(cleansheet.get(i).get(currentSeason));
      }
      fill(0);
      float graphY;
      if (subOption1 == 1 || subOption1 == 3) {
        graphY = round(map(parseInt(tempMax[i]), 0, graphMax, 0, -graphH));
      } else {
        graphY = map(parseFloat(tempMax[i]), 0, graphMax, 0, -graphH);
      }
      textAlign(CENTER, BOTTOM);
      text(tempMax[i], graphMargin + (barW * 0.5f) + (barW * i), height - graphTop + graphY);
      textAlign(CENTER, TOP);
      text(leagueNames[i], graphMargin + (barW * 0.5f) + (barW * i), height - graphTop, 0);
      fill(colour[i]);
      rect(graphMargin + ((barW) * i), height - graphTop, barW, graphY);

      //Creates an animation effect on the graph
      if (lastPoint[i] < parseInt(tempData[i])) {
        if (lastPoint[i] > parseInt(tempData[i]) - change * 2) {
          if (subOption1 == 1 || subOption1 == 3) {
            lastPoint[i] = parseInt(tempData[i]);
          } else {
            lastPoint[i] = parseFloat(tempData[i]);
          }
          colour1 = arrowOnColour;
          colour2 = arrowOnColour;
        } 
        lastPoint[i] += change;
      }

      if (lastPoint[i] > parseInt(tempData[i])) {
        if (lastPoint[i] < parseInt(tempData[i]) + change * 2) {
          if (subOption1 == 1 || subOption1 == 3) {
            lastPoint[i] = parseInt(tempData[i]);
          } else {
            lastPoint[i] = parseFloat(tempData[i]);
          }
          colour1 = arrowOnColour;
          colour2 = arrowOnColour;
        } else {
          lastPoint[i] -= change;
        }
      }
    }//end for(i)


    //Add two toggle buttons to change seasons
    Arrow arrow1 = new Arrow(width * 0.25f, (float)height - 60.0f, width * 0.25f, (float)height - 20.0f, (width * 0.25f) - 40.0f, (float)height - 40.0f, colour1);
    Arrow arrow2 = new Arrow(width * 0.75f, (float)height - 60.0f, width * 0.75f, (float)height - 20.0f, (width * 0.75f) + 40.0f, (float)height - 40.0f, colour2);

    arrow1.renderArrow();
    arrow2.renderArrow();

    color testColor = get(mouseX, mouseY);
    if (testColor == colour1 /*&& mousePressed*/ && (mouseButton == LEFT) && currentX < width * 0.25f && currentY != 0 && !moveRight) {
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
      currentX = 0;
      currentY = 0;
    } else if (testColor == colour2 /*&& mousePressed*/ && (mouseButton == LEFT) && currentX > width * 0.75f && currentY != 0 && !moveLeft) {
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
        moveLeft = false;
      }
      currentX = 0;
      currentY = 0;
    }

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