//
//  WordReverserTests.m
//  WordReverserTests
//
//  Created by Steve Baker on 6/4/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WordReverser.h"

@interface WordReverserTests : XCTestCase
@property (strong, nonatomic) WordReverser *wordReverser;
@end

@implementation WordReverserTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
    self.wordReverser = [[WordReverser alloc] init];
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testArrayFromCharacterSetPunctuation {
    NSArray *punctuationArray = [self.wordReverser
                                arrayFromCharacterSet:[NSCharacterSet punctuationCharacterSet]];
    XCTAssertEqual(688, [punctuationArray count]);
    XCTAssertFalse([punctuationArray containsObject:@" "]);

    XCTAssertTrue([punctuationArray containsObject:@"-"]);
    XCTAssertTrue([punctuationArray containsObject:@";"]);
    XCTAssertTrue([punctuationArray containsObject:@":"]);
    XCTAssertTrue([punctuationArray containsObject:@"."]);
    XCTAssertTrue([punctuationArray containsObject:@","]);
}

- (void)testSeparators {
    NSArray *separatorsArray = [self.wordReverser
                                arrayFromCharacterSet:self.wordReverser.separators];
    XCTAssertEqual(689, [separatorsArray count]);
    XCTAssertTrue([separatorsArray containsObject:@"-"]);
    XCTAssertTrue([separatorsArray containsObject:@";"]);
    XCTAssertTrue([separatorsArray containsObject:@":"]);
    XCTAssertTrue([separatorsArray containsObject:@"."]);
    XCTAssertTrue([separatorsArray containsObject:@","]);
    XCTAssertTrue([separatorsArray containsObject:@" "]);
}

- (void)testLastCharAsString {
    NSString* aString = @"";
    XCTAssertEqualObjects(aString, [self.wordReverser lastCharAsString:aString]);
    aString = @"a";
    XCTAssertEqualObjects(aString, [self.wordReverser lastCharAsString:aString]);
    aString = @".";
    XCTAssertEqualObjects(aString, [self.wordReverser lastCharAsString:aString]);
    XCTAssertEqualObjects(@" ", [self.wordReverser lastCharAsString:@"a "]);
    XCTAssertEqualObjects(@"b", [self.wordReverser lastCharAsString:@" b"]);
}

- (void)testIsLastCharSeparatorFalse {
    XCTAssertFalse([self.wordReverser isLastCharSeparator:nil]);
    XCTAssertFalse([self.wordReverser isLastCharSeparator:@""]);
    XCTAssertFalse([self.wordReverser isLastCharSeparator:@"a"]);
    XCTAssertFalse([self.wordReverser isLastCharSeparator:@".a"]);
    XCTAssertFalse([self.wordReverser isLastCharSeparator:@"a.c"]);
}

- (void)testIsLastCharSeparatorTrue {
    XCTAssertTrue([self.wordReverser isLastCharSeparator:@"."]);
    XCTAssertTrue([self.wordReverser isLastCharSeparator:@"!"]);
    XCTAssertTrue([self.wordReverser isLastCharSeparator:@"a."]);
    XCTAssertTrue([self.wordReverser isLastCharSeparator:@"g?"]);
    XCTAssertTrue([self.wordReverser isLastCharSeparator:@"g!a;"]);
}

- (void)testReverseWordsStripPunctuationInString {
    NSString* aString = @"This is a good problem.";
    XCTAssertEqualObjects(@"sihTsiadoogmelborp",
                          [self.wordReverser reverseWordsStripPunctuationInString:aString]);
}

- (void)testWordStopIndexWithStringWordStartIndex {
    XCTAssertEqual(0, [self.wordReverser wordStopIndexWithString:@"a" wordStartIndex:0]);
    XCTAssertEqual(0, [self.wordReverser wordStopIndexWithString:@"a." wordStartIndex:0]);
    XCTAssertEqual(2, [self.wordReverser wordStopIndexWithString:@"the cat." wordStartIndex:0]);
    XCTAssertEqual(6, [self.wordReverser wordStopIndexWithString:@"the cat." wordStartIndex:4]);
}

- (void)testWordEndIndexFromStringStartIndex {
    XCTAssertEqual(0, [self.wordReverser wordEndIndexFromString:@"a" startIndex:0]);
    XCTAssertEqual(1, [self.wordReverser wordEndIndexFromString:@"a." startIndex:0]);
    XCTAssertEqual(2, [self.wordReverser wordEndIndexFromString:@"the cat." startIndex:0]);
    XCTAssertEqual(7, [self.wordReverser wordEndIndexFromString:@"the cat." startIndex:4]);
}

- (void)testWordEndIndexFromStringStartIndexError {
    XCTAssertEqual(-1, [self.wordReverser wordEndIndexFromString:nil startIndex:0]);
    XCTAssertEqual(-1, [self.wordReverser wordEndIndexFromString:@"" startIndex:0]);
}

