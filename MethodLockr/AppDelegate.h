//
//  AppDelegate.h
//  MethodLockr
//
//  Created by Stephen Hatton on 08/04/2015.
//  Copyright (c) 2015 Stephen Hatton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Method Lockr/MethodLockr.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) MethodLockr *lockr;

@end
