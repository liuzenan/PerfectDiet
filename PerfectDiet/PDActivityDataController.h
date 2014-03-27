//
//  PDLocalDataController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDActivityDataController : NSObject

+(void)getLoggedItemsForDate:(NSDate *)date withBlock:(void(^)(NSArray *objects, NSError *error)) block;

@end
