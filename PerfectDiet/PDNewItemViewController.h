//
//  PDNewItemViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDNewItemViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
- (IBAction)doneEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *typeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;

@property (assign, nonatomic) PDLogType logType;

@end
