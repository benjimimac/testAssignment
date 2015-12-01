class Team {
  //class fields
  private String teamName;
  int goalsFor;
  int goalsAgainst;
  int goalDifference;
  private int points;
  int wins;
  int loses;
  int draws;
  int played;

  //Constructor method
  Team(String teamName, int goalsFor, int goalsAgainst) {
    this.teamName = teamName;
    this.goalsFor = goalsFor;
    this.goalsAgainst = goalsAgainst;
    goalDifference = goalsFor - goalsAgainst;
    played = 1;

    //if the team won
    if (goalsFor > goalsAgainst) {
      points = 3; 
      wins = 1;
      loses = 0;
      draws = 0;
    } else if (goalsFor < goalsAgainst) {//else if the team lost
      points = 0;
      wins = 0;
      loses = 1;
      draws = 0;
    } else {//else the team drew
      points = 1;
      wins = 0;
      loses = 0;
      draws = 1;
    }
  }//end Team() constructor method

  /*Method name: editTeam
   Purpose: Adds to the fields of the class
   Arguments: Two integer variables - goalsFor and goalsAgainst
   */
  void editTeam(int goalsFor, int goalsAgainst) {
    goalDifference += (goalsFor - goalsAgainst);
    this.goalsFor += goalsFor;
    this.goalsAgainst += goalsAgainst;
    played++;

    if (goalsFor > goalsAgainst) {//If the team won
      points += 3; 
      wins += 1;
    } else if (goalsFor < goalsAgainst) {//else if the team lost
      loses += 1;
    } else {//else the team drew
      points += 1;
      draws += 1;
    }
  }//end editTeam() method

  //getters and setters go here
  String getTeamName() {
    return teamName;
  }//end getName method
  
  int getPoints(){
   return points; 
  }
}//end class Team