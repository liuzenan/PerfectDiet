//
//  PDPropertyListController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDPropertyListController.h"

@implementation PDPropertyListController

+(NSArray *)getLogTimeArray
{
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"PDTimeList" ofType:@"plist"];
    NSArray *dataList = [[NSArray alloc] initWithContentsOfFile:plistCatPath];
    return dataList;
}

+(NSArray *)getLogDurationArray
{
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"PDDurationList" ofType:@"plist"];
    NSArray *dataList = [[NSArray alloc] initWithContentsOfFile:plistCatPath];
    return dataList;
}

+ (NSArray *)loadListForResource: (NSString*)resource
{
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"plist"];
    NSArray *dataList = [[NSArray alloc] initWithContentsOfFile:plistCatPath];
    return dataList;
}

+ (NSString *) getItemNameForItemId:(NSInteger)itemId logType:(PDLogType)logType
{
    NSDictionary *dict = [PDPropertyListController loadItemForItemId:itemId logType:logType];
    return dict[@"Name"];
}

+ (NSString *) getItemCategoryNameForItemId:(NSInteger)itemId logType:(PDLogType)logType
{
    if (itemId < 0) {
        return @"";
    }
    
    NSArray *list = [PDPropertyListController loadCategoryListForLogType:logType];
    NSString *name = (NSString*)list[itemId];
    return name;
}

+ (NSDictionary *)loadItemForItemId:(NSInteger)itemId logType:(PDLogType)logType
{
    if (itemId < 0) {
        return [NSDictionary new];
    }
    
    NSArray *itemList = [PDPropertyListController loadListForLogType:logType];
    NSDictionary *dict = (NSDictionary*)itemList[itemId];
    return dict;
}

+ (NSArray *)loadListForLogType: (PDLogType)logType
{
    NSArray *array = [NSArray new];
    switch (logType) {
        case kActivity:
            array = [PDPropertyListController loadActivityList];
            break;
        case kFood:
            array = [PDPropertyListController loadFoodList];
            break;
        case kMood:
            array = [PDPropertyListController loadMoodList];
            break;
        default:
            break;
    }
    
    return array;
}


+ (NSArray *)loadCategoryListForLogType: (PDLogType)logType
{
    NSArray *array = [NSArray new];
    switch (logType) {
        case kActivity:
            array = [PDPropertyListController loadActivityTypeList];
            break;
        case kFood:
            array = [PDPropertyListController loadFoodTypeList];
            break;
        case kMood:
            array = [PDPropertyListController loadMoodTypeList];
            break;
        default:
            break;
    }
    
    return array;
}

+(NSArray *)loadActivityList
{
    NSLog(@"%@", [PDPropertyListController loadListForResource:ACTIVITY_LIST]);
    return [PDPropertyListController loadListForResource:ACTIVITY_LIST];
}


+(NSArray *)loadFoodList
{
    return [PDPropertyListController loadListForResource:FOOD_LIST];
}


+(NSArray *)loadMoodList
{
    return [PDPropertyListController loadListForResource:MOOD_LIST];
}

+(NSArray *)loadActivityTypeList
{
    return [PDPropertyListController loadListForResource:ACTIVITY_TYPE_LIST];
}


+(NSArray *)loadFoodTypeList
{
    return [PDPropertyListController loadListForResource:FOOD_TYPE_LIST];
}


+(NSArray *)loadMoodTypeList
{
    return [PDPropertyListController loadListForResource:MOOD_TYPE_LIST];
}

@end
