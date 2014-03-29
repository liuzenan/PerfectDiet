//
//  PDFollow.h
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Parse/Parse.h>

@interface PDFollow : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property (retain) NSString *userId;
@property (retain) NSArray *following;

@end
