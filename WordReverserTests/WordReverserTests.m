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
    XCTAssertEqual(636, [punctuationArray count]);
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
    XCTAssertEqual(637, [separatorsArray count]);
    XCTAssertTrue([separatorsArray containsObject:@"-"]);
    XCTAssertTrue([separatorsArray containsObject:@";"]);
    XCTAssertTrue([separatorsArray containsObject:@":"]);
    XCTAssertTrue([separatorsArray containsObject:@"."]);
    XCTAssertTrue([separatorsArray containsObject:@","]);
    XCTAssertTrue([separatorsArray containsObject:@" "]);
}

- (void)testReverseWordsDropPunctuationInString {
    NSString* aString = @"This is a good problem.";
    XCTAssertEqualObjects(@"sihTsiadoogmelborp",
                          [self.wordReverser reverseWordsDropPunctuationInString:aString]);
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

- (void)testStringByReversingWordsInString {
    NSString* aString = @"This is a good problem.";
    // write test to pass current behavior
    XCTAssertEqualObjects(@" sihT si a doog.melborp",
                          [self.wordReverser stringByReversingWordsInString:aString]);
}

@end
