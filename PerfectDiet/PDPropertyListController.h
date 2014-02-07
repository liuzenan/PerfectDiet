//
//  PDPropertyListController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDPropertyListController : NSObject

+ (NSArray*) loadActivityList;
+ (NSArray*) loadFoodList;
+ (NSArray*) loadMoodList;

@end
