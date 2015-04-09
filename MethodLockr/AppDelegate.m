//
//  AppDelegate.m
//  MethodLockr
//
//  Created by Stephen Hatton on 08/04/2015.
//  Copyright (c) 2015 Stephen Hatton. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _lockr = [[MethodLockr alloc] init];
    
    [self test];
    [self anotherTest];
    
    NSLog(@"FINAL: %@", [_lockr lockedMethods]);
}

- (void)test
{
    if (![_lockr lock:func])
        return;
    
    NSLog(@"Running Test...");
    
    [_lockr unlock:func];
}

- (void)anotherTest
{
    if (![_lockr lock:func])
        return;
    
    NSLog(@"Running Another Test...");
    
    [_lockr unlock:func];
}

@end
