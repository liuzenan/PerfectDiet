//
//  PDSaveProductivityLogViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDSaveProductivityDelegate

- (void) didSaveProductivity;

@end

@interface PDSaveProductivityLogViewController : UIViewController
@property (weak, nonatomic) id<PDSaveProductivityDelegate> delegate;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *work_todo;
@property (weak, nonatomic) IBOutlet UISlider *work_done;
@property (weak, nonatomic) IBOutlet UISwitch *publicSwitch;

@end
