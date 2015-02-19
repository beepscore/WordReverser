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

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.wordReverser = [[WordReverser alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testReverseWordsDropPunctuationInString
{
    NSString* aString = @"This is a good problem.";
    XCTAssertEqualObjects(@"sihTsiadoogmelborp", [self.wordReverser reverseWordsDropPunctuationInString:aString],
                  @"expected strings equal to string");
}

- (void)testStringByReversingString
{
    XCTAssertTrue([@"a" isEqualToString:[self.wordReverser stringByReversingString:@"a"]],
                  @"expected strings equal to string");
    XCTAssertTrue([@"cba" isEqualToString:[self.wordReverser stringByReversingString:@"abc"]],
                  @"expected strings equal to string");
}

- (void)testStringByReversingWordsInString
{
    NSString* aString = @"This is a good problem.";
    
    // write test to pass current behavior
    XCTAssertEqualObjects(@" sihT si a doog.melborp", [self.wordReverser stringByReversingWordsInString:aString],
                  @"expected strings equal to string");
}

@end
