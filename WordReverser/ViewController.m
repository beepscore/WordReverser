//
//  ViewController.m
//  WordReverser
//
//  Created by Steve Baker on 6/4/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* aString = @"This is a good problem.";
    NSString* wordString = @"a";
    
    NSLog(@"stringByReversingString(%@) = %@", wordString, [self stringByReversingString:wordString]);
    NSLog(@"reverseWordsDropPunctuationInString(%@) = %@", aString, [self reverseWordsDropPunctuationInString:aString]);
    NSLog(@"stringByReversingWordsInString(%@) = %@", aString, [self stringByReversingWordsInString:aString]);
}

- (NSString*)stringByReversingString:(NSString *)aString
{
    if (0 == [aString length])
    {
        return aString;
    }
    
    NSString *tempCharacter1, *tempCharacter2;
    NSRange myRange1, myRange2;
    NSMutableString *myMutableString = [[NSMutableString alloc] initWithString:aString];
    
    for (int stringPosition = 0; stringPosition < ([myMutableString length]/2); stringPosition++)
    {
        myRange1 = NSMakeRange(stringPosition, 1);
        myRange2 = NSMakeRange((([myMutableString length] - 1) - stringPosition), 1);
        
        tempCharacter1 = [myMutableString substringWithRange:myRange1];
        tempCharacter2 = [myMutableString substringWithRange:myRange2];
        
        [myMutableString replaceCharactersInRange:myRange1 withString:tempCharacter2];
        [myMutableString replaceCharactersInRange:myRange2 withString:tempCharacter1];
    }
    return myMutableString;
}


- (NSString *)reverseWordsDropPunctuationInString:(NSString *)aString
{
    if (!aString || (0 == [aString length]))
    {
        return aString;
    }
    
    NSString *myString = @"";
    
    NSCharacterSet* separators = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    NSArray *words = [aString componentsSeparatedByCharactersInSet:separators];
    
    for (NSString* word in words) {
        myString = [myString stringByAppendingString:[self stringByReversingString:word]];
    }
    return myString;
}


- (NSString *)stringByReversingWordsInString:(NSString *)aString
{
    if (!aString || (0 == [aString length]))
    {
        return aString;
    }
    
    NSCharacterSet* separators = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSMutableString *myMutableString = [[NSMutableString alloc] initWithString:aString];
    
    NSInteger stopIndex = 0;
    
    NSRange myRange;
    NSString *myWord;
    
    
    for (NSInteger startIndex = 0; ([myMutableString length] > startIndex); startIndex++)
    {
        
        if (![separators characterIsMember:[myMutableString characterAtIndex:startIndex]])
        {
            // we're at the start of a word
            stopIndex = startIndex;
            // advance stopIndex to end of the word
            while (![separators characterIsMember:[myMutableString characterAtIndex:stopIndex]]
                   && ([myMutableString length] > stopIndex))
            {
                stopIndex++;
            }
            
            myRange = NSMakeRange(startIndex, (stopIndex - startIndex)+1);
            myWord = [myMutableString substringWithRange:myRange];
            
            myWord = [self stringByReversingString:myWord];
            
            [myMutableString replaceCharactersInRange:myRange withString:myWord];
            
            // startIndex will be incremented by loop too
            startIndex = stopIndex;
        }
        
    }
    
    return myMutableString;
}

@end
