***Question 1;
***(a);
proc contents data=hw.heart;
run;
***There are 9 variables in this data set.;

***(b);
data Bacter (keep=Patient Survive Arterial)
	 Cardio
	 Hypovol (drop=Shock Urinary)
	 Neuro (drop=Arterial)
	 NonShock (keep=Patient Heart Cardiac Urinary)
	 Other (keep=Patient Survive);
set hw.heart;
if shock = 'BACTER' then output Bacter;
if shock = 'CARDIO' then output Cardio;
if shock = 'HYPOVOL' then output Hypovol;
if shock = "NEURO" then output Neuro;
if shock = 'NONSHOCK' then output NonShock;
if shock = 'OTHER' then output Other;
run;

***(c);
***There are 20 observations in the heart data set. There are 3 observations in the Bacter data
   set. There are 5 observations in the Cardio data set. There are 4 observations in the 
   Hypovol data set. There are 1 observations in the Neuro data set. There are 2 observations 
   in the NonShock data set. There are 5 observations in the Other data set.;
   
***(d);
data h1;
	set hw.heart;
	SurviveRT = sum(SurviveRT, Survive);
	retain;
run;
proc print data=h1;
run;

data h2;
	set hw.heart;
	SurviveRT + Survive;
run;
proc print data=h2;
run;

***(e);
proc sort data=hw.heart out=heart_sorted;
	by Shock;
run;
data h3;
	set heart_sorted;
	by Shock;
	if first.shock then TotalSurvive = 0;
	TotalSurvive + Survive;
	if last.shock;
	keep Shock TotalSurvive;
run;
proc print;run;

***(f);
data bills;
	set hw.heart;
	year=1;
	bill_proj = bill * 1.082;
	output;
	year=2;
	bill_proj = bill_proj *1.082;
	output;
	year=3;
	bill_proj = bill_proj * 1.082;
	output;
	format bill_proj dollar7.;
	keep patient year bill_proj;
	label patient = 'Patient ID'
		  year = 'Year'
		  bill_proj = 'Projected Bill';
run;
proc print label;run;

***(g);
proc gchart data=hw.heart;
	hbar Shock;
run;

***(h);
proc gchart data=hw.heart;
pie Shock / sumvar=heart 
			type=mean
			explode='CARDIO';
format heart 4.;
run;

***(i);
proc gplot data=hw.heart;
plot arterial*heart / vaxis=50 to 150 by 10 regeqn;
symbol value=circle color=red i=rl;
label arterial = 'Arterial Pressure' heart = 'Heart Rate';
run;
quit;