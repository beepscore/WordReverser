//
//  WordReverser.m
//  WordReverser
//
//  Created by Steve Baker on 6/5/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import "WordReverser.h"

@implementation WordReverser

- (id)init {
    self = [super init];
    if (self) {
        // https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Strings/Articles/CharacterSets.html#//apple_ref/doc/uid/20000153-74241
        NSMutableCharacterSet *workingSet = [[NSCharacterSet punctuationCharacterSet] mutableCopy];
        // add space
        [workingSet addCharactersInString:@" "];
        self.separators = [workingSet copy];
    }
    return self;
}

// Use to check definition of punctuationCharacterSet
// Reference
// http://stackoverflow.com/questions/26610931/list-of-characters-in-an-nscharacterset?rq=1
// https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Strings/Articles/CharacterSets.html#//apple_ref/doc/uid/20000153-74241
// http://www.unicode.org/
- (NSMutableArray*)arrayFromCharacterSet:(NSCharacterSet *)charset {
    NSMutableArray *array = [NSMutableArray array];
    for (int plane = 0; plane <= 16; plane++) {
        if ([charset hasMemberInPlane:plane]) {
            UTF32Char c;
            for (c = plane << 16; c < (plane+1) << 16; c++) {
                if ([charset longCharacterIsMember:c]) {
                    UTF32Char c1 = OSSwapHostToLittleInt32(c); // To make it byte-order safe
                    NSString *s = [[NSString alloc] initWithBytes:&c1 length:4 encoding:NSUTF32LittleEndianStringEncoding];
                    [array addObject:s];
                }
            }
        }
    }
    return array;
}

- (BOOL)isLastCharSeparator:(NSString *)aString {
    if (!aString || (0 == [aString length])) {
        return NO;
    }
    
    unichar lastChar = [aString characterAtIndex:([aString length] - 1)];
    
    if ([self.separators characterIsMember:lastChar]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString*)stringByReversingString:(NSString *)aString {
    if (!aString || (1 >= [aString length])) {
        return aString;
    }
    
    NSString *tempCharacter1, *tempCharacter2;
    NSRange myRange1, myRange2;
    NSMutableString *myMutableString = [[NSMutableString alloc] initWithString:aString];
    
    for (int stringPosition = 0; stringPosition < ([myMutableString length]/2); stringPosition++) {
        // ranges of length 1
        // as loop increments, myRange1 moves from start of string towards center
        myRange1 = NSMakeRange(stringPosition, 1);
        // as loop increments, myRange2 moves from end of string towards center
        myRange2 = NSMakeRange((([myMutableString length] - 1) - stringPosition), 1);
        
        // temporary strings for swap
        tempCharacter1 = [myMutableString substringWithRange:myRange1];
        tempCharacter2 = [myMutableString substringWithRange:myRange2];
        
        // reverse mutable string in place by swapping characters
        [myMutableString replaceCharactersInRange:myRange1 withString:tempCharacter2];
        [myMutableString replaceCharactersInRange:myRange2 withString:tempCharacter1];
    }
    // convert mutable string to NSString to reduce chance of surprising the caller
    return [NSString stringWithString:myMutableString];
}


- (NSString *)reverseWordsStripPunctuationInString:(NSString *)aString {
    if (!aString || (1 >= [aString length])) {
        return aString;
    }
    
    NSString *myString = @"";

    // split string into an array of words, discarding separators.
    NSArray *words = [aString componentsSeparatedByCharactersInSet:self.separators];
    
    for (NSString* word in words) {
        myString = [myString stringByAppendingString:[self stringByReversingString:word]];
    }
    return myString;
}


- (NSInteger)wordStopIndexWithString:(NSString *)aString wordStartIndex:(NSInteger)startIndex {
    if (!aString
        || (startIndex > [aString length] - 1)) {
        return 0;
    }

    NSInteger stopIndex = startIndex;
    // advance stopIndex to end of the word
    // stopIndex is before last character in string
    // and character after stopIndex isn't a separator
    while ((stopIndex < [aString length] - 1)
           && ![self.separators characterIsMember:[aString characterAtIndex:stopIndex + 1]]) {
        stopIndex++;
    }
    return stopIndex;
}

- (NSString *)stringByReversingWordsInString:(NSString *)aString {
    if (!aString || (1 >= [aString length])) {
        return aString;
    }
    
    NSMutableString *myMutableString = [[NSMutableString alloc] initWithString:aString];

    for (NSInteger startIndex = 0; ([myMutableString length] > startIndex); startIndex++) {
        
        if (![self.separators characterIsMember:[myMutableString characterAtIndex:startIndex]]) {
            // we're at the start of a word

            NSInteger stopIndex = [self wordStopIndexWithString:myMutableString
                                                 wordStartIndex:startIndex];
            NSRange myRange = NSMakeRange(startIndex, (stopIndex - startIndex) + 1);

            NSString *myWord = [myMutableString substringWithRange:myRange];
            NSString *myReversedWord = [self stringByReversingString:myWord];
            
            [myMutableString replaceCharactersInRange:myRange withString:myReversedWord];
            
            // startIndex will be incremented by loop too
            startIndex = stopIndex;
        }
    }
    // convert mutable string to NSString to reduce chance of surprising the caller
    return [NSString stringWithString:myMutableString];
}

@end
