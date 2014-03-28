//
//  PDActivityType.m
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDActivityType.h"
#import <Parse/PFObject+Subclass.h>

@implementation PDActivityType

@dynamic item_type;
@dynamic item_subtype;
@dynamic item_name;
@dynamic item_icon;

+(NSString *)parseClassName
{
    return @"PDActivityType";
}

@end
