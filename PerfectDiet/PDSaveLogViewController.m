//
//  PDSaveLogViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDSaveLogViewController.h"
#import "PDPropertyListController.h"
#import <MMPickerView.h>
#import <TBImagePickerController/TBImagePickerController.h>
#import <ProgressHUD/ProgressHUD.h>
#import <BYLBadgeView/BYLBadgeView.h>

@interface PDSaveLogViewController() {
    TBImagePickerController *imageController;
    UIStoryboard *sb;
    UINavigationController *mcam;
    UINavigationController *mcan;
}

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
    
    imageController = [[TBImagePickerController alloc] init];
    imageController.delegate = self;
    sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    
    mcam = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"AddMood"];
    PDAddMoodViewController *am = (PDAddMoodViewController*)mcam.topViewController;
    am.delegate = self;
    
    mcan = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"AddNote"];
    PDAddNoteViewController *an = (PDAddNoteViewController*)mcan.topViewController;
    an.delegate = self;
    
    NSString *itemName = [PDPropertyListController getItemNameForItemId:self.itemId logType:self.logType];
    [self.itemNameButton setTitle:itemName forState:UIControlStateNormal];
    NSString *category = [PDPropertyListController getItemCategoryNameForItemId:self.itemCategory logType:self.logType];
    [self.itemType setText:category];
    [self.view setBackgroundColor:[UIColor colorWithHexString:BACKGROUND_COLOR]];
    
    self.durationList = [PDPropertyListController getLogDurationArray];
    self.timeList = [PDPropertyListController getLogTimeArray];
    
    [[VPPLocationController sharedInstance] addLocationDelegate:self];
    [[VPPLocationController sharedInstance] addGeocoderDelegate:self];
    
    [[BYLBadgeView appearanceWhenContainedIn:[UIButton class], nil] setBadgeBackgroundColor:[UIColor blackColor]];
    [[BYLBadgeView appearanceWhenContainedIn:[UIButton class], nil] setBadgeTextColor:[UIColor whiteColor]];
    [[BYLBadgeView appearanceWhenContainedIn:[UIButton class], nil] setBadgeRadius:10.0f];
    NSDictionary *titleAttributes = @{NSFontAttributeName: [UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline] size:10.0f]};
    [[BYLBadgeView appearanceWhenContainedIn:[UIButton class], nil] setBadgeTextAttributes:titleAttributes];
    
}


-(void)addMood:(PDPFActivity *)mood
{
    
    if (!self.mood) {
        BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:1];
        badgeView.translatesAutoresizingMaskIntoConstraints = NO;
        badgeView.opaque = NO;
        badgeView.layer.zPosition = 10;

        [self.addMoodBtn addSubview:badgeView]; // Created from IB
        [self.addMoodBtn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[badgeView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
        [self.addMoodBtn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[badgeView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
    }
    
    self.mood = mood;

}

-(void)addNote:(NSString *)note
{
    if (!self.note) {
        BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:1];
        badgeView.translatesAutoresizingMaskIntoConstraints = NO;
        badgeView.opaque = NO;
        badgeView.layer.zPosition = 10;
        
        [self.addNoteButton addSubview:badgeView]; // Created from IB
        [self.addNoteButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[badgeView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
        [self.addNoteButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[badgeView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
    }
    self.note = note;
}

- (void)addPhotoBadge
{
    if (!self.imageData) {
        BYLBadgeView *badgeView = [[BYLBadgeView alloc] initWithBadge:1];
        badgeView.translatesAutoresizingMaskIntoConstraints = NO;
        badgeView.opaque = NO;
        badgeView.layer.zPosition = 10;
        
        [self.addPhotoButton addSubview:badgeView]; // Created from IB
        [self.addPhotoButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[badgeView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
        [self.addPhotoButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[badgeView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(badgeView)]];
    }
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

    if (!self.itemTime) {
        self.itemTime = [NSDate dateWithTimeIntervalSinceNow: - (2 * 60 * 60)];
    }
    
    if (!self.itemDuration && self.logType == kActivity) {
        self.itemDuration = 60 * 60;
    }
    
    PDPFActivity *item = [PDPFActivity object];
    item.item_id = self.itemId;
    item.item_type = self.logType;
    item.is_public = self.publicSwitch.isOn;
    item.time = self.itemTime;
    item.location_name = self.locationLabel.text;
    item.duration = self.itemDuration;
    item.logged_time = [NSDate new];
    item.creator = [[PFUser currentUser] username];
    if (self.note) {
        item.note = self.note;
    }
    
    if (self.mood) {
        self.mood.is_public = self.publicSwitch.isOn;
        self.mood.time = self.itemTime;
        self.mood.location_name = self.locationLabel.text;
        self.mood.logged_time = item.logged_time;
    }
    
    if (self.imageData) {
        item.photo = [PFFile fileWithData:self.imageData];
        [item.photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                item.photo = nil;
            }
            [item saveEventually];
        }];
    } else {
        [item saveEventually];
    }
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)itemNameButtonPressed:(id)sender {
    
    PDMoreItemTableViewController *mc = (PDMoreItemTableViewController*)[sb instantiateViewControllerWithIdentifier:@"MoreLog"];
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
    [ProgressHUD show:@"Please wait..."];

    [self presentViewController:mcam animated:YES completion:^{
        [ProgressHUD dismiss];
    }];
    
}

- (IBAction)addNoteBtnPressed:(id)sender {
    [ProgressHUD show:@"Please wait..."];
    
    [self presentViewController:mcan animated:YES completion:^{
        [ProgressHUD dismiss];
    }];
}

- (IBAction)addPhotoBtnPressed:(id)sender {
    [ProgressHUD show:@"Please wait..."];
    
    [self presentViewController:imageController animated:YES completion:^{
        [ProgressHUD dismiss];
        [self addPhotoBadge];
    }];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    self.imageData = imageData;
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
