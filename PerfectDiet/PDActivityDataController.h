//
//  PDLocalDataController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDPFActivity.h"
#import "PDActivityType.h"

@interface PDActivityDataController : NSObject

+ (void) getItemType:(NSString*)typeId withBlock:(void(^)(PDActivityType *object, NSError *error)) block;
+ (void) getItemTypeList:(PDLogType)type withBlock:(void(^)(NSArray *objects, NSError *error)) block;
+(void)getLoggedItemsForDate:(NSDate *)date withBlock:(void(^)(NSArray *objects, NSError *error)) block;
+ (NSString*) getProductivityDescription:(NSInteger) todo withDone:(NSInteger)done;
+ (void) getMonthLoggedDates:(NSDate*)date withBlock:(void(^)(NSDictionary *dates, NSError *error)) block;

@end
