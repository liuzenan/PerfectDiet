//
//  PDSaveLogViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDSaveLogViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *itemNameButton;
@property (weak, nonatomic) IBOutlet UILabel *itemType;
@property (weak, nonatomic) IBOutlet UILabel *timeQuestionLabel;
@property (weak, nonatomic) IBOutlet UIButton *itemTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UISwitch *publicSwitch;
@property (weak, nonatomic) IBOutlet UILabel *durationQuestionLabel;
@property (weak, nonatomic) IBOutlet UIButton *durationButton;

@property (assign, nonatomic) NSInteger itemId;
@property (assign, nonatomic) NSInteger itemCategory;
@property (assign, nonatomic) PDLogType logType;


- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)itemNameButtonPressed:(id)sender;
- (IBAction)itemTimeButtonPressed:(id)sender;
- (IBAction)publicChanged:(id)sender;
- (IBAction)durationButtonPressed:(id)sender;
- (IBAction)addMoodBtnPressed:(id)sender;
- (IBAction)addNoteBtnPressed:(id)sender;
- (IBAction)addPhotoBtnPressed:(id)sender;

- (void) setItemId:(NSInteger)itemId itemCategory:(NSInteger)itemCategory logType:(PDLogType)logType;

@end
