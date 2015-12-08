import ddf.minim.*;

AudioSnippet theme;
AudioSnippet go;
AudioSnippet stop;
Minim minim;



final int SEASONS = 10;  //This is a constant variable - there are 10 seasons
final int NOOFLEAGUES = 4;  //This is a constant variable - there are 4 leagues

ArrayList<ArrayList<ArrayList<Team>>> leagueFull = new ArrayList<ArrayList<ArrayList<Team>>>();//Stores the full league data for all leagues
ArrayList<ArrayList<ArrayList<HomeTeam>>> leagueHome = new ArrayList<ArrayList<ArrayList<HomeTeam>>>();//Stores the home league data for all leagues
ArrayList<ArrayList<ArrayList<AwayTeam>>> leagueAway = new ArrayList<ArrayList<ArrayList<AwayTeam>>>();//Stores the away league data for all leagues

ArrayList<ArrayList<Integer>> goal = new ArrayList<ArrayList<Integer>>();
ArrayList<ArrayList<Float>> goalAverage = new ArrayList<ArrayList<Float>>();
ArrayList<ArrayList<Integer>> cleansheet = new ArrayList<ArrayList<Integer>>();

float[] lastPoint;
color grey;

//These are menu options - they will all be initialised to zero and utilised in switch cases
int mainOption;
int subOption1;
int subOption2;

int currentSeason;
boolean pressed;

color arrowOnColour;
color arrowOffColour;
color colour1;
color colour2;
boolean moveRight;
boolean moveLeft;
float tempIndex;

int league;
int type;


LeagueTable table;


int currentX;
int currentY;

void setup() {
  //Setup the sketch
  size(600, 600);
  background(250);

  //Load the files and populate the 3 ArrayLists
  String[] filename = {"premier_league.csv", "bundesliga.csv", "liga.csv", "seriea.csv"};
  //Call the cleansheets method from in here
  loadData(filename);

  lastPoint = new float[NOOFLEAGUES];

  //Sort the ArrayLists on points scored
  sortData();

  //Find the total goals scored each season for each league
  totalGoals();
  //Find the average goals scored per game
  averageGoals();

  mainOption = 0;
  subOption1 = 0;
  subOption2 = 0;

  pressed = false;

  currentSeason = 0;
  arrowOnColour = color(222, 194, 116);
  arrowOffColour = color(127, 127, 127);
  colour1 = arrowOnColour;
  colour2 = arrowOnColour;

  String[] leagueNames = {"Premier League", "Bundesliga", "La Liga", "Serie A"};
  String[] leagueType = {"Full", "Home", "Away"};
  table = new LeagueTable(/*league, type,*/ 0, leagueNames, leagueType);
  grey = color(127, 127, 127);
  
  //Load the soundeffects and other audio files to be used
  minim = new Minim(this);
  go = minim.loadSnippet("go.mp3");
  stop = minim.loadSnippet("whistle.mp3");
}

void draw() {
  background(255);
  switch (mainOption) {
  case 0:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()

    //Create the main menu object
    String[] mainLabels = {"League Tables", "View Stats"};
    Menu mainMenu = new Menu(2, mainLabels, "Welcome To Football Fever.\nSelect An Option");
    mainMenu.renderMenu();
    break;

  case 1:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()

    viewLeagueMenu();    
    break;

  case 2:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()

    viewStatMenu();
    break;
  }
}

