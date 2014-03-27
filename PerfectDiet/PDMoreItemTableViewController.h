//
//  PDMoreItemTableViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDMoreItemTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
- (IBAction)cancelButtonPressed:(id)sender;

@property (assign, nonatomic) PDLogType logType;

@end
