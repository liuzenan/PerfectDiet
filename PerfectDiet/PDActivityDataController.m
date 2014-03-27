//
//  PDLocalDataController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDActivityDataController.h"
#import "PDPFActivity.h"

@implementation PDActivityDataController

+(void)getLoggedItemsForDate:(NSDate *)date withBlock:(void(^)(NSArray *objects, NSError *error)) block
{
    
    PFQuery *query = [PDPFActivity query];
    [query whereKey:@"time" greaterThanOrEqualTo:[PDActivityDataController begginingOfDay:date]];
    [query whereKey:@"time" lessThanOrEqualTo:[PDActivityDataController endOfDay:date]];
    [query whereKey:@"creator" equalTo:[[PFUser currentUser] username]];
    [query orderByAscending:@"time"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        block(objects, error);
    }];
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
