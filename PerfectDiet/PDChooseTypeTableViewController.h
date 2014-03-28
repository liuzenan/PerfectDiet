//
//  PDChooseTypeTableViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDChooseTypeDelegate

- (void) didChooseType:(NSInteger) type;

@end

@interface PDChooseTypeTableViewController : UITableViewController

@property (nonatomic, weak) id<PDChooseTypeDelegate> typeDelegate;
@property (nonatomic, strong) NSArray *typeList;

@end
