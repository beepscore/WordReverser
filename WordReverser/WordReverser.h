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

- (NSInteger)wordStopIndexWithString:(NSString *)aString wordStartIndex:(NSInteger)startIndex;

/**
 stringByReversingString reverses in place
 This reduces memory requirements.
 */
- (NSString*)stringByReversingString:(NSString *)aString;

- (NSString *)reverseWordsStripPunctuationInString:(NSString *)aString;

- (NSString *)stringByReversingWordsInString:(NSString *)aString;

@end
