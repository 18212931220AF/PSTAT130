***Homework 3;
***Question 1;
***(a);
data work.Olympics;
infile "/home/u63370775/Homework/Olympics2016.dat";
input day $ 168-176
	  sport $ 80-101
	  name $ 6-55
	  sex $ 58
	  age 60-61
	  event $ 105-154
	  medal $ 160-165;
run;
proc contents data=work.olympics;run;
***The variable day is character;

***(b);
title color=green height=6 bold justify=left 'Olympics Report in 2016';
proc print data=work.Olympics noobs N = 'Total number of the observations = ';
run;


***Question 2;
***(a);
data work.Olympics2;
infile "/home/u63370775/Homework/Olympics2016.dat";
input @168 day date9.
	  @80 sport $22.
	  @6 name $50.
	  @58 sex $1.
	  @60 age 2.
	  @105 event $50.
	  @160 medal $6.;
run;

***(b);
*(1) 24 records were read from raw data file;
*(2) The SAS data set contain 24 observations;
*(3) The SAS data set contain 7 variables;

***(c);
proc contents data=work.Olympics2;
run;
***The variable day is numeric;

***(d);
ods listing file='/home/u63370775/Homework/Olymics_listing_report.lst';
options linesize=64 pageno=3 date;
title "Olympics Records Report";
proc print data=work.Olympics2;
format day mmddyy10.;
run;
ods listing close;
***Each observation is not on the single line in the listing report. Each observation is 
divide into two page;


***Question 3;
***(a);
data work.Olympics2;
infile "/home/u63370775/Homework/Olympics2016.dat";
input @168 day date9.
	  @80 sport $22.
	  @6 name $50.
	  @58 sex $1.
	  @60 age 2.
	  @105 event $50.
	  @160 medal $6.;
label day = 'Date of Event'
	  name = 'Name of Athlete';
format day date7.;
run;
proc contents data=work.Olympics2;
run;

***(b);
proc datasets library=work;
modify Olympics2;
format day mmddyy10.;
label name = 'Athlete Name';
run;
proc contents data=work.Olympics2;
run;


***Question 4;
***(a);
proc sort data=work.Olympics2 out=Olympics2_sorted;
by sex sport medal;
run;

***(b);
title1 color=red height=5 ITALIC '2016 Summer Olympics';
title2 color=blue bold height=4 '-Subset of Team USA Medals-';
title3 color=red justify=left height=3 '(Sorted by Gender, Sport, Medal)';
proc print data=Olympics2_sorted label N="Total number of the observations = " ;
var sport event medal name;
label sex = 'Gender'
	  medal = 'Type of Medal'
	  name = 'Athlete Name';
where medal = 'Gold' or medal = 'Silver' or medal = 'Bronze';
by sex;
pageby sex;
run;

