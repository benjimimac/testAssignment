final int SEASONS = 1;

ArrayList<ArrayList<Team>> teams = new ArrayList<ArrayList<Team>>();

void setup() {
  loadData("test1season.csv");

  for (int i = 0; i < SEASONS; i++) {
   for (int j = 0; j < teams.get(i).size(); j++) {
   println(teams.get(i).get(j).name + " - " + teams.get(i).get(j).points + " pts - " + teams.get(i).get(j).goalsFor + " goals - " + teams.get(i).get(j).wins + " wins - " + teams.get(i).get(j).loses + " loses - " + teams.get(i).get(j).draws + " draws");
   }
   }
}

void draw() {
}

void loadData(String filename) {
  //load the file into an array
  String[] leagueLines = loadStrings(filename);

  //find out how many games in a season
  int gamesPerSeason = leagueLines.length / SEASONS;


  //use loops to iterate through the array leagueLines
  for (int i = 0; i < SEASONS; i++) {
    //create a new outer dimension to teams
    teams.add(new ArrayList<Team>());
    
    for(int j = i * gamesPerSeason; j < gamesPerSeason + (gamesPerSeason * i); j++){
      String[] leagueValues = leagueLines[j].split(",");
      
      String homeTeam = leagueValues[1];
      String awayTeam = leagueValues[2];
      String[] scores = leagueValues[3].split("-");
      int homeScore = parseInt(scores[0]);
      int awayScore = parseInt(scores[1]);
      
      //Team tempTeam = new Team(homeTeam, homeScore, awayScore);
      
      int homeIndex = -1;
      int awayIndex = -1;
      
      for(int k = 0; k < teams.get(i).size(); k++){
        
       if(homeTeam.equals(teams.get(i).get(k).name)){
        homeIndex = k; 
       }
       
       if(awayTeam.equals(teams.get(i).get(k).name)){
        awayIndex = k; 
       }
       
      }
      //println(homeIndex);
      
      if(homeIndex < 0){
      teams.get(i).add(new Team(homeTeam, homeScore, awayScore));
      }
      else{
       teams.get(i).get(homeIndex).editTeam(homeScore, awayScore); 
       println(teams.get(i).get(homeIndex).name);
      }
      
      
      if(awayIndex < 0){
      teams.get(i).add(new Team(awayTeam, awayScore, homeScore));
      }
      else{
       teams.get(i).get(awayIndex).editTeam(awayScore, homeScore); 
       println(teams.get(i).get(awayIndex).name);
      }
      println(teams.get(i).size());
      //println((j + 1) + " - " + tempTeam.name + ", " + awayTeam + ", " + tempTeam.goalsFor + "-" + tempTeam.goalsAgainst);
    }
  }
  
  
}