//
//  PDLogObject.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDLogObject : NSObject

@property (nonatomic, strong) NSDate *time_logged;
@property (nonatomic, strong) NSDate *time_synced;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger *objectID;
@property (nonatomic, assign) PDLogType logObjectType;
@property (nonatomic, assign) BOOL isPublic;

@end
