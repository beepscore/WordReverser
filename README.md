# Purpose
Write app to reverse words within a string.

# Reuslts

## Assumptions
Note "reverse words within a string" is ambiguous.
Also punctuation can be handled several ways.
Reverse "I am so- happy!"
Assume desired output is reverse word order "happy so- am I!"

### reversing entire string is not a general solution
"!yppah -os ma I"
However you can apply string reversing as described below.

### reverse word order
Make two reversing passes.
I read this technique somewhere don't remember where.
First reverse the entire string.
Leave ending punctuation in place.
"yppah -os ma I!"

Then iterate through reversed words using space as separators.
Reverse each word but keep word order.
"happy so- am I!"

## TODO
Consider reversing sentence by sentence and keeping punctuation at end of each sentence.