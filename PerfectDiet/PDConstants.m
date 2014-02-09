//
//  PDConstants.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDConstants.h"

NSInteger const LOG_BUTTON_NUM = 12;
NSString* const ACTIVITY_LIST = @"PDActivityList";
NSString* const FOOD_LIST = @"PDFoodList";
NSString* const MOOD_LIST = @"PDMoodList";
NSString* const ACTIVITY_TYPE_LIST = @"PDActivityTypeList";
NSString* const FOOD_TYPE_LIST = @"PDFoodTypeList";
NSString* const MOOD_TYPE_LIST = @"PDMoodTypeList";
NSInteger const ADD_BUTTON_ID = -1;
NSString* const STORYBOARD_NAME = @"Main_iPhone";
NSString* const COLLECTION_VIEW_CELL = @"LogScreenCell";

@implementation PDConstants

+(CGFloat)getScreenHeight
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height;
}

+(CGFloat)getScreenWidth
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.width;
}

@end
