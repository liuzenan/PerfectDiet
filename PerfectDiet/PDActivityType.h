//
//  PDActivityType.h
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Parse/Parse.h>
#import "PFObject+NSCoding.h"

@interface PDActivityType : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property NSInteger item_type;
@property NSInteger item_subtype;
@property (retain) NSString *item_name;
@property (retain) NSString *item_icon;

@end