void loadData(String[] filename) {
  for (int i = 0; i < filename.length; i++) {
    //Add new outer dimension to ArrayLists - will reference each of the 4 leagues
    leagueFull.add(new ArrayList<ArrayList<Team>>());
    leagueHome.add(new ArrayList<ArrayList<HomeTeam>>());
    leagueAway.add(new ArrayList<ArrayList<AwayTeam>>());
    cleansheet.add(new ArrayList<Integer>());

    String[] leagueLines = loadStrings(filename[i]);

    //find out how many games in a season - one league has 18 teams and the others have 20 so there are different amounts to each league
    int gamesPerSeason = leagueLines.length / SEASONS;

    //use loops to iterate through the array leagueLines
    for (int j = 0; j < SEASONS; j++) {
      //create a new dimension to teams -  will reference each season
      leagueFull.get(i).add(new ArrayList<Team>());
      leagueHome.get(i).add(new ArrayList<HomeTeam>());
      leagueAway.get(i).add(new ArrayList<AwayTeam>());
      int seasonCleansheet = 0;
      cleansheet.get(i).add(seasonCleansheet);


      //cycle through each file on a season by season basis to store team info
      for (int k = j * gamesPerSeason; k < gamesPerSeason + (gamesPerSeason * j); k++) {
        //split each element of leagueLines into a new array
        String[] leagueValues = leagueLines[k].split(",");

        //store each element of leagueValues in its own variable and give it a meaningful name
        String homeTeam = leagueValues[0];
        String awayTeam = leagueValues[1];
        //the last element of league values needs to be split to separate the scores into their own variables
        String[] scores = leagueValues[2].split("-");
        int homeScore = parseInt(scores[0]);
        int awayScore = parseInt(scores[1]);

        //Call the cleansheet method here
        if (homeScore == 0) {
          cleansheets(i, j);
        }
        if (awayScore == 0) {
          cleansheets(i, j);
        }

        //create two int variables that will find the index number of each team in the current line - -1 is default and means the team doesn't exist yet
        int homeIndex = -1;
        int awayIndex = -1;
        //search for the teams index in the ArrayList, if it exists
        for (int l = 0; l < leagueFull.get(i).get(j).size(); l++) {
          if (homeTeam.equals(leagueFull.get(i).get(j).get(l).getTeamName())) {
            homeIndex = l;
          }//end if()

          if (awayTeam.equals(leagueFull.get(i).get(j).get(l).getTeamName())) {
            awayIndex = l;
          }//end if()
        }//enf for(l)

        //if homeIndex is -1 team doesn't exist yet - add a new object to the ArrayList and instanciate its fields
        if (homeIndex == -1) {
          leagueFull.get(i).get(j).add(new Team(homeTeam, homeScore, awayScore));
        } else {//else team does exist - edit the objects fields
          // println("homeIndex is " + homeIndex + " i is " + i + " j is " + j + " k is " + k);
          leagueFull.get(i).get(j).get(homeIndex).editTeam(homeScore, awayScore);
        }//end if/else

        //if awayIndex is -1 team doesn't exist yet - add a new object to the ArrayList and instanciate its fields
        if (awayIndex < 0) {
          leagueFull.get(i).get(j).add(new Team(awayTeam, awayScore, homeScore));
        } else {//else team does exist - edit the objects fields
          leagueFull.get(i).get(j).get(awayIndex).editTeam(awayScore, homeScore);
        }//end if/else

        //re-use int variables that will find the index number of each team in the current line - -1 is default and means the team doesn't exist yet
        homeIndex = -1;
        awayIndex = -1;
        //search for the home teams index in the ArrayList, if it exists
        for (int l = 0; l < leagueHome.get(i).get(j).size(); l++) {
          if (homeTeam.equals(leagueHome.get(i).get(j).get(l).getTeamName())) {
            homeIndex = l;
          }//end if()
        }//end inner inner for(l)

        //if homeIndex is -1 team doesn't exist yet - add a new object to the ArrayList and instanciate its fields
        if (homeIndex == -1) {
          leagueHome.get(i).get(j).add(new HomeTeam(homeTeam, homeScore, awayScore));
        } else {//else team does exist - edit the objects fields
          leagueHome.get(i).get(j).get(homeIndex).editTeam(homeScore, awayScore);
        }//end if/else

        //search for the away teams index in the AwayTeam ArrayList, if it exists
        for (int l = 0; l < leagueAway.get(i).get(j).size(); l++) {
          if (awayTeam.equals(leagueAway.get(i).get(j).get(l).getTeamName())) {
            awayIndex = l;
          }//end if()
        }//end inner inner for(l)

        //if awayIndex is -1 team doesn't exist yet - add a new object to the ArrayList and instanciate its fields
        if (awayIndex < 0) {
          leagueAway.get(i).get(j).add(new AwayTeam(awayTeam, awayScore, homeScore));
        } else {//else team does exist - edit the objects fields
          leagueAway.get(i).get(j).get(awayIndex).editTeam(awayScore, homeScore);
        }//end if/else
      }//end for(k)
    }//end for(j)
  }//end for(i)
}//end loadData method

