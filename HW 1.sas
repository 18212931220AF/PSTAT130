***Programming_Question2;
data home.university_rankings_2022;
input rank$ uni$ city$ state$ tuition_fees;
datalines;
1 Princeton Princeton NJ 56010
2 Harvard Cambridge MA 55587
2 MIT Cambridge MA 55878
4 Yale NewHaven CT 59950
5 Stanford Stanford CA 56169
;
run;
proc print;run;


proc print data=home.university_rankings_2022 noobs label;
label rank = 'US News Rank (2022)'
	  uni = 'University'
	  city = 'City'
	  state = 'State'
	  tuition_fees = 'Tuition and Fees';  
run;


***Programming_Question3;
proc print data=data1.military label noobs;
var State Type Airport Awards;
where State = 'CA' and Type = 'Naval';
label Type = 'Military Branch';
sum awards;
run;


