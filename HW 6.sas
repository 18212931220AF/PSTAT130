***Question 1;
***(a);
proc freq data=hw.marketing;
run;
***There are 7 frequency tables. Yes, it represent all of variables in the data set.;

***(b);
proc freq data=hw.marketing;
	table job marital;
run;
***Job has 33 missing values, Marital has 5 missing values.;

***(c);
proc freq data=hw.marketing;
	table job*marital;
run;
***There are repeated values of divorced, married and single in Marital.;

***(d);
proc format;
	value $ marfmt 'D','divorced' = 'Divorced'
				   'M','married' = 'Married'
				   'S','single' = 'Single';
run;
proc freq data=hw.marketing;
	table job*marital;
	format marital $marfmt.;
run;


***Question 2;
***(a);
proc means data=hw.marketing;
run;

***(b);
***The variables that displayed are age, housing and duration. No, it not represent all 
   of the variables in the data set. Only numeric values are displayed in the report.;
   
***(c);
***Variables job, marital, education, loan are exclude from the analysis.
   Character variables are excluded from the report.;

***(d);
proc means data=hw.marketing n mean stddev maxdec=2;
	var age duration;
run;

***(e);
proc sort data=hw.marketing out=marketing_sorted;
	by job;
run;
proc means data=marketing_sorted n mean stddev maxdec=2;
	var age duration;
	by job;
run;


***Question 3;
***(a);
proc tabulate data=hw.marketing;
	class marital education;
	format marital $marfmt.;
	var duration;
	table education;
	table marital*duration*mean;
run;

***(b);
proc format;
	value $ edufmt 'basic.4y'-'basic.9y' = 'Basic'
				   'high.school' = 'High School'
				   'illiterate' = 'Illiterate'
				   'professional.course' = 'Professional Course'
				   'university.degree' = 'University Degree';
run;

***(c);
proc tabulate data=hw.marketing;
	class marital education;
	format marital $marfmt.
		   education $edufmt.;
	where education ~= 'unknown';
	var duration;
	table education all, marital all;
run;


***(d);
***The column variable is marital. The row variable is education.;

***(e);
***The number of observations.;

***(f);
proc tabulate data=hw.marketing;
	class marital education;
	format marital $marfmt.
		   education $edufmt.;
	where education ~= 'unknown';
	var duration;
	table education all, 
		  marital*duration*mean all*duration*mean;
run;


***Question 4;
***(a);
ods listing file='/home/u63370775/Homework/marketing_list.lst';
proc report data=hw.marketing;
	column education marital duration;
	define education / format=$edufmt.;
	define marital / format=$marfmt.;
	where education ~= 'unknown' and marital not is missing;
	options pageno=2;
run;
ods listing close;

***(b);
ods listing file='/home/u63370775/Homework/marketing_summary.lst';
proc report data=hw.marketing headline headskip;
	column education marital duration;
	define education / 'Education Level' format=$edufmt. group;
	define marital / 'Marital Status' format=$marfmt. group;
	define duration / median 'Median Duration of Call';
	where education ~= 'unknown' and marital not is missing;
	options pageno=2;
	break after education / summarize ol ul;  
	rbreak after / summarize dol;
run;
ods listing close;
