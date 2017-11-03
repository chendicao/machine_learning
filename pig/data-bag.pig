
-- Description: Explain the bag data structure

REGISTER '/Users/doina/Desktop/CIS761/scripts/pig/hadoop-mapreduce-client-core-2.7.1.jar';

outerbag = LOAD '$input' USING PigStorage(',') AS (f1:int, f2:int, f3:int);
DUMP outerbag;

innerbag = GROUP outerbag BY f1;
DUMP innerbag;

STORE innerbag INTO '$out';
