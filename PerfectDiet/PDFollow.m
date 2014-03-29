//
//  PDFollow.m
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDFollow.h"
#import <Parse/PFObject+Subclass.h>

@implementation PDFollow

@dynamic userId;
@dynamic following;

+(NSString *)parseClassName
{
    return @"PDFollow";
}


@end
