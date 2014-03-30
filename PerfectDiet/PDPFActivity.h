//
//  PDPFActivity.h
//  PerfectDiet
//
//  Created by Liu Zenan on 27/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Parse/Parse.h>
#import "PDActivityType.h"
#import "PDUser.h"
#import "PFObject+NSCoding.h"

@interface PDPFActivity : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property BOOL is_public;
@property NSInteger item_type;
@property (retain) NSString * location_name;
@property (retain) NSDate * logged_time;
@property (retain) NSString *note;
@property (retain) PFFile * photo;
@property (retain) NSDate * time;
@property NSInteger duration;
@property NSInteger work_todo;
@property NSInteger work_done;
@property (retain) NSString *creator;
@property (retain) PDActivityType *item_activity_type;
@property (retain) NSString *item_name;
@property NSInteger item_subtype;
@property (retain) NSString *item_icon;
@property (retain) PDUser *creatorObject;
@property (retain) NSArray *likedBy;

@end
