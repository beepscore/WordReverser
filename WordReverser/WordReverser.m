//
//  WordReverser.m
//  WordReverser
//
//  Created by Steve Baker on 6/5/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import "WordReverser.h"

@implementation WordReverser

NSString *kSpaceCharAsString = @" ";

- (instancetype)init {
    self = [super init];
    if (self) {
        // https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Strings/Articles/CharacterSets.html#//apple_ref/doc/uid/20000153-74241
        NSMutableCharacterSet *workingSet = [[NSCharacterSet punctuationCharacterSet] mutableCopy];
        // add space
        [workingSet addCharactersInString:kSpaceCharAsString];
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

- (NSString *)lastCharAsString:(NSString *)aString {
    if (!aString
        || (0 == [aString length])) {
        return @"";
    }
    NSString *lastCharAsString = [aString substringFromIndex:[aString length] - 1];
    return lastCharAsString;
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

- (NSInteger)wordStopIndexWithString:(NSString *)aString
                      wordStartIndex:(NSInteger)startIndex {
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

- (NSInteger)wordEndIndexFromString:(NSString *)aString
                         startIndex:(NSInteger)startIndex {


    // TODO: handle startIndex is space

    for (NSInteger index = startIndex; index < [aString length]; ++index) {
        
        if (index == [aString length] - 1) {
            // index is at end of string
            return index;
        }

        NSString *charAtIndexAsString = [aString
                                         substringWithRange:NSMakeRange(index, 1)];
        if ([charAtIndexAsString isEqualToString:kSpaceCharAsString]) {
            if (index == startIndex) {
                return index;
            } else {
                return index - 1;
            }
        }
    }
    // shouldn't get here
    NSInteger errorCode = -1;
    return errorCode;
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

- (NSString *)stringByReversingStringExceptEndingSeparator:(NSString *)aString {
    if (!aString || (1 >= [aString length])) {
        return aString;
    }
    
    if (![self isLastCharSeparator:aString]) {
        return [self stringByReversingString:aString];
    } else {
        NSString *lastCharacter = [aString substringFromIndex:[aString length] - 1];
        NSString *stringByRemovingLastCharacter = [aString substringToIndex:[aString length] -1];
        NSString *reversedString = [self stringByReversingString:stringByRemovingLastCharacter];
        NSString *reversedStringAppendLastCharacter = [reversedString stringByAppendingString:lastCharacter];
        return reversedStringAppendLastCharacter;
    }
}

- (NSString *)stringByReversingWordOrder:(NSString *)aString {
    
    if (!aString || (1 >= [aString length])) {
        return aString;
    }

    NSString *workingString = [self stringByReversingStringExceptEndingSeparator:aString];

    NSInteger endIndex = 0;
    
    for (NSInteger startIndex = 0; startIndex < [workingString length]; ++startIndex) {
        
        endIndex = [self wordEndIndexFromString:workingString startIndex:startIndex];
        NSRange wordRange = NSMakeRange(startIndex, (endIndex - startIndex) + 1);
        if ((endIndex == [workingString length] - 1)
            && [self isLastCharSeparator:workingString]) {
            // don't reverse ending separator
            wordRange = NSMakeRange(startIndex, (endIndex - startIndex));
        }
        NSString *reversedWord = [workingString substringWithRange:wordRange];
        NSString *forwardWord = [self stringByReversingString:reversedWord];

        workingString = [workingString stringByReplacingCharactersInRange:wordRange
                                                      withString:forwardWord];
        // startIndex will be incremented by loop too
        startIndex = endIndex;
    }
    return workingString;
}

- (NSString *)reverseWords:(NSString *)aString {
    if (!aString || (1 >= [aString length])) {
        return aString;
    }

    NSString *reversedString = [self stringByReversingStringExceptEndingSeparator:aString];
    NSString *myString = @"";

    // split reversed string into an array of reversed words
    NSArray *words = [reversedString componentsSeparatedByString:kSpaceCharAsString];
    
    for (NSString* word in words) {
        myString = [myString stringByAppendingString:[self stringByReversingString:word]];
        myString = [myString stringByAppendingString:kSpaceCharAsString];
    }
    // remove extra space appended to end
    myString = [myString substringToIndex:[myString length] - 1];
    return myString;
}

- (NSString *)stringByReversingWordLetters:(NSString *)aString {
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
