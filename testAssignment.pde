import ddf.minim.*;

AudioSnippet theme;
AudioSnippet buttonPress;
Minim minim;


final int SEASONS = 10;  //This is a constant variable - there are 10 seasons
int index = 0;
//create ArrayLists to store obects in
ArrayList<ArrayList<Team>> premierLeague = new ArrayList<ArrayList<Team>>();
ArrayList<ArrayList<HomeTeam>> premHome = new ArrayList<ArrayList<HomeTeam>>();
ArrayList<ArrayList<AwayTeam>> premAway = new ArrayList<ArrayList<AwayTeam>>();
ArrayList<ArrayList<Team>> bundesliga = new ArrayList<ArrayList<Team>>();
ArrayList<ArrayList<HomeTeam>> bundesHome = new ArrayList<ArrayList<HomeTeam>>();
ArrayList<ArrayList<AwayTeam>> bundesAway = new ArrayList<ArrayList<AwayTeam>>();
ArrayList<ArrayList<Team>> liga = new ArrayList<ArrayList<Team>>();
ArrayList<ArrayList<HomeTeam>> ligaHome = new ArrayList<ArrayList<HomeTeam>>();
ArrayList<ArrayList<AwayTeam>> ligaAway = new ArrayList<ArrayList<AwayTeam>>();
ArrayList<ArrayList<Team>> seriea = new ArrayList<ArrayList<Team>>();
ArrayList<ArrayList<HomeTeam>> serieHome = new ArrayList<ArrayList<HomeTeam>>();
ArrayList<ArrayList<AwayTeam>> serieAway = new ArrayList<ArrayList<AwayTeam>>();
LeagueTable table;
Menu mainMenu;
Menu teamSelect;
Button returnButton;
boolean pressed;

//Global variable to store current menu option
int menu;
int subMenu;

int year;
color arrowOnColour;
color arrowOffColour;
color colour1;
color colour2;
float tempIndex;
boolean moveRight;
boolean moveLeft;
int currentX;
int currentY;

/*Setup method will prepare all the relevant data before anythiing has to be implemented
 */
void setup() {  
  //Setup the sketch
  size(600, 600);
  background(252, 252, 252);


  //call the loadData() method and pass the filenames and ArrayList objects
  loadData("premier_league.csv", premierLeague, premHome, premAway);
  loadData("bundesliga.csv", bundesliga, bundesHome, bundesAway);
  loadData("liga.csv", liga, ligaHome, ligaAway);
  loadData("seriea.csv", seriea, serieHome, serieAway);

  //sort the ArrayLists
  sortList(premierLeague);
  sortList(bundesliga);
  sortList(liga);
  sortList(seriea);

  String[] mainOptions = {"View League"};
  String[] leagueNames = {"Premier League", "Bundesliga", "La Liga", "Serie A"};
  mainMenu = new Menu(1, mainOptions, "Welcome To Football Fever\nPlease Select An Option");
  teamSelect = new Menu(4, leagueNames, "Please Select A league");

  //Set the menu option to 0 for main menu
  menu = 0;
  subMenu = 0;
  year = 0;

  returnButton = new Button();
  pressed = false;

  arrowOnColour = color(222, 194, 116);
  arrowOffColour = color(127, 127, 127);
  colour1 = arrowOnColour;
  colour2 = arrowOnColour;
  table = new LeagueTable((float)premierLeague.get(0).size(), year);
  tempIndex = 0;
  moveRight = false;
  moveLeft = false;


  minim = new Minim(this);
  //println(premierLeague.get(0).size());
}//end setup() method

void draw() {
  background(255);
  println("menu is " + menu + " subMenu is " + subMenu);
  //Switch case to select the menu options
  switch (menu) {
  case 0:
    mainMenu.renderMenu();
    break;
  case 1:
    if (pressed) {

      buttonPress = minim.loadSnippet("go.mp3");
      buttonPress.rewind();
      buttonPress.play();
      pressed = !pressed;
    }
    viewLeagueMenu();

    //checkButton();
    break;
  case 2:

    break;

  

  

  
  }
}

/*Method name: loadData
 Purpose: To load up the relevant .csv files and insert the data into ArrayList of objects
 Arguments: A String which holds the filename and a reference to the relevant ArrayList
 */
