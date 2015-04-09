//
//  MethodLockr.h
//  MethodLockr
//
//  Created by Stephen Hatton on 08/04/2015.
//  Copyright (c) 2015 Stephen Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

// Returns (array): method and class
#define func @[ [NSString stringWithFormat:@"%@", [self className]], NSStringFromSelector(_cmd)]

@interface MethodLockr : NSObject

@property (nonatomic, retain) NSMutableArray *lockedMethods;

- (BOOL)lock:(NSArray *)methodAndClass;
- (void)unlock:(NSArray *)methodAndClass;

@end
