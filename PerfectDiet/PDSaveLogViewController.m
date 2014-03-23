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
#import <MMPickerView.h>

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
    
    NSString *itemName = [PDPropertyListController getItemNameForItemId:self.itemId logType:self.logType];
    [self.itemNameButton setTitle:itemName forState:UIControlStateNormal];
    NSString *category = [PDPropertyListController getItemCategoryNameForItemId:self.itemCategory logType:self.logType];
    [self.itemType setText:category];
    
    
    self.durationList = [PDPropertyListController getLogDurationArray];
    self.timeList = [PDPropertyListController getLogTimeArray];
    
    [[VPPLocationController sharedInstance] addLocationDelegate:self];
    [[VPPLocationController sharedInstance] addGeocoderDelegate:self];

    
}


-(void)geocoderError:(NSError *)error
{
    [self.locationLabel setText:@"Unknown location"];
}

-(void)geocoderUpdate:(MKPlacemark *)placemark
{
    [self.locationLabel setText: [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.administrativeArea]];
}

-(void)locationDenied
{
    
}

-(void)locationError:(NSError *)error
{
    
}

-(void)locationUpdate:(CLLocation *)location
{
    
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
    item.item_type = [NSNumber numberWithInteger:self.logType];
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
    [MMPickerView showPickerViewInView:self.view withObjects:self.timeList withOptions:nil objectToStringConverter:^NSString *(id object) {
        return [self titleForTimeObject:object];
    } completion:^(id selectedObject) {
        if (![selectedObject isKindOfClass:[NSNumber class]]) {
            return;
        }
        NSLog(@"%@", [self titleForTimeObject:selectedObject]);
        [self.itemTimeButton setTitle:[self titleForTimeObject:selectedObject] forState:UIControlStateNormal];
        self.itemTime = [NSDate dateWithTimeIntervalSinceNow: - ([selectedObject integerValue] * 60)];
    }];
    
}


- (IBAction)durationButtonPressed:(id)sender {
    [MMPickerView showPickerViewInView:self.view withObjects:self.durationList withOptions:nil objectToStringConverter:^NSString *(id object) {
        return [self titleForDurationObject:object];
    } completion:^(id selectedObject) {
        if (![selectedObject isKindOfClass:[NSNumber class]]) {
            return;
        }
        NSLog(@"%@", [self titleForDurationObject:selectedObject]);
        [self.durationButton setTitle:[self titleForDurationObject:selectedObject] forState:UIControlStateNormal];
        self.itemDuration = [selectedObject integerValue] * 60;
    }];
}

- (IBAction)publicChanged:(id)sender {
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


-(NSString*)titleForTimeObject:(NSNumber*) number {
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


-(NSString*)titleForDurationObject:(NSNumber*) number {
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

@end
