libname mysas'documents';
data newdata1;
set mysas.pima;
if bmi=0 then delete;
else output;
run;
proc means data=newdata1;
var age bmi;
output out=avgdata;
run;

data diabetes;
set newdata1;
if diabetes ='TRUE' then output;
else delete;
run;

proc format;
value agegrp 21-<40 = '21-39'
		  40-<60 = '40-59'
		  60-<80 = '60-79'
		  80-<85   = '80-84';

run;
proc freq data=diabetes;
tables age*diabetes / OUT=COUNTDATA;
format age agegrp.;
run;

proc means data=work.diabetes mean mode median stddev;
var age bmi diastolic_bp;
OUTPUT OUT=work.VARIABLESTATS;
run;
