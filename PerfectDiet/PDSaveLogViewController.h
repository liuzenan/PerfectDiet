//
//  PDSaveLogViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VPPLocation/VPPLocationController.h>
#import <Parse/Parse.h>
#import "PDAddMoodViewController.h"
#import "PDAddNoteViewController.h"
#import "PDMoreItemTableViewController.h"
#import "PDPFActivity.h"

@interface PDSaveLogViewController : UIViewController <VPPLocationControllerGeocoderDelegate, VPPLocationControllerLocationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AddMoodDelegate, AddNoteDelegate>

@property (weak, nonatomic) IBOutlet UIButton *itemNameButton;
@property (weak, nonatomic) IBOutlet UILabel *itemType;
@property (weak, nonatomic) IBOutlet UILabel *timeQuestionLabel;
@property (weak, nonatomic) IBOutlet UIButton *itemTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UISwitch *publicSwitch;
@property (weak, nonatomic) IBOutlet UILabel *durationQuestionLabel;
@property (weak, nonatomic) IBOutlet UIButton *durationButton;
@property (weak, nonatomic) IBOutlet UIButton *addMoodBtn;
@property (weak, nonatomic) IBOutlet UIButton *addNoteButton;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;

@property (strong, nonatomic) NSArray *timeList;
@property (strong, nonatomic) NSArray *durationList;

@property (strong, nonatomic) PDActivityType *itemActivityType;
@property (assign, nonatomic) NSInteger itemCategory;
@property (assign, nonatomic) PDLogType logType;
@property (assign, nonatomic) BOOL isPublic;
@property (strong, nonatomic) NSDate *itemTime;
@property (assign, nonatomic) NSInteger itemDuration;
@property (strong, nonatomic) NSString *note;
@property (strong, nonatomic) PDPFActivity *mood;
@property (strong, nonatomic) NSData *imageData;


- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)itemNameButtonPressed:(id)sender;
- (IBAction)itemTimeButtonPressed:(id)sender;
- (IBAction)publicChanged:(id)sender;
- (IBAction)durationButtonPressed:(id)sender;
- (IBAction)addMoodBtnPressed:(id)sender;
- (IBAction)addNoteBtnPressed:(id)sender;
- (IBAction)addPhotoBtnPressed:(id)sender;

- (void) setItemObjectId:(PDActivityType*)itemType;

@end
