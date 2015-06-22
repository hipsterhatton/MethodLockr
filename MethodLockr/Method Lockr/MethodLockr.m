//
//  MethodLockr.m
//  MethodLockr
//
//  Created by Stephen Hatton on 08/04/2015.
//  Copyright (c) 2015 Stephen Hatton. All rights reserved.
//

#import "MethodLockr.h"

int const kFOUND_CLASS =    0;
int const kFOUND_METHOD =   1;

@implementation MethodLockr



#pragma mark - Lock/Unlock Methods

- (BOOL)lock:(NSArray *)methodAndClass
{
    if (!_lockedMethods) {
        _lockedMethods = [[NSMutableArray alloc] init];
    }
    
    NSArray *results = [self _checkForExisting:methodAndClass];
    
    if ([results[kFOUND_CLASS] intValue] > -1) {
        if ([results[kFOUND_METHOD] intValue] == -1) {
            
            //NSLog(@"CLASS FOUND: Method: %@ || Class: %@", methodAndClass[0], methodAndClass[1]);
            [_lockedMethods[[results[kFOUND_CLASS] intValue]][@"Methods"] addObject:methodAndClass[1]];
            return true;
        }
        
    } else {
        
        //NSLog(@"NO CLASS: Method: %@ || Class: %@", methodAndClass[0], methodAndClass[1]);
        
        [_lockedMethods addObject:[[NSMutableDictionary alloc]
                                   initWithDictionary:@{
                                                        @"Class"   : methodAndClass[0],
                                                        @"Methods" : [[NSMutableArray alloc] initWithObjects:methodAndClass[1], nil]
                                                        }]];
        return true;
    }
    
    return false;
}

- (void)unlock:(NSArray *)methodAndClass
{
    NSArray *results = [self _checkForExisting:methodAndClass];
    
    if ([results[kFOUND_CLASS] intValue] > -1 && [results[kFOUND_METHOD] intValue] > -1) {
        
        if ([_lockedMethods[[results[kFOUND_CLASS] intValue]][@"Methods"] count] == 1) {
            [_lockedMethods removeObjectAtIndex:[results[kFOUND_CLASS] intValue]];
            //NSLog(@"REMOVE CLASS: Method: %@ || Class: %@", methodAndClass[0], methodAndClass[1]);
        } else {
            [_lockedMethods[[results[kFOUND_CLASS] intValue]][@"Methods"]
             removeObjectAtIndex:[results[kFOUND_METHOD] intValue]];
            //NSLog(@"REMOVE METHOD: Method: %@ || Class: %@", methodAndClass[0], methodAndClass[1]);
        }
    }
}

/*
 
// This method requires the RXPromise library...
 
- (void)cancel:(RXPromise *)promise
{
    NSLog(@"CANCELLING...");
    [promise cancelWithReason:@"Manual Cancel..."];
    promise = nil;
    NSLog(@"...CANCELLED");
}
*/



#pragma mark - Check Data (Private) Method

- (NSArray *)_checkForExisting:(NSArray *)methodAndClass
{
    int foundClass = -1;
    int foundMethod = -1;
    
    //NSLog(@"Checking...");
    
    if ([_lockedMethods count] == 0) {
        return @[ @(foundClass), @(foundMethod) ];
    }
    
    for (int a = 0; a < [_lockedMethods count]; a++) {
        
        if ([_lockedMethods[a][@"Class"] isEqualToString:methodAndClass[0]]) {
            
            foundClass = a;
            
            for (int b = 0; b < [_lockedMethods[a][@"Methods"] count]; b++) {
                
                if ([_lockedMethods[a][@"Methods"][b] isEqualToString:methodAndClass[1]]) {
                    
                    foundMethod = b;
                    
                }
            }
            
        }
    }
    
    return @[
             @(foundClass),
             @(foundMethod)
             ];
}

@end
