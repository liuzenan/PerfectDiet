//
//  PDSaveLogViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDSaveLogViewController.h"
#import "PDPropertyListController.h"
#import "PDMoreItemsViewController.h"
#import "PDActivity.h"

@interface PDSaveLogViewController ()

@property (nonatomic, assign) BOOL isPickerDisplay;
@property (nonatomic, assign) PDPickerType currentType;

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
    NSLog(@"save log view did load");
        
    NSString *itemName = [PDPropertyListController getItemNameForItemId:self.itemId logType:self.logType];
    [self.itemNameButton setTitle:itemName forState:UIControlStateNormal];
    NSString *category = [PDPropertyListController getItemCategoryNameForItemId:self.itemCategory logType:self.logType];
    [self.itemType setText:category];
    
    
    self.durationList = [PDPropertyListController getLogDurationArray];
    self.timeList = [PDPropertyListController getLogTimeArray];
    
    [self setupPicker];
    [self setupPicker];
    
    [self.timePicker setTag:kPDTimePicker];
    [self.durationPicker setTag:kPDDurationPicker];
    
    [self resetPicker:self.timePicker selection:5];
    
    [self resetPicker:self.durationPicker selection:3];
    
    self.isPickerDisplay = NO;
    
}

- (void) setupPicker
{
    self.timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 180)];
    self.timePicker.dataSource = self;
    self.timePicker.delegate = self;
    self.timePicker.showsSelectionIndicator = YES;
    self.timePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.timePicker];
    
    
    self.durationPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 180)];
    self.durationPicker.dataSource = self;
    self.durationPicker.delegate = self;
    self.durationPicker.showsSelectionIndicator = YES;
    self.durationPicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.durationPicker];
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

- (void) resetPicker:(UIPickerView*)picker selection:(NSInteger)row
{
    [picker selectRow:row inComponent:0 animated:NO];
    if (picker.tag == kPDTimePicker) {
        NSNumber *number = [self.timeList objectAtIndex:row];
        NSInteger time = [number integerValue];
        self.itemTime = [NSDate dateWithTimeIntervalSinceNow: -(time * 60)];
    } else if (picker.tag == kPDDurationPicker) {
        NSNumber *number = [self.durationList objectAtIndex:row];
        NSInteger duration = [number integerValue];
        self.itemDuration = duration * 60;
    }
}

- (void)setItemId:(NSInteger)itemId itemCategory:(NSInteger)itemCategory logType:(PDLogType)logType
{
    NSLog(@"set item id in save log view");
    self.itemId = itemId;
    self.itemCategory = itemCategory;
    self.logType = logType;
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender {

    PDActivity *item = [PDActivity MR_createEntity];
    item.item_id = [NSNumber numberWithLong:self.itemId];
    item.item_type = [NSNumber numberWithLong:self.itemCategory];
    item.is_public = [NSNumber numberWithBool:self.publicSwitch.isOn];
    item.time = self.itemTime;
    item.duration = [NSNumber numberWithLong:self.itemDuration];
    item.logged_time = [NSDate new];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)itemNameButtonPressed:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    PDMoreItemsViewController *mc = (PDMoreItemsViewController*)[sb instantiateViewControllerWithIdentifier:@"MoreLog"];
    [self presentViewController:mc animated:YES completion:nil];
}

- (IBAction)itemTimeButtonPressed:(id)sender {
    self.currentType = kPDTimePicker;
    [self hideShowPickerView:self.timePicker];
}

- (IBAction)publicChanged:(id)sender {
}

- (IBAction)durationButtonPressed:(id)sender {
    self.currentType = kPDDurationPicker;
    [self hideShowPickerView:self.durationPicker];
}

- (IBAction)addMoodBtnPressed:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    PDMoreItemsViewController *mc = (PDMoreItemsViewController*)[sb instantiateViewControllerWithIdentifier:@"AddMood"];
    [self presentViewController:mc animated:YES completion:nil];
}

- (IBAction)addNoteBtnPressed:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    PDMoreItemsViewController *mc = (PDMoreItemsViewController*)[sb instantiateViewControllerWithIdentifier:@"AddNote"];
    [self presentViewController:mc animated:YES completion:nil];
}

- (IBAction)addPhotoBtnPressed:(id)sender {
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = 0;
    if (pickerView.tag == kPDTimePicker) {
        count = [self.timeList count];
    } else if (pickerView.tag == kPDDurationPicker) {
        count = [self.durationList count];
    }
    return count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSString *title = @"";
    if (pickerView.tag == kPDTimePicker) {
        title = [self titleForRowInTimePickerView:row];
    } else if (pickerView.tag == kPDDurationPicker) {
        title = [self titleForRowInDurationPickerView:row];
    }
    
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == kPDTimePicker) {
        NSNumber *number = [self.timeList objectAtIndex:row];
        NSInteger time = [number integerValue];
        self.itemTime = [NSDate dateWithTimeIntervalSinceNow: -(time * 60)];
        [self.itemTimeButton setTitle:[self titleForRowInTimePickerView:row] forState:UIControlStateNormal];
    } else if (pickerView.tag == kPDDurationPicker) {
        NSNumber *number = [self.durationList objectAtIndex:row];
        NSInteger duration = [number integerValue];
        self.itemDuration = duration * 60;
        [self.durationButton setTitle:[self titleForRowInDurationPickerView:row] forState:UIControlStateNormal];
    }
}


-(NSString*)titleForRowInTimePickerView:(NSInteger)row
{
    NSNumber *number = [self.timeList objectAtIndex:row];
    NSInteger time = [number integerValue];
    NSString *title = @"";
    if (time == 0) {
        title = @"Now";
    } else if (time == 1) {
        title = [NSString stringWithFormat:@"%ld minute ago", time];
    } else if (time < 60) {
        title = [NSString stringWithFormat:@"%ld minutes ago", time];
    } else if (time == 60) {
        title = [NSString stringWithFormat:@"%ld hour ago", time / 60];
    } else {
        title = [NSString stringWithFormat:@"%ld hours ago", time / 60];
    }
    
    return title;
}

-(NSString*)titleForRowInDurationPickerView:(NSInteger)row
{
    NSNumber *number = [self.durationList objectAtIndex:row];
    NSInteger time = [number integerValue];
    NSString *title = @"";
    
    if (time == 0) {
        title = @"Now";
    } else if (time == 1) {
        title = [NSString stringWithFormat:@"%ld minute", time];
    } else if (time < 60) {
        title = [NSString stringWithFormat:@"%ld minutes", time];
    } else if (time == 60) {
        title = [NSString stringWithFormat:@"%ld hour", time / 60];
    } else {
        title = [NSString stringWithFormat:@"%ld hours", time / 60];
    }
    
    return title;
}

-(void)hideShowPickerView:(UIPickerView*)picker
{
    if (!self.isPickerDisplay) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect temp = picker.frame;
            temp.origin.y = self.view.frame.size.height - picker.frame.size.height;
            picker.frame = temp;
        } completion:^(BOOL finished) {
            self.isPickerDisplay = YES;
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect temp = picker.frame;
            temp.origin.y = self.view.frame.size.height;
            picker.frame = temp;
        } completion:^(BOOL finished) {
            self.isPickerDisplay = NO;
        }];
    }
}

@end
