//
//  PDSaveProductivityLogViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDSaveProductivityLogViewController.h"
#import "PDPFActivity.h"

@interface PDSaveProductivityLogViewController ()

@end

@implementation PDSaveProductivityLogViewController

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
    [self.work_todo setMaximumValue:100.0f];
    [self.work_todo setMinimumValue:0.0f];
    [self.work_todo setValue:50.0f];
    
    [self.work_done setMaximumValue:100.0f];
    [self.work_done setMinimumValue:0.0f];
    [self.work_done setValue:50.0f];
    
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

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    [ProgressHUD show:@"Saving"];
    
    NSInteger workTodo = (NSInteger)self.work_todo.value;
    NSInteger workDone = (NSInteger)self.work_done.value;
    
    PDPFActivity *item = [PDPFActivity object];
    item.is_public = self.publicSwitch.isOn;
    item.item_type = kProductivity;
    item.time = [NSDate new];
    item.logged_time = [NSDate new];
    item.work_done = workDone;
    item.work_todo = workTodo;
    item.creator = [[PDUser currentUser] username];
    item.creatorObject = [PDUser currentUser];
    item.likedBy = @[];
    
    
    [item saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        [ProgressHUD dismiss];
     
        if (!error) {
            [self.delegate didSaveProductivity];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    

    
}
@end
