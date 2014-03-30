//
//  PDMessage.h
//  PerfectDiet
//
//  Created by Liu Zenan on 30/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Parse/Parse.h>
#import "PDUser.h"
#import "PDPFActivity.h"
#import "PFObject+NSCoding.h"

@interface PDMessage : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property (retain) NSString *message;
@property (retain) PDUser *from;
@property (retain) NSString *toUserName;
@property (retain) PDPFActivity *item;

@end
