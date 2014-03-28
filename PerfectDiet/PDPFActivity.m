//
//  PDPFActivity.m
//  PerfectDiet
//
//  Created by Liu Zenan on 27/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDPFActivity.h"
#import <Parse/PFObject+Subclass.h>

@implementation PDPFActivity

@dynamic is_public;
@dynamic item_type;
@dynamic location_name;
@dynamic logged_time;
@dynamic note;
@dynamic photo;
@dynamic time;
@dynamic duration;
@dynamic work_done;
@dynamic work_todo;
@dynamic creator;
@dynamic item_activity_type;
@dynamic item_name;
@dynamic item_icon;
@dynamic item_subtype;

+(NSString *)parseClassName
{
    return @"PDPFActivity";
}

@end