void sortData() {
  //Create temporary objects to use in a bubble sort
  Team leagueFullTemp;
  HomeTeam leagueHomeTemp;
  AwayTeam leagueAwayTemp;

  for (int i = 0; i < leagueFull.size(); i++) {
    for (int j = 0; j < leagueFull.get(i).size(); j++) {
      for (int k = 0; k < leagueFull.get(i).get(j).size() - 1; k++) {
        for (int l = 0; l < leagueFull.get(i).get(j).size() - k - 1; l++) {
          if (leagueFull.get(i).get(j).get(l).getPoints() < leagueFull.get(i).get(j).get(l + 1).getPoints()) {
            leagueFullTemp = leagueFull.get(i).get(j).get(l);
            leagueFull.get(i).get(j).set(l, leagueFull.get(i).get(j).get(l + 1));
            leagueFull.get(i).get(j).set(l + 1, leagueFullTemp);
          }//end if()

          if (leagueHome.get(i).get(j).get(l).getPoints() < leagueHome.get(i).get(j).get(l + 1).getPoints()) {
            leagueHomeTemp = leagueHome.get(i).get(j).get(l);
            leagueHome.get(i).get(j).set(l, leagueHome.get(i).get(j).get(l + 1));
            leagueHome.get(i).get(j).set(l + 1, leagueHomeTemp);
          }//end if()

          if (leagueAway.get(i).get(j).get(l).getPoints() < leagueAway.get(i).get(j).get(l + 1).getPoints()) {
            leagueAwayTemp = leagueAway.get(i).get(j).get(l);
            leagueAway.get(i).get(j).set(l, leagueAway.get(i).get(j).get(l + 1));
            leagueAway.get(i).get(j).set(l + 1, leagueAwayTemp);
          }//end if()
        }//end for(l)
      }//end for(k)
    }//end for(j)
  }//end for(i)
}//end sortData()

/*Method name: getColour
 Purpose: Allows the league table to select colours for the different positions
 Arguments: An int variable representing the location in the respective season
 */
color getColour(int index) {
  color colour;
  if (index == 0) {
    colour = color(181, 231, 206);
    return colour;
  } else if (index > 0 && index < 4) {
    colour = color(129, 214, 172);
    return colour;
  } else if (index == 4) {
    colour = color(81, 81, 109);
    return colour;
  } else if (index > leagueFull.get(league).get(0).size() - 4) {
    colour = color(255, 90, 112);
    return colour;
  } else {
    colour = color(222, 222, 255);
    return colour;
  }
}//end getColour()

void viewLeagueMenu() {
  switch(subOption1) {
  case 0:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    String[] leagueLabels = {"Premier League", "Bundesliga", "La Liga", "Serie A"};
    Menu leagueMenu = new Menu(4, leagueLabels, "Select A League");
    leagueMenu.renderMenu();
    break;

  case 1:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    league = 0;
    viewTypeMenu();

    break;

  case 2:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    league = 1;
    viewTypeMenu();

    break;

  case 3:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    league = 2;
    viewTypeMenu();

    break;

  case 4:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    league = 3;
    viewTypeMenu();

    break;
  }
}

