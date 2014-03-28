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
+ (NSDictionary *)loadItemForItemId:(NSInteger)itemId logType:(PDLogType)logType;
+ (NSArray *)loadListForLogType: (PDLogType)logType;
+ (NSArray *)loadCategoryListForLogType: (PDLogType)logType;
+ (NSString *) getItemCategoryNameForItemId:(NSInteger)itemId logType:(PDLogType)logType;
+ (NSString *) getItemNameForItemId:(NSInteger)itemId logType:(PDLogType)logType;
+ (NSArray *) getLogTimeArray;
+ (NSArray *)getLogDurationArray;
+ (NSArray *)loadActivityTypeList;
+ (NSArray *)loadFoodTypeList;
+ (NSArray *)loadMoodTypeList;

@end
