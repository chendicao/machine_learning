-- Description: Strips quotes from tweets. Demonstrates UDF

REGISTER '/Users/doina/Desktop/CIS761/scripts/pig/Tweets.jar';
REGISTER '/Users/doina/Desktop/CIS761/scripts/pig/commons-lang3-3.5.jar';

DEFINE StripQuote StripQuote();

data = LOAD '$input' USING PigStorage(',');

tweets = FOREACH data GENERATE StripQuote($7);

DUMP tweets;
