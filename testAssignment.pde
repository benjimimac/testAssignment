final int SEASONS = 10;  //This is a constant variable - there are 10 teams

//create ArrayLists to store obects in
ArrayList<ArrayList<Team>> premierLeague = new ArrayList<ArrayList<Team>>();
ArrayList<ArrayList<Team>> bundesliga = new ArrayList<ArrayList<Team>>();
ArrayList<ArrayList<Team>> liga = new ArrayList<ArrayList<Team>>();
ArrayList<ArrayList<Team>> seriea = new ArrayList<ArrayList<Team>>();

/*Setup method will prepare all the relevant data before anythiing has to be implemented
*/
void setup() {
  //call the loadData() method and pass the filenames and ArrayList objects
  loadData("premier_league.csv", premierLeague);
  loadData("bundesliga.csv", bundesliga);
  loadData("liga.csv", liga);
  loadData("seriea.csv", seriea);

  //Print out the data as a test to show it working - show each season separated by two blank lines - won't be in the final version.
  for (int i = 0; i < SEASONS; i++) {
    for (int j = 0; j < premierLeague.get(i).size(); j++) {
      println(premierLeague.get(i).get(j).name + " - " + premierLeague.get(i).get(j).points + " pts - " + premierLeague.get(i).get(j).goalsFor + " goals - " + premierLeague.get(i).get(j).wins + " wins - " + premierLeague.get(i).get(j).loses + " loses - " + premierLeague.get(i).get(j).draws + " draws");
    }//end inner for(j)
    println();
    println();

    for (int j = 0; j < bundesliga.get(i).size(); j++) {
      println(bundesliga.get(i).get(j).name + " - " + bundesliga.get(i).get(j).points + " pts - " + bundesliga.get(i).get(j).goalsFor + " goals - " + bundesliga.get(i).get(j).wins + " wins - " + bundesliga.get(i).get(j).loses + " loses - " + bundesliga.get(i).get(j).draws + " draws");
    }//end inner for(j)
    println();
    println();

    for (int j = 0; j < liga.get(i).size(); j++) {
      println(liga.get(i).get(j).name + " - " + liga.get(i).get(j).points + " pts - " + liga.get(i).get(j).goalsFor + " goals - " + liga.get(i).get(j).wins + " wins - " + liga.get(i).get(j).loses + " loses - " + liga.get(i).get(j).draws + " draws");
    }//end inner for(j)
    println();
    println();


    for (int j = 0; j < seriea.get(i).size(); j++) {
      println(seriea.get(i).get(j).name + " - " + seriea.get(i).get(j).points + " pts - " + seriea.get(i).get(j).goalsFor + " goals - " + seriea.get(i).get(j).wins + " wins - " + seriea.get(i).get(j).loses + " loses - " + seriea.get(i).get(j).draws + " draws");
    }//end inner for(j)
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
void loadData(String filename, ArrayList<ArrayList<Team>> teams) {
  //load the file into an array of Strings - each element is now one line from the file
  String[] leagueLines = loadStrings(filename);

  //find out how many games in a season - one league has 18 teams and the others have 20 so there are different amounts to each league
  int gamesPerSeason = leagueLines.length / SEASONS;


  //use loops to iterate through the array leagueLines
  for (int i = 0; i < SEASONS; i++) {
    //create a new outer dimension to teams - outer dimensions will reference each season
    teams.add(new ArrayList<Team>());

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
    }//end inner for(j)
  }//end outer for(i)
}//end loadData() method