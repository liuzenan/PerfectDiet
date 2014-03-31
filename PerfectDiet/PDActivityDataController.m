//
//  PDLocalDataController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDActivityDataController.h"
#import "PDUser.h"
#import "PFCloud+Cache.h"

@implementation PDActivityDataController


+(void) getMonthTrendsForDate:(NSDate*) date WithBlock:(void(^)(NSArray* trends, NSError *error)) block
{
    
    [PFCloud callFunctionInBackground:@"fetchTrendsForMonth"
                       withParameters:@{@"date":date}
                          cachePolicy:kPFCachePolicyCacheThenNetwork
                                block:^(PFObject *object, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", object);
                                        
                                        PFObject *thisMonth = [object objectForKey:@"thisMonth"];
                                        
                                        id ns = [object objectForKey:@"ns"];
                                        id ps = [object objectForKey:@"ps"];
                                        
                                        id ec = [object objectForKey:@"ec"];
                                        id wc = [object objectForKey:@"wc"];
                                        
                                        id rc = [object objectForKey:@"rc"];
                                        
                                        id vc = [object objectForKey:@"vc"];
                                        
                                        id pc = [object objectForKey:@"pc"];
                                        
                                        NSLog(@"pc: %@", pc);
                                        
                                        NSMutableArray *array = [NSMutableArray array];
                                        
                                        
                                        // exercise
                                        
                                        if (ec) {
                                            @try {
                                                CGFloat temp = [ec floatValue];
                                                
                                                if (temp > 0.1) {
                                                    [array addObject:[NSString stringWithFormat:@"Your exercise time increased by {#ee0c58|%ld%%} compared to last month.", (NSInteger)[ns floatValue] * 100]];
                                                } else if (temp < -0.1){
                                                    [array addObject:[NSString stringWithFormat:@"Your exercise time decreased by {#ee0c58|%ld%%} compared to last month.", (NSInteger)[ns floatValue] * 100]];
                                                } else {
                                                    [array addObject:@"Your exercise time is about the same as last month."];
                                                }
                                            }
                                            @catch (NSException *exception) {
                                                
                                            }
                                            
                                        }
                                        
                                        
                                        // mood
                                        
                                        @try {
                                            if (ns) {
                                                [array addObject:[NSString stringWithFormat:@"You feel negative {#ee0c58|%ld%%} of the time.", (NSInteger)([ns floatValue] * 100)]];
                                            }
                                        }
                                        @catch (NSException *exception) {
                                            
                                        }

                                        @try {
                                            if (ps) {
                                                [array addObject:[NSString stringWithFormat:@"You feel positive {#ee0c58|%ld%%} of the time.", (NSInteger)([ps floatValue] * 100)]];
                                            }
                                        }
                                        @catch (NSException *exception) {
                                            
                                        }

                                        
                                        // work

                                        
                                        if (wc) {
                                            
                                            @try {
                                                CGFloat temp = [wc floatValue];
                                                
                                                if (temp > 0.1) {
                                                    [array addObject:[NSString stringWithFormat:@"Your work {#ee0c58|%ld%%} more time compared to last month.", (NSInteger)[wc floatValue] * 100]];
                                                } else if (temp < -0.1){
                                                    [array addObject:[NSString stringWithFormat:@"Your work {#ee0c58|%ld%%} less time compared to last month.", (NSInteger)[wc floatValue] * 100]];
                                                } else {
                                                    [array addObject:@"Your work time is about the same as last month."];
                                                }
                                            }
                                            @catch (NSException *exception) {
                                                
                                            }


                                        }
                                        
                                        // rest
                                        
                                        if (rc) {
                                            
                                            @try {
                                                CGFloat temp = [rc floatValue];
                                                
                                                if (temp > 0.1) {
                                                    [array addObject:[NSString stringWithFormat:@"Your are resting more this month."]];
                                                } else if (temp < -0.1){
                                                    [array addObject:[NSString stringWithFormat:@"Your are resting less this month."]];
                                                }
                                            }
                                            @catch (NSException *exception) {
                                                
                                            }
                                            
                                        }
                                        
                                        // vegetable
                                        
                                        if (vc) {
                                            
                                            @try {
                                                CGFloat temp = [vc floatValue];
                                                
                                                if (temp > 0.1) {
                                                    [array addObject:[NSString stringWithFormat:@"Now you eat more vegetable or fruit."]];
                                                } else if (temp < -0.1){
                                                    [array addObject:[NSString stringWithFormat:@"Now you eat less vegetable and fruit."]];
                                                }
                                            }
                                            @catch (NSException *exception) {
                                                
                                            }

                                            
                                        }
                                        
                                        // productivity
                                        
                                        if (pc) {
                                            
                                            @try {
                                                
                                                CGFloat temp = [pc floatValue];
                                                
                                                if (temp > 1.0f) {
                                                    [array addObject:[NSString stringWithFormat:@"You are more productive this month."]];
                                                } else if (temp < 1.0f){
                                                    [array addObject:[NSString stringWithFormat:@"You are less productive this month."]];
                                                } else {
                                                    [array addObject:[NSString stringWithFormat:@"Your productivity level is the same as last month."]];
                                                }
                                            }
                                            @catch (NSException *exception) {
                                                
                                            }

                                        }
                                        
                                        
                                        
                                        if (thisMonth) {
                                            id activity = [thisMonth objectForKey:@"0"];
                                            id mood = [thisMonth objectForKey:@"2"];
                                            id productivity = [thisMonth objectForKey:@"3"];
                                            id pDays = [object objectForKey:@"daysWithProductivity"];
                                            
                                            
                                            // exercise
                                            
                                            id exercise = [activity objectForKey:@"0"];
                                            id positive = [mood objectForKey:@"0"];
                                            id workDone = [productivity objectForKey:@"work_done"];
                                            
                                            @try {
                                                if (exercise) {
                                                    [array addObject:[NSString stringWithFormat:@"You total exercised {#ee0c58|%ld} hours in the past 30 days.", [exercise integerValue] / 3600]];
                                                }
                                            }
                                            @catch (NSException *exception) {
                                                
                                            }

                                            
                                            @try {
                                                if (positive) {
                                                    [array addObject:[NSString stringWithFormat:@"You felt positive {#ee0c58|%ld} times in the past 30 days.", [positive integerValue]]];
                                                }
                                            }
                                            @catch (NSException *exception) {
                                                
                                            }

                                            
                                            
                                            @try {
                                                if (workDone && pDays) {
                                                    [array addObject:[NSString stringWithFormat:@"You finished {#ee0c58|%ld%%} of your work on average.", [workDone integerValue] / [pDays integerValue]]];
                                                }
                                            }
                                            @catch (NSException *exception) {
                                                
                                            }

                                            

                                        }
                                        
                                        
                                        block(array, error);

                                    } else {
                                        NSLog(@"%@", error);
                                    }
    }];
}

