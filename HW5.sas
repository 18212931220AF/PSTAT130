***Question 1;
***(a);
libname hw '/home/u63370775/homework';
proc contents data=hw.may2022;
run;
proc contents data=hw.june2022;
run;
proc contents data=hw.july2022;
run;
** There are 55 obs in may2022, 64 obs in June2022, 63 obs in JUly 2022.; 

***Variable names;
*May 2022: away_team_abbr, away_score, day, home_team_abbr, home_score, home_winprob;
*June 2022: away_abbr, away_team_score, day, home_abbr, home_team_score, home_winprob;
*July 2022: away_abbr, away_score, day, home_abbr, home_score, home_team_winprob;

***(b);
data may2022;
	set hw.may2022;
	month='May';
run;

data june2022;
	set hw.june2022;
	month='June';
run;

data july2022;
	set hw.july2022;
	month='July';
run;

data games;
	format month $4.;
	set may2022(rename=(home_team_abbr=home_abbr
						away_team_abbr=away_abbr))
		june2022(rename=(home_team_score=home_score
						 away_team_score=away_score))
		july2022(rename=(home_team_winprob=home_winprob));
	year=2022;
run;

***(c);
proc print data=games;
run;

***(d);
data monthLookup;
input month $ m;
datalines;
May 5
June 6
July 7
;
run;

proc sort data=games;
	by month;
run;

proc sort data=monthLookup;
	by month;
run;

data games; 
	merge games monthLookup;
	by month;
run;

proc sort data=games out=games_sorted;
	by m;
run;

***(e);
proc print data=games_sorted label noobs n;
	var month day home_abbr away_abbr home_score away_score;
	label home_abbr = 'Home Team'
		  away_abbr = 'Away Team'
		  home_score = 'Home Score'
		  away_score = 'Away Score';
run;

***(f);
proc sort data=games_sorted;
	by home_abbr;
run;
proc sort data=hw.teams out=teams_sorted;
	by team_abbr;
run;

data games2;
	merge games_sorted
	      teams_sorted(rename=(team_abbr=home_abbr
	  					       team=Home));
	by home_abbr;
run;

proc sort data=games2;
	by away_abbr;
run;

data games2;
	merge games2
		  teams_sorted(rename=(team_abbr=away_abbr
					   		   team=Away));
	by away_abbr;
	date = mdy(m,day,year);
run;

***(g);
ods listing file = '/home/u63370775/Homework/games.lst';
proc print data=games2 noobs label;
	var date home away home_score away_score;
	format date mmddyy10.;
	label date = 'Game Date'
		  home = 'Home Team'
		  away = 'Away Team'
		  home_score = 'Home Team Score'
		  away_score = 'Away Team Score';
	title 'Games Report For May June July in 2022';
	options number pageno=2;
run;
ods listing close;