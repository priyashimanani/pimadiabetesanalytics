libname mysas'documents';
proc means data=mysas.pima;
var age bmi;
output out=work.avgdata;
run;

data work.diabetes;
set mysas.pima;
if work.diabetes ='TRUE' then output;
else delete;
run;
proc format;
value agegrp 21-<40 = '21-39'
		  40-<60 = '40-59'
		  60-<80 = '60-79'
		  80-<85   = '80-84';

run;
proc freq data=work.diabetes;
tables age*diabetes / OUT=work.COUNTDATA;
format age agegrp.;
run;

proc means data=work.diabetes mean mode median stddev;
var age bmi diastolic_bp;
OUTPUT OUT=work.VARIABLESTATS;
run;
