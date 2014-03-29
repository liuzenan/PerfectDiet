//
//  PDNewItemViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDChooseTypeTableViewController.h"

@interface PDNewItemViewController : PDBaseTableViewController <UITextFieldDelegate, PDChooseTypeDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
- (IBAction)doneEditing:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *typeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;

@property (assign, nonatomic) PDLogType logType;
@property (assign, nonatomic) NSInteger itemType;

- (IBAction)saveButtonPressed:(id)sender;

@end
