//
//  PDSaveLogViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDSaveLogViewController.h"

@interface PDSaveLogViewController ()

@end

@implementation PDSaveLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setItemId:(NSInteger)itemId itemCategory:(NSInteger)itemCategory logType:(PDLogType)logType
{
    self.itemId = itemId;
    self.itemCategory = itemCategory;
    self.logType = logType;
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender {
}

- (IBAction)itemNameButtonPressed:(id)sender {
}

- (IBAction)itemTimeButtonPressed:(id)sender {
}

- (IBAction)publicChanged:(id)sender {
}

- (IBAction)durationButtonPressed:(id)sender {
}

- (IBAction)addMoodBtnPressed:(id)sender {
}

- (IBAction)addNoteBtnPressed:(id)sender {
}

- (IBAction)addPhotoBtnPressed:(id)sender {
}
@end
