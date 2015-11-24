final int SEASONS = 10;  //This is a constant variable - there are 10 teams

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

/*Setup method will prepare all the relevant data before anythiing has to be implemented
 */
void setup() {
  //call the loadData() method and pass the filenames and ArrayList objects
  loadData("premier_league.csv", premierLeague, premHome, premAway);
  loadData("bundesliga.csv", bundesliga, bundesHome, bundesAway);
  loadData("liga.csv", liga, ligaHome, ligaAway);
  loadData("seriea.csv", seriea, serieHome, serieAway);

  //Print out the data as a test to show it working - show each season separated by two blank lines - won't be in the final version.
  for (int i = 0; i < SEASONS; i++) {
    println("Home and away Teams");
    for (int j = 0; j < premierLeague.get(i).size(); j++) {
      println(premierLeague.get(i).get(j).name + " - " + premierLeague.get(i).get(j).points + " pts - " + premierLeague.get(i).get(j).goalsFor + " goals - " + premierLeague.get(i).get(j).wins + " wins - " + premierLeague.get(i).get(j).loses + " loses - " + premierLeague.get(i).get(j).draws + " draws");
     }//end inner for(j)
    println();
    println();
    println("Home Teams Only");
    for (int j = 0; j < premHome.get(i).size(); j++) {
      println(premHome.get(i).get(j).name + " - " + premHome.get(i).get(j).points + " pts - " + premHome.get(i).get(j).goalsFor + " goals - " + premHome.get(i).get(j).wins + " wins - " + premHome.get(i).get(j).loses + " loses - " + premHome.get(i).get(j).draws + " draws");
    }//end inner for(j)
    println();
    println();
    println("Away Teams Only");
    for (int j = 0; j < premHome.get(i).size(); j++) {
      println(premAway.get(i).get(j).name + " - " + premAway.get(i).get(j).points + " pts - " + premAway.get(i).get(j).goalsFor + " goals - " + premAway.get(i).get(j).wins + " wins - " + premAway.get(i).get(j).loses + " loses - " + premAway.get(i).get(j).draws + " draws");
    }//end inner for(j)
    //for (int j = 0; j < bundesliga.get(i).size(); j++) {
    // println(bundesliga.get(i).get(j).name + " - " + bundesliga.get(i).get(j).points + " pts - " + bundesliga.get(i).get(j).goalsFor + " goals - " + bundesliga.get(i).get(j).wins + " wins - " + bundesliga.get(i).get(j).loses + " loses - " + bundesliga.get(i).get(j).draws + " draws");
    //}//end inner for(j)
    //println();
    //println();

    //for (int j = 0; j < liga.get(i).size(); j++) {
    // println(liga.get(i).get(j).name + " - " + liga.get(i).get(j).points + " pts - " + liga.get(i).get(j).goalsFor + " goals - " + liga.get(i).get(j).wins + " wins - " + liga.get(i).get(j).loses + " loses - " + liga.get(i).get(j).draws + " draws");
    //}//end inner for(j)
    //println();
    //println();


    //for (int j = 0; j < seriea.get(i).size(); j++) {
    // println(seriea.get(i).get(j).name + " - " + seriea.get(i).get(j).points + " pts - " + seriea.get(i).get(j).goalsFor + " goals - " + seriea.get(i).get(j).wins + " wins - " + seriea.get(i).get(j).loses + " loses - " + seriea.get(i).get(j).draws + " draws");
    //}//end inner for(j)
    println();
    println();
  }//end inner for(i)
}//end setup() method

void draw() {
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
      
      
      //create two int variables that will find the index number of each team in the current line - -1 is default and means the team doesn't exist yet
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