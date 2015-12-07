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
    int tempMostCleansheet = 0;//Go from here!!!!!!!!!!!!!!!!!!!!!!!!!!!
    for (int i = 0; i < goal.size(); i++) {
      for (int j = 0; j < goal.get(i).size(); j++) {
        if (goal.get(i).get(j) > tempMostGoalMax) {
          tempMostGoalMax = goal.get(i).get(j);
        }//end if
        if (goalAverage.get(i).get(j) > tempGoalAverage) {
          tempGoalAverage = goalAverage.get(i).get(j);
          println("New highest is at " + i + ", " + j + " " + tempGoalAverage);
        }
        if (cleansheet.get(i).get(j) > tempMostCleansheet) {
          tempMostCleansheet = cleansheet.get(i).get(j);
        }
      }//end for(j)
    }//end for(i)
    //println(tempGoalAverage);
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
    //println(graphMax);
    graphY = graphMax / 10;
    barW = graphW / NOOFLEAGUES;
    color[] colour = {color(255), color(210, 6, 11), color(54, 152, 42), color(0, 70, 143)};
    this.colour = colour;
    //change = 10.0f;
    this.message = message;
    tempMax = new String[NOOFLEAGUES];
  }//end Graph constructor method

  void renderGraph(/*int currentSeason*/) {
    background(255);
    stroke(0);
    fill(0);
    line(graphMargin, graphTop, graphMargin, height - graphTop);
    line(graphMargin, height - graphTop, graphMargin + graphW, height - graphTop );
    moveLeft = false;
    moveRight = false;

    textSize(36);
    textAlign(CENTER);
    text(/*leagueNames[league] + " " + leagueType[type] + " " + this.year + "/" + (this.year - 1999),*/message[subOption1 - 1] + " " + (currentSeason + 2004) + "/" + (currentSeason + 5), width / 2, graphTop / 2);
    //textAlign(CORNER);
    textSize(12);

    //Draw the Y axis marks and put in the count scale
    textAlign(CENTER, CENTER);
    for (int i = 0; i <= SEASONS; i++) {
      line(graphMargin, height - graphTop - ((graphH * 0.1f) * i), graphMargin - 5.0f, height - graphTop - ((graphH * 0.1f) * i));
      if (subOption1 == 2) {
        text(nfc(graphY * i, 2), graphMargin * 0.5f, height - graphTop - ((graphH * 0.1f) * i));
      } else if(subOption1 == 1 || subOption1 == 3) {
        text(nf((int)(graphY * i)), graphMargin * 0.5f, height - graphTop - ((graphH * 0.1f) * i));
      }
    }//end for(i)

    rectMode(CORNER);

    String[] tempData = new String[NOOFLEAGUES];
    /*if (subOption1 == 1) {
     for (int i = 0; i < NOOFLEAGUES; i++) {
     //tempMax[i] = nf(lastPoint[i]);
     //tempData[i] = nf(goal.get(i).get(currentSeason));
     }//end for(i)
     } else if (subOption1 == 2) {
     for (int i = 0; i < NOOFLEAGUES; i++) {
     tempData[i] = nfc(goalAverage.get(i).get(currentSeason), 2);
     }
     }*/
    //draw the graph data

    for (int i = 0; i < goal.size(); i++) {
      if (subOption1 == 1) {
        tempMax[i] = nf(lastPoint[i]);
        tempData[i] = nf(goal.get(i).get(currentSeason));
      } else if (subOption1 == 2) {
        tempMax[i] = nfc(lastPoint[i], 2);
        //println(goalAverage.get(i).get(currentSeason));
        tempData[i] = nfc(goalAverage.get(i).get(currentSeason), 2);
        //println(tempData[i]);
      } else if (subOption1 == 3) {
        tempMax[i] = nf(lastPoint[i]);
        tempData[i] = nf(cleansheet.get(i).get(currentSeason));
      }
      //int tempPoint = (int)lastPoint[i];
      fill(0);
      float graphY;
      if (subOption1 == 1 || subOption1 == 3) {
        graphY = round(map(parseInt(tempMax[i]), 0, graphMax, 0, -graphH));
      }else{
        graphY = map(parseFloat(tempMax[i]), 0, graphMax, 0, -graphH);
      }
      //text(goal.get(i).get(currentSeason), graphMargin + (barW * 0.5f) + (barW * 2 * i), height - graphY);
      textAlign(CENTER, BOTTOM);
      text(tempMax[i], graphMargin + (barW * 0.5f) + (barW * i), height - graphTop + graphY);
      textAlign(CENTER, TOP);
      text(leagueNames[i], graphMargin + (barW * 0.5f) + (barW * i), height - graphTop, 0);
      fill(colour[i]);
      rect(graphMargin + ((barW) * i), height - graphTop, barW, graphY);
      //println("graph for i = " + i + " is " + (-graphY));

      //Creates an animation effect on the graph
      if (lastPoint[i] < parseInt(tempData[i])) {//goal.get(i).get(currentSeason)) {
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
    //}//end if()

    /*else if (subOption1 == 2) {
     //draw the graph data
     
     for (int i = 0; i < goalAverage.size(); i++) {
     float tempPoint = lastPoint[i];
     fill(0);
     float graphY = map(tempPoint, 0, graphMax, 0, -graphH);
     //text(goalAverage.get(i).get(currentSeason), graphMargin + (barW * 0.5f) + (barW * 2 * i), height - graphY);
     textAlign(CENTER, BOTTOM);
     text(tempPoint, graphMargin + (barW * 0.5f) + (barW * i), height - graphTop + graphY);
     textAlign(CENTER, TOP);
     text(leagueNames[i], graphMargin + (barW * 0.5f) + (barW * i), height - graphTop, 0);
     fill(colour[i]);
     rect(graphMargin + ((barW) * i), height - graphTop, barW, graphY);
     
     //Creates an animation effect on the graph
     if (lastPoint[i] < goalAverage.get(i).get(currentSeason)) {
     if (lastPoint[i] > goalAverage.get(i).get(currentSeason) - change) {
     lastPoint[i] = goalAverage.get(i).get(currentSeason);
     colour1 = arrowOnColour;
     colour2 = arrowOnColour;
     } 
     lastPoint[i] += change;
     }
     
     if (lastPoint[i] > goalAverage.get(i).get(currentSeason)) {
     if (lastPoint[i] < goalAverage.get(i).get(currentSeason) + change) {
     lastPoint[i] = goalAverage.get(i).get(currentSeason);
     colour1 = arrowOnColour;
     colour2 = arrowOnColour;
     } else {
     lastPoint[i] -= change;
     }
     }
     }//end for(i)
     }//end if()*/

    //Add two toggle buttons to change seasons
    Arrow arrow1 = new Arrow(width * 0.25f, (float)height - 60.0f, width * 0.25f, (float)height - 20.0f, (width * 0.25f) - 40.0f, (float)height - 40.0f, colour1);
    Arrow arrow2 = new Arrow(width * 0.75f, (float)height - 60.0f, width * 0.75f, (float)height - 20.0f, (width * 0.75f) + 40.0f, (float)height - 40.0f, colour2);

    arrow1.renderArrow();
    arrow2.renderArrow();

    color testColor = get(mouseX, mouseY);
    if (testColor == colour1 /*&& mousePressed*/ && (mouseButton == LEFT) && currentX < width * 0.25f && currentY != 0 && !moveRight) {
      println("Left arrow test");
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
      println("Right arrow test");
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

    //println("testColour is " + testColor + ", colour1 is " + colour1 + ", mousePressed is " + mousePressed + ", mouseButton is " + mouseButton + ", currentX is " + currentX + ", moveLeft is " + moveLeft);

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