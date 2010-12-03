//
//  WordReverserAppDelegate.m
//  WordReverser
//
//  Created by Steve Baker on 12/3/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "WordReverserAppDelegate.h"

@implementation WordReverserAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    NSString* aString = @"This is a good problem.";
    NSString* wordString = @"a";
    
    NSLog(@"stringByReversingString(%@) = %@", wordString, [self stringByReversingString:wordString]);
    NSLog(@"reverseWordsDropPunctuationInString(%@) = %@", aString, [self reverseWordsDropPunctuationInString:aString]);
    NSLog(@"stringByReversingWordsInString(%@) = %@", aString, [self stringByReversingWordsInString:aString]);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


- (NSString*)stringByReversingString:(NSString *)aString
{
    if (0 == [aString length])
    {
        return aString;
    }
    
    NSString *tempCharacter1, *tempCharacter2;
    NSRange myRange1, myRange2;
    NSMutableString *myMutableString = [[[NSMutableString alloc] initWithString:aString] autorelease];
    
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
    NSMutableString *myMutableString = [[[NSMutableString alloc] initWithString:aString] autorelease];
    
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
