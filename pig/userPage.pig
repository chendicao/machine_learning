Users = LOAD '$input1' USING PigStorage(' ') AS (name:chararray, age:long); 
Fltrd = filter Users by age >= 18 and age <= 25;
Pages = LOAD '$input2' USING PigStorage(' ') AS (user:chararray, url:chararray); 
Jnd = join Fltrd by name, Pages by user;
Grpd = group Jnd by url;
Smmd = foreach Grpd generate group, COUNT(Jnd) as clicks;
Srtd = order Smmd by clicks desc;
Top5 = limit Srtd 5;
store Top5 into '$out';
