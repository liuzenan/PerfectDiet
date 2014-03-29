//
//  PDUser.h
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Parse/PFUser.h>

@interface PDUser : PFUser<PFSubclassing>

@property (retain) NSString *avatar;
@property (retain) NSString *name;
@property (retain) NSArray *following;

@end
