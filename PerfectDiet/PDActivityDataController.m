//
//  PDLocalDataController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDActivityDataController.h"


@implementation PDActivityDataController



+ (void) getAllActiveUsersWithBlock:(void(^)(NSArray *users, NSError *error)) block
{
    PFQuery *query = [PFUser query];
    
}

+ (void) getMonthLoggedDates:(NSDate*)date withBlock:(void(^)(NSDictionary *dates, NSError *error)) block
{
    PFQuery *query = [PDPFActivity query];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date]; // Get necessary date components
    
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:1];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    
    [query whereKey:@"time" greaterThanOrEqualTo:[PDActivityDataController begginingOfDay:firstDayOfMonthDate]];
    [query whereKey:@"time" lessThan:[PDActivityDataController endOfDay:tDateMonth]];
    [query whereKey:@"creator" equalTo:[[PFUser currentUser] username]];
    [query orderByAscending:@"time"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSCalendar* calendar = [NSCalendar currentCalendar];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        for (PDPFActivity *item in objects) {
            NSDate *itemDate = item.time;
            NSDateComponents* comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:itemDate];
            
            NSUInteger day = [comps day];
            NSString *dayString = [NSString stringWithFormat:@"%lu", day];
            
            if ([dict valueForKey:dayString] == nil) {
                [dict setObject:[NSNumber numberWithBool:YES] forKey:dayString];
            }
            
        }
        
        block(dict, error);
        
    }];
}

+ (NSString*) getProductivityDescription:(NSInteger) todo withDone:(NSInteger)done
{
    NSString * desc = @"";

    if (todo >66) {
        desc = @"Lots of work today";
    } else if (todo > 33) {
        desc = @"Some work to do";
    } else {
        desc = @"Not much to do";
    }
    
    return desc;
}

+ (void) getItemType:(NSString*)typeId withBlock:(void(^)(PDActivityType *object, NSError *error)) block
{
    PFQuery *query = [PDActivityType query];
    [query whereKey:@"objectId" equalTo:typeId];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        block((PDActivityType*)object, error);
    }];
}

+ (void) getItemTypeList:(PDLogType)type withBlock:(void(^)(NSArray *objects, NSError *error)) block
{
    PFQuery *query = [PDActivityType query];
    [query whereKey:@"item_type" equalTo:[NSNumber numberWithInt:type]];
    [query orderByAscending:@"item_name"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        block(objects, error);
    }];
    
}

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