void viewTypeMenu() {
  switch (subOption2) {
  case 0:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    currentSeason = 0;
    String[] typeLabels = {"Full", "Home", "Away"};
    Menu typeMenu = new Menu(3, typeLabels, "Whay Type Of League?");
    typeMenu.renderMenu();
    break;

  case 1:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    type = 0;
    viewLeagueTable();
    break;

  case 2:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    type = 1;
    viewLeagueTable();
    break;

  case 3:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    type = 2;
    viewLeagueTable();
    break;
  }
}

void viewLeagueTable() {
  table.setLeague(league);
  table.setType(type);
  table.renderTable();
  table.setYear(currentSeason + 2004);
  
  //Create the arrow button objects
  Arrow arrow1 = new Arrow(45.0f, (float)230, 45.0f, (float)270, 5.0f, (float)250, colour1);
  Arrow arrow2 = new Arrow(width - 45.0f, 230.0f, width - 45.0f, (float)270, width - 5.0f, (float)250, colour2);

  arrow1.renderArrow();
  arrow2.renderArrow();

  color testColor = get(mouseX, mouseY);
  if (testColor == colour1 && mousePressed && (mouseButton == LEFT) && mouseX < table.getTableMargin() && !moveRight) {
    colour1 = arrowOffColour;
    if (currentSeason > 0) {      
      go.rewind();
      go.play();
      tempIndex = width;
      moveRight = true;
    } else {
      //maybe play a soundfile

      colour1 = arrowOnColour;
      stop.rewind();
      stop.play();
    }
  }

  if (testColor == colour2 && mousePressed && (mouseButton == LEFT) && mouseX > table.getTableMargin() + table.getPadding() && !moveLeft) {
    colour2 = arrowOffColour;
    if (currentSeason < leagueFull.get(league).size() - 1) {
      go.rewind();
      go.play();
      tempIndex = -width;
      moveLeft = true;
    } else {
      //maybe play a soundfile
      colour2 = arrowOnColour;

      stop.rewind();
      stop.play();
    }
  }

  if (moveLeft) {
    if (tempIndex < 0) {
      table.moveLeft();
      tempIndex += 10.0f;
      if (tempIndex == -20.0f && currentSeason < leagueFull.get(league).size() - 1) {
        currentSeason += 1;
        tempIndex = width;
      }
    } else if (tempIndex == width) {
      //reset the LeagueTable fields to be on the opposite side of the screen
      float tempMargin = width + (width * 0.1f) - 5.0f;
      float tempColumn1 = tempMargin + (table.getTableW() * table.getColScaleA());
      float tempColumn2 = tempColumn1 + (table.getTableW() * table.getColScaleB());
      float tempColumn3 = tempColumn2 + (table.getTableW() * table.getColScaleA());
      float tempColumn4 = tempColumn3 + (table.getTableW() * table.getColScaleA());
      float tempColumn5 = tempColumn4 + (table.getTableW() * table.getColScaleA());
      float tempColumn6 = tempColumn5 + (table.getTableW() * table.getColScaleA());
      float tempColumn7 = tempColumn6 + (table.getTableW() * table.getColScaleA());
      float tempColumn8 = tempColumn7 + (table.getTableW() * table.getColScaleA());
      float tempColumn9 = tempColumn8 + (table.getTableW() * table.getColScaleA());
      table.setTableMargin(tempMargin);
      table.setColumns(tempColumn1, tempColumn2, tempColumn3, tempColumn4, tempColumn5, tempColumn6, tempColumn7, tempColumn8, tempColumn9);
      table.moveLeft();
      table.moveLeft();
      tempIndex -= 20.0f;
    } else if (tempIndex > 0) {
      table.moveLeft();
      tempIndex -= 20.0f;
    } else {
      moveLeft = !moveLeft;
      colour2 = arrowOnColour;
    }
  }

  //If previous season
  if (moveRight) {
    if (tempIndex > 0) {
      table.moveRight();
      tempIndex -= 10.0f;
      if (tempIndex == 20.0f && currentSeason > 0) {
        currentSeason -= 1;
        tempIndex = -width;
      }
    } else if (tempIndex == -width) {
      //reset the LeagueTable fields to be on the opposite side of the screen
      float tempMargin = -width + (width * 0.1f) + 5.0f;
      float tempColumn1 = tempMargin + (table.getTableW() * table.getColScaleA());
      float tempColumn2 = tempColumn1 + (table.getTableW() * table.getColScaleB());
      float tempColumn3 = tempColumn2 + (table.getTableW() * table.getColScaleA());
      float tempColumn4 = tempColumn3 + (table.getTableW() * table.getColScaleA());
      float tempColumn5 = tempColumn4 + (table.getTableW() * table.getColScaleA());
      float tempColumn6 = tempColumn5 + (table.getTableW() * table.getColScaleA());
      float tempColumn7 = tempColumn6 + (table.getTableW() * table.getColScaleA());
      float tempColumn8 = tempColumn7 + (table.getTableW() * table.getColScaleA());
      float tempColumn9 = tempColumn8 + (table.getTableW() * table.getColScaleA());
      table.setTableMargin(tempMargin);
      table.setColumns(tempColumn1, tempColumn2, tempColumn3, tempColumn4, tempColumn5, tempColumn6, tempColumn7, tempColumn8, tempColumn9);
      table.moveRight();
      table.moveRight();
      tempIndex += 20.0f;
    } else if (tempIndex < 0) {
      table.moveRight();
      tempIndex += 20.0f;
    } else {
      moveRight = !moveRight;
      colour1 = arrowOnColour;
    }
  }
}
void mouseClicked() {
  currentX = mouseX;
  currentY = mouseY;
}

