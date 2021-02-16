//
//  VideoConverter.h
//  iina
//
//  Created by mac book on 10/14/20.
//  Copyright © 2020 lhc. All rights reserved.



@class QuickTimeOptionsWindowsController;
#import <Foundation/Foundation.h>

@interface VideoConverter: NSObject
extern NSTask *task;
+ (NSString*) runTask:(NSArray *)args :(QuickTimeOptionsWindowsController *)quicktime;
+ (NSString*) cancel_conversion:(NSArray *)args;
@end