- (void)testWordEndIndexFromStringStartIndexSpace {
    XCTAssertEqual(0, [self.wordReverser wordEndIndexFromString:@" " startIndex:0]);
    XCTAssertEqual(3, [self.wordReverser wordEndIndexFromString:@"the cat." startIndex:3]);
}

- (void)testStringByReversingString {
    XCTAssertTrue([@"a" isEqualToString:[self.wordReverser stringByReversingString:@"a"]],
                  @"expected strings equal to string");
    XCTAssertTrue([@"cba" isEqualToString:[self.wordReverser stringByReversingString:@"abc"]]);
}

- (void)testStringByReversingStringReversesPunctuationCharacters {
    XCTAssertTrue([@"!h?g.f,e d:c;b-a"
                   isEqualToString:[self.wordReverser stringByReversingString:@"a-b;c:d e,f.g?h!"]]);
}

- (void)testStringByReversingWordsInStringLetterPunctuation {
    NSString* aString = @"a.";
    XCTAssertEqualObjects(@"a.",
                          [self.wordReverser stringByReversingWordsInString:aString]);
}

- (void)testStringByReversingWordsInStringTwoWords {
    NSString* aString = @"two words";
    XCTAssertEqualObjects(@"owt sdrow",
                          [self.wordReverser stringByReversingWordsInString:aString]);
}

- (void)testStringByReversingWordsInString {
    NSString* aString = @"This is a good problem.";
    // write test to pass current behavior
    XCTAssertEqualObjects(@"sihT si a doog melborp.",
                          [self.wordReverser stringByReversingWordsInString:aString]);
}

- (void)testStringByReversingWordsInStringMultiplePuncuations {
    NSString* aString = @"I think. Therefore- I am!";
    // write test to pass current behavior
    XCTAssertEqualObjects(@"I kniht. eroferehT- I ma!",
                          [self.wordReverser stringByReversingWordsInString:aString]);
}

- (void)testStringByReversingStringExceptEndingSeparator {
    NSString* aString = nil;
    XCTAssertNil([self.wordReverser stringByReversingStringExceptEndingSeparator:aString]);

    aString = @"";
    XCTAssertEqualObjects(@"",
                          [self.wordReverser stringByReversingStringExceptEndingSeparator:aString]);
    aString = @".";
    XCTAssertEqualObjects(@".",
                          [self.wordReverser stringByReversingStringExceptEndingSeparator:aString]);
    aString = @"m.";
    XCTAssertEqualObjects(@"m.",
                          [self.wordReverser stringByReversingStringExceptEndingSeparator:aString]);
    aString = @"you";
    XCTAssertEqualObjects(@"uoy",
                          [self.wordReverser stringByReversingStringExceptEndingSeparator:aString]);
    aString = @"you.";
    XCTAssertEqualObjects(@"uoy.",
                          [self.wordReverser stringByReversingStringExceptEndingSeparator:aString]);
    aString = @"This is a good problem.";
    XCTAssertEqualObjects(@"melborp doog a si sihT.",
                          [self.wordReverser stringByReversingStringExceptEndingSeparator:aString]);
    aString = @"I think. Therefore- I am!";
    XCTAssertEqualObjects(@"ma I -eroferehT .kniht I!",
                          [self.wordReverser stringByReversingStringExceptEndingSeparator:aString]);
}

- (void)testStringByReversingWordOrderReturnsSameString {
    NSString* aString = nil;
    XCTAssertNil([self.wordReverser stringByReversingWordOrder:aString]);

    aString = @"";
    XCTAssertEqualObjects(aString,
                          [self.wordReverser stringByReversingWordOrder:aString]);
    aString = @"m";
    XCTAssertEqualObjects(aString,
                          [self.wordReverser stringByReversingWordOrder:aString]);
    aString = @"you";
    XCTAssertEqualObjects(aString,
                          [self.wordReverser stringByReversingWordOrder:aString]);
    aString = @".";
    XCTAssertEqualObjects(aString,
                          [self.wordReverser stringByReversingWordOrder:aString]);
    aString = @"m.";
    XCTAssertEqualObjects(aString,
                          [self.wordReverser stringByReversingWordOrder:aString]);
    aString = @"you.";
    XCTAssertEqualObjects(aString,
                          [self.wordReverser stringByReversingWordOrder:aString]);
}

- (void)testStringByReversingWordOrder {
    XCTAssertEqualObjects(@"b a", [self.wordReverser
                                   stringByReversingWordOrder:@"a b"]);
    XCTAssertEqualObjects(@"problem good a is This.",
                          [self.wordReverser stringByReversingWordOrder:@"This is a good problem."]);
    XCTAssertEqualObjects(@"happy so- am I!",
                          [self.wordReverser stringByReversingWordOrder:@"I am so- happy!"]);
    XCTAssertEqualObjects(@"am I Therefore- think. I!",
                          [self.wordReverser stringByReversingWordOrder:@"I think. Therefore- I am!"]);
}

@end
