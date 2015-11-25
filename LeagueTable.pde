class LeagueTable {
  //Declare/initialise fields
  private float tableMargin;
  private float tableTop;
  private float tableW;
  private float tableH;
  private float colScaleA;
  private float colScaleB;
  private float col1X;
  private float col2X;
  private float col3X;
  private float col4X;
  private float col5X;
  private float col6X;
  private float col7X;
  private float col8X;
  private float col9X;
  private float rowHeight;
  private float padding;

  //Constructor method
  LeagueTable(float noOfTeams) {
    tableMargin = width * 0.1f;
    tableTop = height * 0.1f;
    tableW = width - (tableMargin * 2);
    tableH = width - (tableTop * 2);
    colScaleA = 0.0714285f;
    colScaleB = 0.3571428f;
    col1X = tableMargin + (tableW * colScaleA);
    col2X = col1X + (tableW * colScaleB);
    col3X = col2X + (tableW * colScaleA);
    col4X = col3X + (tableW * colScaleA);
    col5X = col4X + (tableW * colScaleA);
    col6X = col5X + (tableW * colScaleA);
    col7X = col6X + (tableW * colScaleA);
    col8X = col7X + (tableW * colScaleA);
    col9X = col8X + (tableW * colScaleA);
    rowHeight = tableH / noOfTeams;
    padding = rowHeight * 0.2f;
  }

  void renderTable(ArrayList<ArrayList<Team>> team, int year) {
    //Draw the table background
    fill(0);
    stroke(255);
    text("Pos", tableMargin + padding, tableTop - padding);
    text("Name", col1X + padding, tableTop - padding);
    text("Pld", col2X + padding, tableTop - padding);
    text("W", col3X + padding, tableTop - padding);
    text("D", col4X + padding, tableTop - padding);
    text("L", col5X + padding, tableTop - padding);
    text("G+", col6X + padding, tableTop - padding);
    text("G-", col7X + padding, tableTop - padding);
    text("GD", col8X + padding, tableTop - padding);
    text("Pts", col9X + padding, tableTop - padding);
    for (int i = 0; i < team.get(year).size(); i++) {
      float textY = tableTop + rowHeight + (rowHeight * i) - padding;
      float posX = tableMargin + padding;
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
      rect(tableMargin, tableTop + (rowHeight * i), tableW, rowHeight);
      fill(255);
      text(i + 1, posX, textY);
      text(team.get(0).get(i).getName(), nameX, textY);
      text(team.get(0).get(i).played, pldX, textY);
      text(team.get(0).get(i).wins, wX, textY);
      text(team.get(0).get(i).draws, dX, textY);
      text(team.get(0).get(i).loses, lX, textY);
      text(team.get(0).get(i).goalsFor, gPX, textY);
      text(team.get(0).get(i).goalsAgainst, gMX, textY);
      text(team.get(0).get(i).goalDifference, gDX, textY);
      text(team.get(0).get(i).points, ptsX, textY);
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
  
  void moveLeft(){
    tableMargin -= 1.0f;
    tableTop -= 1.0f;
    tableW = 1.0f;
    tableH = 1.0f;
  }

  //Getter and setter methods
  float getTableMargin() {
    return tableMargin;
  }//end getTableMargin method

  float getPadding() {
    return padding;
  }//end getPadding method

  float getTableW() {
    return tableW;
  }
}