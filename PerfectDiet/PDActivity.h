//
//  Activity.h
//  PerfectDiet
//
//  Created by Liu Zenan on 10/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PDActivity : NSManagedObject

@property (nonatomic, retain) NSNumber * is_public;
@property (nonatomic, retain) NSNumber * item_id;
@property (nonatomic, retain) NSNumber * item_type;
@property (nonatomic, retain) NSNumber * location_la;
@property (nonatomic, retain) NSNumber * location_lo;
@property (nonatomic, retain) NSString * location_name;
@property (nonatomic, retain) NSDate * logged_time;
@property (nonatomic, retain) NSNumber * mood_id;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * duration;

@end
