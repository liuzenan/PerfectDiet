//
//  PDTodayTableViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 11/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDPFActivity.h"
#import "PDSaveProductivityLogViewController.h"

@interface PDTodayTableViewController : UITableViewController <PDSaveProductivityDelegate>

@property (nonatomic, strong) NSMutableArray* logItems;
@property (nonatomic, strong) PDPFActivity *productivity;
@property (nonatomic, strong) NSDate *reviewDate;

@end
