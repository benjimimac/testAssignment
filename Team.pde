class Team {
  String name;
  int goalsFor;
  int goalsAgainst;
  int points;
  int goalDifference;
  int wins;
  int loses;
  int draws;

  //Constructor method
  Team(String name, int goalsFor, int goalsAgainst) {
    this.name = name;
    this.goalsFor = goalsFor;
    this.goalsAgainst = goalsAgainst;
    goalDifference = goalsFor - goalsAgainst;

    if (goalsFor > goalsAgainst) {
      points = 3; 
      wins = 1;
      loses = 0;
      draws = 0;
    } else if (goalsFor < goalsAgainst) {
      points = 0;
      wins = 0;
      loses = 1;
      draws = 0;
    } else {
      points = 1;
      wins = 0;
      loses = 0;
      draws = 1;
    }
  }

  void editTeam(int goalsFor, int goalsAgainst) {
    goalDifference += (goalsFor - goalsAgainst);
    this.goalsFor += goalsFor;
    this.goalsAgainst += goalsAgainst;

    if (goalsFor > goalsAgainst) {
      points += 3; 
      wins += 1;
    } else if (goalsFor < goalsAgainst) {
      loses += 1;
    } else {
      points += 1;
      draws += 1;
    }
  }
}