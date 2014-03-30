//
//  PDMessage.m
//  PerfectDiet
//
//  Created by Liu Zenan on 30/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDMessage.h"
#import <Parse/PFObject+Subclass.h>

@implementation PDMessage

@dynamic item;
@dynamic from;
@dynamic message;
@dynamic toUserName;

+(NSString *)parseClassName
{
    return @"PDMessage";
}
@end
