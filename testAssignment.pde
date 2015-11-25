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

//Global variable to store current menu option
int menu;
int year;

/*Setup method will prepare all the relevant data before anythiing has to be implemented
 */
void setup() {  
  //Setup the sketch
  size(500, 500);
  background(252, 252, 252);

  //call the loadData() method and pass the filenames and ArrayList objects
  loadData("premier_league.csv", premierLeague, premHome, premAway);
  loadData("bundesliga.csv", bundesliga, bundesHome, bundesAway);
  loadData("liga.csv", liga, ligaHome, ligaAway);
  loadData("seriea.csv", seriea, serieHome, serieAway);





  //Set the menu option to 0 for main menu
  menu = 1;
  year = 1;




  //println(premierLeague.get(0).size());
}//end setup() method

void draw() {
  background(255);
  //Switch case to select the menu options
  switch (menu) {
  case 0:
    mainMenu();
    break;
  case 1:
    showTable(premierLeague, year);
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
        if (homeTeam.equals(homeTeams.get(i).get(k).name)) {
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
        if (awayTeam.equals(awayTeams.get(i).get(k).name)) {
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

void mainMenu() {
  background(252, 252, 252);
  //Declare/initialise variables
  float buttonEdge = width * 0.2f;
  float buttonY = height * 0.2f;
  float bannerEdge = width * 0.1f;
  ;
  float bannerY = height * 0.1f;

  fill(198, 214, 234);
  stroke(198, 214, 234);
  rect(bannerEdge, bannerY, width - (bannerEdge * 2), bannerY);
}

void showTable(ArrayList<ArrayList<Team>> teams, int year) {
  //Declare/initialise variables
  float tableSide = width * 0.1f;
  float tableTop = height * 0.1f;
  float tableW = width - (tableSide * 2);
  float tableH = width - (tableTop * 2);
  float colScaleA = 0.0714285f;
  float colScaleB = 0.3571428f;
  float col1X = tableSide + (tableW * colScaleA);
  float col2X = col1X + (tableW * colScaleB);
  float col3X = col2X + (tableW * colScaleA);
  float col4X = col3X + (tableW * colScaleA);
  float col5X = col4X + (tableW * colScaleA);
  float col6X = col5X + (tableW * colScaleA);
  float col7X = col6X + (tableW * colScaleA);
  float col8X = col7X + (tableW * colScaleA);
  float col9X = col8X + (tableW * colScaleA);
  float rowHeight = tableH / (float)teams.get(0).size();
  float padding = rowHeight * 0.2f;

  //Draw the table background
  fill(0);
  stroke(255);
  text("Pos", tableSide + padding, tableTop - padding);
  text("Name", col1X + padding, tableTop - padding);
  text("Pld", col2X + padding, tableTop - padding);
  text("W", col3X + padding, tableTop - padding);
  text("D", col4X + padding, tableTop - padding);
  text("L", col5X + padding, tableTop - padding);
  text("G+", col6X + padding, tableTop - padding);
  text("G-", col7X + padding, tableTop - padding);
  text("GD", col8X + padding, tableTop - padding);
  text("Pts", col9X + padding, tableTop - padding);
  for (int i = 0; i < teams.get(year).size(); i++) {
    float textY = tableTop + rowHeight + (rowHeight * i) - padding;
    float posX = tableSide + padding;
    float nameX = col1X + padding;
    float pldX = col2X + padding;
    float wX = col3X + padding;
    float dX = col4X + padding;
    float lX = col5X + padding;
    float gPX = col6X + padding;
    float gMX = col7X + padding;
    float gDX = col8X + padding;
    float ptsX = col9X + padding;
    //float rowBottom = tableTop + rowHeight + (rowHeight * i);

    //Draw row bottom border
    int[] colour = getColour(i);
    fill(colour[0], colour[1], colour[2]);
    rect(tableSide, tableTop + (rowHeight * i), tableW, rowHeight);
    fill(255);
    text(i + 1, posX, textY);
    text(teams.get(0).get(i).name, nameX, textY);
    text(teams.get(0).get(i).played, pldX, textY);
    text(teams.get(0).get(i).wins, wX, textY);
    text(teams.get(0).get(i).draws, dX, textY);
    text(teams.get(0).get(i).loses, lX, textY);
    text(teams.get(0).get(i).goalsFor, gPX, textY);
    text(teams.get(0).get(i).goalsAgainst, gMX, textY);
    text(teams.get(0).get(i).goalDifference, gDX, textY);
    text(teams.get(0).get(i).points, ptsX, textY);
  }

  line(col1X, tableTop, col1X, tableH + tableTop);
  line(col2X, tableTop, col2X, tableH + tableTop);
  line(col3X, tableTop, col3X, tableH + tableTop);
  line(col4X, tableTop, col4X, tableH + tableTop);
  line(col5X, tableTop, col5X, tableH + tableTop);
  line(col6X, tableTop, col6X, tableH + tableTop);
  line(col7X, tableTop, col7X, tableH + tableTop);
  line(col8X, tableTop, col8X, tableH + tableTop);
  line(col9X, tableTop, col9X, tableH + tableTop);
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
  } else if (index > 17) {
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