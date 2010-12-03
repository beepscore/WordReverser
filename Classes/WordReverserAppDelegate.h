//
//  WordReverserAppDelegate.h
//  WordReverser
//
//  Created by Steve Baker on 12/3/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordReverserAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (NSString *)stringByReversingString:(NSString *)aString;
- (NSString *)reverseWordsDropPunctuationInString:(NSString *)aString;
- (NSString *)stringByReversingWordsInString:(NSString *)aString;

@end

