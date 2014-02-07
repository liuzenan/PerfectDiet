//
//  PDPropertyListController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDPropertyListController.h"

@implementation PDPropertyListController


+ (NSArray *)loadListForResource: (NSString*)resource
{
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:resource ofType:@"plist"];
    NSArray *dataList = [[NSArray alloc] initWithContentsOfFile:plistCatPath];
    return dataList;
}

+(NSArray *)loadActivityList
{
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

@end