void totalGoals() {  
  for (int i = 0; i < leagueFull.size(); i++) {
    goal.add(new ArrayList<Integer>());
    for (int j = 0; j < leagueFull.get(i).size(); j++) {
      int tempGoal = 0;
      for (int k = 0; k < leagueFull.get(i).get(j).size(); k++) {
        tempGoal += leagueFull.get(i).get(j).get(k).getGoalsFor();
      }//end for(k)
      goal.get(i).add(tempGoal);
    }//end for(j)
  }//end for(i)
}

void averageGoals() {  
  for (int i = 0; i < leagueFull.size(); i++) {
    goalAverage.add(new ArrayList<Float>());
    for (int j = 0; j < leagueFull.get(i).size(); j++) {
      int tempGoal = 0;
      for (int k = 0; k < leagueFull.get(i).get(j).size(); k++) {
        tempGoal += leagueFull.get(i).get(j).get(k).getGoalsFor();
      }//end for(k)
      float averageGoal = tempGoal / (float)leagueFull.get(i).get(j).size();
      goalAverage.get(i).add(averageGoal);
    }//end for(j)
  }//end for(i)
}

void cleansheets(int league, int season) {
  cleansheet.get(league).set(season, cleansheet.get(league).get(season) + 1);
}//end cleansheet method

void viewStatMenu() {
  String[] leagueNames = {"Premier League", "Bundesliga", "La Liga", "Serie A"};
  String[] message = {"Most Goals Scored", "Average Goals Scored", "Most Cleansheets Kept"};
  Graph compareGraph;
  
  
  switch (subOption1) {
  case 0:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    
    for (int i = 0; i < NOOFLEAGUES; i++) {
      lastPoint[i] = 0.0f;
    }

    currentSeason = 0;
    //Create the main menu object
    String[] mainLabels = {"Most Goals", "Average Goals", "Cleansheets"};
    Menu statMenu = new Menu(3, mainLabels, "Select A Stat To View");
    statMenu.renderMenu();
    break;

  case 1:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    
    compareGraph = new Graph(leagueNames, message);
    compareGraph.renderGraph();
    break;

  case 2:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    
    compareGraph = new Graph(leagueNames, message);
    compareGraph.renderGraph();
    break;

  case 3:
    if (pressed) {
      go.rewind();
      go.play();
      pressed = !pressed;
    }//end if()
    
    compareGraph = new Graph(leagueNames, message);
    compareGraph.renderGraph();
    break;
  }
}