void loadData(String filename, ArrayList<ArrayList<Team>> teams, ArrayList<ArrayList<HomeTeam>> homeTeams, ArrayList<ArrayList<AwayTeam>> awayTeams) {
  //load the file into an array of Strings - each element is now one line from the file
  String[] leagueLines = loadStrings(filename);

  //find out how many games in a season - one league has 18 teams and the others have 20 so there are different amounts to each league
  int gamesPerSeason = leagueLines.length / SEASONS;


  //use loops to iterate through the array leagueLines
  for (int i = 0; i < SEASONS; i++) {
    //create a new outer dimension to teams - outer dimensions will reference each season
    teams.add(new ArrayList<Team>());
    homeTeams.add(new ArrayList<HomeTeam>());
    awayTeams.add(new ArrayList<AwayTeam>());

    //cycle through each file on a season by season basis to store team info
    for (int j = i * gamesPerSeason; j < gamesPerSeason + (gamesPerSeason * i); j++) {
      //split each element of leagueLines into a new array
      String[] leagueValues = leagueLines[j].split(",");

      //store each element of leagueValues in its own variable and give it a meaningful name
      String homeTeam = leagueValues[0];
      String awayTeam = leagueValues[1];
      //the last element of league values needs to be split to separate the scores into their own variables
      String[] scores = leagueValues[2].split("-");
      int homeScore = parseInt(scores[0]);
      int awayScore = parseInt(scores[1]);

      //create two int variables that will find the index number of each team in the current line - -1 is default and means the team doesn't exist yet
      int homeIndex = -1;
      int awayIndex = -1;
      //search for the teams index in the ArrayList, if it exists
      for (int k = 0; k < teams.get(i).size(); k++) {

        if (homeTeam.equals(teams.get(i).get(k).name)) {
          homeIndex = k;
        }//end if()

        if (awayTeam.equals(teams.get(i).get(k).name)) {
          awayIndex = k;
        }//end if()
      }//end inner inner for(k)

      //if homeIndex is -1 team doesn't exist yet - add a new object to the ArrayList and instanciate its fields
      if (homeIndex == -1) {
        teams.get(i).add(new Team(homeTeam, homeScore, awayScore));
      } else {//else team does exist - edit the objects fields
        teams.get(i).get(homeIndex).editTeam(homeScore, awayScore);
      }//end if/else

      //if awayIndex is -1 team doesn't exist yet - add a new object to the ArrayList and instanciate its fields
      if (awayIndex < 0) {
        teams.get(i).add(new Team(awayTeam, awayScore, homeScore));
      } else {//else team does exist - edit the objects fields
        teams.get(i).get(awayIndex).editTeam(awayScore, homeScore);
      }//end if/else


      //re-use int variables that will find the index number of each team in the current line - -1 is default and means the team doesn't exist yet
      homeIndex = -1;
      awayIndex = -1;
      //search for the home teams index in the ArrayList, if it exists
      for (int k = 0; k < homeTeams.get(i).size(); k++) {
        if (homeTeam.equals(homeTeams.get(i).get(k).getName())) {
          homeIndex = k;
        }//end if()
      }//end inner inner for(k)

      //if homeIndex is -1 team doesn't exist yet - add a new object to the ArrayList and instanciate its fields
      if (homeIndex == -1) {
        homeTeams.get(i).add(new HomeTeam(homeTeam, homeScore, awayScore));
      } else {//else team does exist - edit the objects fields
        homeTeams.get(i).get(homeIndex).editTeam(homeScore, awayScore);
      }//end if/else




      //search for the away teams index in the AwayTeam ArrayList, if it exists
      for (int k = 0; k < awayTeams.get(i).size(); k++) {
        if (awayTeam.equals(awayTeams.get(i).get(k).getName())) {
          awayIndex = k;
        }//end if()
      }//end inner inner for(k)

      //if awayIndex is -1 team doesn't exist yet - add a new object to the ArrayList and instanciate its fields
      if (awayIndex < 0) {
        awayTeams.get(i).add(new AwayTeam(awayTeam, awayScore, homeScore));
      } else {//else team does exist - edit the objects fields
        awayTeams.get(i).get(awayIndex).editTeam(awayScore, homeScore);
      }//end if/else
    }//end inner for(j)
  }//end outer for(i)
}//end loadData() method

void sortList(ArrayList<ArrayList<Team>> teams) {
  Team tempTeam;

  for (int i = 0; i < teams.size(); i++) {
    for (int j = 0; j < teams.get(i).size() - 1; j++) {
      for (int k = 0; k < teams.get(i).size() - j - 1; k++) {
        if (teams.get(i).get(k).getPoints() < teams.get(i).get(k + 1).getPoints()) {
          tempTeam = teams.get(i).get(k);
          teams.get(i).set(k, teams.get(i).get(k + 1));
          teams.get(i).set(k + 1, tempTeam);
        }
      }
    }
  }
}