+ (void) getMessagesWithBlock:(void(^)(NSArray* messages, NSError *error)) block
{
    
    [PFCloud callFunctionInBackground:@"fetchMessages"
                       withParameters:@{}
                          cachePolicy:kPFCachePolicyNetworkElseCache
                                block:^(NSArray *msgs, NSError *error) {
        NSLog(@"%@", error);
        block(msgs, error);
    }];
    
}

+ (void) testFollow:(NSString*) user WithBlock:(void(^)(NSError *error)) block
{
    [PFCloud callFunctionInBackground:@"testFollow"
                       withParameters:@{@"targetUser": user}
                                block:^(id object, NSError *error) {
                                    NSLog(@"%@",error);
                                    block(error);
                                }];
}

+ (void) followUser:(NSString*) user WithBlock:(void(^)(NSError *error)) block
{
    [PFCloud callFunctionInBackground:@"followUser"
                       withParameters:@{@"targetUser": user}
                                block:^(id object, NSError *error) {
        NSLog(@"%@",error);
        block(error);
    }];
}

+ (void) likePDActivityFeed:(NSString*) fId  WithBlock:(void(^)(NSError *error)) block
{
    [PFCloud callFunctionInBackground:@"likeFeed"
                       withParameters:@{@"feedId" : fId}
                                block:^(PFObject *object, NSError *error) {
        block(error);
    }];
}


+ (void) getUserFollowFeedWithBlock:(void(^)(NSArray *feeds)) block
{
    [PFCloud callFunctionInBackground:@"fetchFollowedFeeds"
                       withParameters:@{}
                          cachePolicy:kPFCachePolicyCacheThenNetwork
                                block:^(PFObject *object, NSError *error) {
        if (!error) {
            NSArray *array = [object objectForKey:@"feed"];
            block(array);
        } else {
            NSLog(@"%@", error);
        }
    }];
}

+ (void) getAllActiveUsersWithBlock:(void(^)(NSArray *users, NSError *error)) block
{

    [PFCloud callFunctionInBackground:@"fetchActiveUsers"
                       withParameters:@{}
                          cachePolicy:kPFCachePolicyNetworkElseCache
                                block:^(NSArray *objects, NSError *error) {
        block(objects, error);
    }];
    
}

+ (void) getMonthLoggedDates:(NSDate*)date withBlock:(void(^)(NSDictionary *dates, NSError *error)) block
{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date]; // Get necessary date components
    
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    
    
    NSDictionary *params = @{@"creator": [[PFUser currentUser] username],
                             @"startTime" : [PDActivityDataController begginingOfDay:firstDayOfMonthDate],
                             @"endTime" : [PDActivityDataController endOfDay:tDateMonth]};
    
    
    [PFCloud callFunctionInBackground:@"fetchLogsForDuration"
                       withParameters:params
                          cachePolicy:kPFCachePolicyCacheThenNetwork block:^(NSArray *objects, NSError *error) {
                              
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

+ (NSArray*) getProductivityDescription:(NSInteger) todo withDone:(NSInteger)done
{
    NSMutableArray *desc = [NSMutableArray arrayWithCapacity:2];

    if (todo >66) {
        [desc addObject:@"You had lots of work to do."];
    } else if (todo > 33) {
        [desc addObject:@"Average workload."];
    } else {
        [desc addObject:@"Not much work today."];
    }
    
    if (done > 70) {
        [desc addObject:@"Feeling productive"];
    } else if (done > 50) {
        [desc addObject:@"Average productivity"];
    } else {
        [desc addObject:@"Not productive"];
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
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        block(objects, error);
    }];
    
}

+(void)getLoggedItemsForDate:(NSDate *)date withBlock:(void(^)(NSArray *objects, NSError *error)) block
{
    
    NSDictionary *params = @{@"creator": [[PDUser currentUser] username],
                             @"startTime": [PDActivityDataController begginingOfDay:date],
                             @"endTime":[PDActivityDataController endOfDay:date]};
    
    [PFCloud callFunctionInBackground:@"fetchLogsForDuration"
                       withParameters:params
                          cachePolicy:kPFCachePolicyCacheThenNetwork
                                block:^(NSArray *objects, NSError *error) {
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
