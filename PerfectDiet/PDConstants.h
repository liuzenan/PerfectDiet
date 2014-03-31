//
//  PDConstants.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSInteger const LOG_BUTTON_NUM;
extern NSString* const ACTIVITY_LIST;
extern NSString* const FOOD_LIST;
extern NSString* const MOOD_LIST;
extern NSString* const ACTIVITY_TYPE_LIST;
extern NSString* const FOOD_TYPE_LIST;
extern NSString* const MOOD_TYPE_LIST;
extern NSInteger const ADD_BUTTON_ID;
extern NSString* const STORYBOARD_NAME;
extern NSString* const COLLECTION_VIEW_CELL;
extern NSString* const BACKGROUND_COLOR;
extern NSString* const NAVIGATION_BAR_COLOR;

typedef enum{
    kActivity = 0,
    kFood = 1,
    kMood = 2,
    kProductivity = 3,
    kPDLogTypeCount = 4
} PDLogType;

@interface PDConstants : NSObject

+ (CGFloat) getScreenHeight;
+ (CGFloat) getScreenWidth;

@end
