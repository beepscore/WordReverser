//
//  WordReverserTests.m
//  WordReverserTests
//
//  Created by Steve Baker on 6/4/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "WordReverser.h"

@interface WordReverserTests : SenTestCase
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

- (void)testStringByReversingString
{
    NSString* aString = @"This is a good problem.";
    
    //    NSLog(@"reverseWordsDropPunctuationInString(%@) = %@", aString, [self reverseWordsDropPunctuationInString:aString]);
    //    NSLog(@"stringByReversingWordsInString(%@) = %@", aString, [self stringByReversingWordsInString:aString]);
    
    STAssertTrue([@"a" isEqualToString:[self.wordReverser stringByReversingString:@"a"]],
                  @"expected strings equal to string");
    STAssertTrue([@"cba" isEqualToString:[self.wordReverser stringByReversingString:@"abc"]],
                  @"expected strings equal to string");
}

@end
