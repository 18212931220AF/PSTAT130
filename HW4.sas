***Question 1;
***(a);
proc import datafile='/home/u63370775/Homework/wnba_games.xlsx'
			out=wnba
			dbms=xlsx;
			sheet="wnba2022";
			getnames=YES;
run;			
			
***(b);
proc contents data=wnba; run;

***(c);
ods listing file='/home/u63370775/Homework/wnba_games_lstreport.lst';
option date pageno=7;
title 'WNBA Games Report in 2022';
proc print data=wnba;
format date date9.
	   home_team_winprob 8.4
	   away_team_winprob 8.4;
run;
ods listing close;


***Question 2;
***(a);
proc print data=wnba; run;

data wnba2;
	set wnba;
	*(i);
	if home_team_score > away_team_score
		then Winner = 'Home';
	else Winner = 'Away';
	*(ii);
	if home_team_score > away_team_score
		then WinningTeam = home_team_abbr;
	else WinningTeam = away_team_abbr;
	*(iii);
	HomeRatingChange = home_team_pregame_rating - home_team_postgame_rating;
	*(iv);
	AwayRatingChange = away_team_pregame_rating - away_team_postgame_rating;
	*(v);
	keep  date home_team_abbr away_team_abbr Winner WinningTeam home_team_score
	      away_team_score HomeRatingChange AwayRatingChange;
run;

***(b);
proc print data=wnba2 label;
*(i);
var date home_team_abbr away_team_abbr Winner WinningTeam HomeRatingChange AwayRatingChange;
*(ii);
format HomeRatingChange 8.4
	   AwayRatingChange 8.4
	   date mmddyy10.;
*(iii);
label date = 'Game Date'
	  home_team_abbr = 'Home Team'
	  away_team_abbr = 'Away Team'
	  WinningTeam = 'Winning Team'
	  HomeRatingChange = 'Home Team Rating Change'
	  AwayRatingChange = 'Away Team Rating Change';
*(iv);
title 'WNBA Games Report';
run;


***(c);
data wnba3;
	*(i);
	set wnba2 (keep=date home_team_abbr away_team_abbr Winner home_team_score
			   away_team_score);
	*(ii);
	format date mmddyy8.;
	*(iii);
	Month = Month(date);
	*(iv);
	if abs(home_team_score - away_team_score) < 10
		then ScoreDiff='Less than 10 points';
	if 10 <= abs(home_team_score - away_team_score) <= 20 
		then ScoreDiff='Between 10 and 20 points';
	if abs(home_team_score - away_team_score) > 20 
		then ScoreDiff='More than 20 points';
run;


***(d);
*(iii);
proc sort data=wnba3 out=wnba3_sorted;
 by month home_team_abbr Winner;
run; 

proc print data=wnba3_sorted label n='The number of the observations = '; *(v);
*(i);
title 'WNBA Games Report in 2022';
*(ii);
by month;
pageby month;
*(iv);
var date home_team_abbr away_team_abbr Winner ScoreDiff;
*(vi);
label date = 'Date'
	  home_team_abbr = 'Home Team'
	  away_team_abbr = 'Away Team'
	  ScoreDiff = 'Difference in Scores';
run;


***(e);
***I found that the variable ScoreDiff is only show the part of the result 
   (Between 10 and 20 p). It show 'Between 10 and 20 p' rather than 'Between 10 and 20 points';


***(f);
data wnba3;
	*(i);
	set wnba2 (keep=date home_team_abbr away_team_abbr Winner home_team_score
			   away_team_score);
	*(ii);
	format date mmddyy8.;
	*(iii);
	Month = Month(date);
	length ScoreDiff $30.;
	*(iv);
	if abs(home_team_score - away_team_score) < 10
		then ScoreDiff='Less than 10 points';
	if 10 <= abs(home_team_score - away_team_score) <= 20 
		then ScoreDiff='Between 10 and 20 points';
	if abs(home_team_score - away_team_score) > 20 
		then ScoreDiff='More than 20 points';
run;
