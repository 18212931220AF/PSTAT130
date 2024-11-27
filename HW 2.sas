***Part a;
proc format;
	value $locationfmt FB = 'Folly Beach'
					   IP = 'Isle of Palms'
					   SI = 'Sullivans Island';
	value orgfmt low-<1500 = 'Individual'
		  		 1500-high = 'Group';
run;

***Part b;
*(1); ods listing file='/home/u63370775/Homework/cleanup_listing_report.lst';
*(2); options date linesize=85 nonumber;
*(9); title color=blue italic height=6 justify=right 'Cleanup Hours Report';
proc print data=homework.cleanup noobs label n='Total number of observations = ';  *(3)/(10);
	var date org location hours;   *(4);
	where (location = 'FB' or location = 'SI') and hours <= 2.5;   *(5);
	label date = 'Event Date'
		  org = 'Organization Type'
		  location = 'Location'
		  hours = 'Cleanup Hours';   *(6);
	format location $locationfmt.    
		   org orgfmt.
		   date MMDDYY8.;      *(7)-(8);
run;
ods listing close;	
*(11) The title format only apply in the html report but no in the listing report. The 
variables name is separate into two words in the listing report, but in the html report the 
variables name are in the same line. Also, the html report is a form, but the listing report 
only listing contents.;



***Part c;
proc contents data=homework.cleanup;run;
*(1) There are total 17 observations in the data set.;
*(2) There are total 6 variables in the data set.;
*(3) Org is numeric variable.;
