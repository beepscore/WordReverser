//
//  WordReverser.h
//  WordReverser
//
//  Created by Steve Baker on 6/5/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//
/**
 WordReverser has methods to reverse words and strings.
 It could be implemented as a category on NSString instead.
 */

#import <Foundation/Foundation.h>

@interface WordReverser : NSObject

@property (strong, nonatomic) NSCharacterSet* separators;

- (NSMutableArray*)arrayFromCharacterSet:(NSCharacterSet *)characterSet;

- (NSString *)lastCharAsString:(NSString *)aString;

- (BOOL)isLastCharSeparator:(NSString *)aString;

// TODO: Consider delete this, use wordEndIndexFromString:startIndex instead
- (NSInteger)wordStopIndexWithString:(NSString *)aString
                      wordStartIndex:(NSInteger)startIndex;

- (NSInteger)wordEndIndexFromString:(NSString *)aString
                         startIndex:(NSInteger)startIndex;

/**
 stringByReversingString reverses in place
 This reduces memory requirements.
 */
- (NSString*)stringByReversingString:(NSString *)aString;

- (NSString *)stringByReversingStringExceptEndingSeparator:(NSString *)aString;

/**
 @return words in original order, each word's letters are reversed.
 */
- (NSString *)stringByReversingWordLetters:(NSString *)aString;

/**
 @return words in reverse order, each word's letters are not reversed.
 */
- (NSString *)stringByReversingWordOrder:(NSString *)aString;

/**
 @return words in reverse order, each word's letters are not reversed.
 */
- (NSString *)reverseWords:(NSString *)aString;

@end
