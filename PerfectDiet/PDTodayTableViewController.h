//
//  PDTodayTableViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 11/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    kTopSection = 0,
    kLogSection = 1
} PDTodayTableSection;

@interface PDTodayTableViewController : UITableViewController

@property (nonatomic, strong) NSArray* logItems;

@end
