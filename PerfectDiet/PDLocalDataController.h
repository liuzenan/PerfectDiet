//
//  PDLocalDataController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDLocalDataController : NSObject

+ (NSArray*) getLoggedItemsForDate:(NSDate*)date;

@end