int[] getColour(int index) {
  int[] colour = new int[3];
  if (index == 0) {
    colour[0] = 81;
    colour[1] = 81;
    colour[2] = 109;
    return colour;
  } else if (index > 0 && index < 4) {
    colour[0] = 96;
    colour[1] = 96;
    colour[2] = 124;
    return colour;
  } else if (index == 4) {
    colour[0] = 112;
    colour[1] = 111;
    colour[2] = 142;
    return colour;
  } else if (index > 16) {
    colour[0] = 81;
    colour[1] = 81;
    colour[2] = 109;
    return colour;
  } else {
    colour[0] = 5;
    colour[1] = 5;
    colour[2] = 40;
    return colour;
  }
}

void showLeagueTable(ArrayList<ArrayList<Team>> team, LeagueTable table) {


  Arrow arrow1 = new Arrow(45.0f, (float)230, 45.0f, (float)270, 5.0f, (float)250, colour1);
  Arrow arrow2 = new Arrow(width - 45.0f, 230.0f, width - 45.0f, (float)270, width - 5.0f, (float)250, colour2);
  //drawArrow(tableSide + tableW + padding, 230, tableSide + tableW + padding, 270, width - padding, 250, false);
  table.renderTable(team, year);

  arrow1.renderArrow();
  arrow2.renderArrow();

  color testColor = get(mouseX, mouseY);
  if (testColor == colour1 && mousePressed && (mouseButton == LEFT) && mouseX < table.getTableMargin() && !moveRight) {
    colour1 = arrowOffColour;
    if (year > 0) {
      //minim = new Minim(this);
      theme = minim.loadSnippet("go.mp3");
      theme.rewind();
      theme.play();
      tempIndex = width;
      moveRight = true;
    } else {
      //maybe play a soundfile

      colour1 = arrowOnColour;

      minim = new Minim(this);
      theme = minim.loadSnippet("whistle.mp3");
      theme.rewind();
      theme.play();
    }
  }

  if (testColor == colour2 && mousePressed && (mouseButton == LEFT) && mouseX > table.getTableMargin() + table.getPadding() && !moveLeft) {
    colour2 = arrowOffColour;
    if (year < team.size() - 1) {
      minim = new Minim(this);
      theme = minim.loadSnippet("go.mp3");
      theme.rewind();
      theme.play();
      tempIndex = -width;
      moveLeft = true;
    } else {
      //maybe play a soundfile
      colour2 = arrowOnColour;

      //minim = new Minim(this);
      theme = minim.loadSnippet("whistle.mp3");
      theme.rewind();
      theme.play();
    }
  }

  if (moveLeft) {
    if (tempIndex < 0) {
      table.moveLeft();
      tempIndex += 10.0f;
      if (tempIndex == -20.0f && year < team.size() - 1) {
        year += 1;
        table.setYear(year + 2004);
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










  if (moveRight) {
    if (tempIndex > 0) {
      table.moveRight();
      tempIndex -= 10.0f;
      if (tempIndex == 20.0f && year > 0) {
        year -= 1;
        table.setYear(year + 2004);
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

void viewLeagueMenu() {
  switch(subMenu) {
  case 0:
    teamSelect.renderMenu();
    break;

  case 1:
    if (pressed) {
      //minim = new Minim(this);
      buttonPress = minim.loadSnippet("go.mp3");
      buttonPress.rewind();
      buttonPress.play();
      pressed = !pressed;
    }
    background(192, 231, 249);
    showLeagueTable(premierLeague, table);
    break;
    
    case 2:
    if (pressed) {
      buttonPress = minim.loadSnippet("go.mp3");
      buttonPress.rewind();
      buttonPress.play();
      pressed = !pressed;
    }
    background(192, 231, 249);
    showLeagueTable(bundesliga, table);
    break;
    
    case 3:
    if (pressed) {
      buttonPress = minim.loadSnippet("go.mp3");
      buttonPress.rewind();
      buttonPress.play();
      pressed = !pressed;
    }
    background(192, 231, 249);
    showLeagueTable(liga, table);
    break;
    
    case 4:
    if (pressed) {
      buttonPress = minim.loadSnippet("go.mp3");
      buttonPress.rewind();
      buttonPress.play();
      pressed = !pressed;
    }
    background(192, 231, 249);
    showLeagueTable(seriea, table);
    break;
  }
}

void mouseClicked(){
  currentX = mouseX;
  currentY = mouseY;
}

void checkButton() {
  
}