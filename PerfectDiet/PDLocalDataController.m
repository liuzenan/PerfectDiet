//
//  PDLocalDataController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDLocalDataController.h"
#import "PDActivity.h"

@implementation PDLocalDataController

+(NSArray *)getLoggedItemsForDate:(NSDate *)date
{
    
    NSDate *startDate = [PDLocalDataController begginingOfDay:date];
    NSDate *endDate = [PDLocalDataController endOfDay:date];
    NSPredicate *dateRange = [NSPredicate predicateWithFormat:@"(time >= %@) AND (time <= %@)", startDate, endDate];
    NSArray *result = [PDActivity MR_findAllWithPredicate:dateRange];
    return result;
}


+(NSDate *)begginingOfDay:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];

    
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [cal dateFromComponents:components];
    
}

+(NSDate *)endOfDay:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];

    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [cal dateFromComponents:components];
    
}

@end
