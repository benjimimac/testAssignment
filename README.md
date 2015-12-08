# testAssignment
c14723525
Bernard Mc Donnell
DT228/2
Object Oriented Programming

Deliverable 1:

The aim of my assignment is to compare the top four European football leagues - The Premier League, The Bundesliga, La Liga, and Serie A.
I will be comparing different stats over a ten year period, starting with the 2004/04 season up to the 2013/14 season.

Each file contains each leagues data, every single match that occurred over the ten years in the form:
home team,away team, home score - away score

Two splits will have to be done on this data as the team names are separated by "," (commas) and the scores
are separated by "-" hyphons.

Each created object will store a teams record for a particular season which can be accessed from an ArrayList using different loop indexes.

Over the coming month I intend to create menus which can transition smoothly and give the user options to look at specific leagues, or teams, or 
allow the user to make comparisons and see which league or team has been the strongest over the ten year period. I intend to research different ways
of conveying the data and also different ways of presenting the menus.

I will be adding additional classes to the program, some of which use the extends keyword to show different home and away versions of each league and the stats also.

Deliverable 2:

Finished program. Use the mouse to navigate through the program. You can view each league on a season by season basis, as well as view short versions of each league (Home and Away),
You would often see these short versions of the tables on sport websites, in particular betting websites to give the punter an idea of home and away form.

The input files are four ".csv" files that have every result in four European soccer leagues over a ten year period. I stored the filenames in a String array and made a call to a loadData
method, which utilises loops to open all the files and store the data in three dimensional ArrayLists. I could have used one ArrayList to store all this data but that would have involved 
using a four dimensional ArrayList and a much better understanding of polymorphism at the time. I think in the coming months I will revisit this part of the program to try and improve
on it. I decided it was better to sort the data in the ArrayLists rather than sorting it in real time everytime the objects are created. I used a simple bubble sort algorithm that
I edited in order to make it work over a three dimensional ArrayList, we had previously only implemented this kind of sort over one dimensional arrays in first year. I enjoy them kind of
problem solving elements to programming. Once the data was sorted, by most points accrued over a season - for each season, I set about creating the league table class. This was an
interesting task as I wanted to add animation as the user searched from season to season. When the arraows are clicked the entire league table moves to one direction in a fluid motion,
And when it is no longer visible on screen it reappears on the opposite side of the screen with the new data in it and cetres itself on the screen. If the user tries to move "out 
of bounds" of the ArrayLists a sound effect is played, a referees whistle, so the user knows they have reached the limits.

The second main menu option is to view stats from each league and compare them.
I have provided some animation when the user clicks on the left and right arrow buttons in both the league table view and the stats view. Again, the user can use the left and right arrows
to scroll through the seasons and compare each league based on most goals scored, average goals scored, and cleansheest kept. The animation is different on these arrow clicks,
The graphs never leave the screen, however the graphs themselves move to point to the next value.

Processing is a peculiar coding environment. I had lots of issues using it. It kept deleting classes on me and also renaming files and giving them different extensions ".tmp". 
I don't know if this was due to the fact that I was using a combination of Dropbox and Github for backing up but it took me a while to figure out a partial remedy, but not a fix.
A message appears every so often telling me that a file was edited externally and asks me if I want to reload the sketch. It won't let me select no. I eventually figured out that
if I go to the file location and rename it to its original filename, for example, Processing would rename the "Graph.pde" file to "Graph.pfe.87753869246986.tmp". When the message 
appears asking me if I want to reload the sketch I have to rename the new ".tmp" file back to its original. However, sometimes when Processing does this it also changes things
in the file. At one point I tried to push my most recent version to a branch on Github and it pushed a version with ".tmp" files that had edited code in it. Edited in such a way that
the entire program was broken. It took me a lot of searching online to find out how to revert to earlier commits. Eventually I restarted the entire program from scratch a week before the
due date. It gave me a chance to improve on parts of the code and also gave me a better understanding of the program and what I wanted to do.

Overall I'm very happy with the program, it's not the most inspiring program in the world but it took a lot of work, and it's entirely my own code and not a "copy and paste" job.
I have provided some screenshots of it running, they can be found in the sketch folder alongside the class files.