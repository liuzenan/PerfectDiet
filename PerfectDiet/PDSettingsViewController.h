//
//  PDSettingsViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 8/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDSettingsDelegate

- (void) didLogout;

@end

@interface PDSettingsViewController : PDBaseTableViewController

@property (nonatomic, weak) id<PDSettingsDelegate> delegate;
- (IBAction)doneButtonPressed:(id)sender;

@end
