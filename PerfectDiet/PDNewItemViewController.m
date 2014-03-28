//
//  PDNewItemViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDNewItemViewController.h"
#import "PDPropertyListController.h"
#import "PDActivityType.h"

@interface PDNewItemViewController ()

@end

@implementation PDNewItemViewController

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

    self.nameField.delegate = self;
    switch (self.logType) {
        case kActivity:
            [self.navigationItem setTitle:@"New Activity"];
            [self.itemName setText:@"Activity Name"];
            break;
            
        case kFood:
            [self.navigationItem setTitle:@"New Food"];
            [self.itemName setText:@"Food Name"];
            break;
            
        case kMood:
            [self.navigationItem setTitle:@"New Mood"];
            [self.itemName setText:@"Mood Name"];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self.nameField resignFirstResponder];
    
    if ([segue.identifier isEqualToString:@"ChooseType"]) {
        PDChooseTypeTableViewController *ct = (PDChooseTypeTableViewController*) [segue destinationViewController];
        ct.typeDelegate = self;
        NSArray *typeList = [NSArray new];
        switch (self.logType) {
            case kActivity:
                typeList = [PDPropertyListController loadActivityTypeList];
                break;
                
            case kFood:
                typeList = [PDPropertyListController loadFoodTypeList];
                break;
                
            case kMood:
                typeList = [PDPropertyListController loadMoodTypeList];
                break;
                
            default:
                break;
        }
        ct.typeList = typeList;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)doneEditing:(id)sender {
    NSLog(@"done editing");
    [self.nameField resignFirstResponder];
}
- (IBAction)saveButtonPressed:(id)sender {
    if ([self.nameField.text isEqualToString: @""]) {
        [ProgressHUD showError:[NSString stringWithFormat:@"%@ not set", self.itemName.text]];
        return;
    }
    if ([self.typeCell.detailTextLabel.text isEqualToString:@"Not Set"]) {
        [ProgressHUD showError:@"Type not set"];
        return;
    }
    
    PDActivityType *type = [PDActivityType object];
    type.item_type = self.logType;
    type.item_name = self.nameField.text;
    type.item_subtype = self.itemType;
    
    [ProgressHUD show:@"Saving..."];
    [type saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [ProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)didChooseType:(NSInteger)type
{
    self.itemType = type;
    [self.typeCell.detailTextLabel setText:[PDPropertyListController getItemCategoryNameForItemId:self.itemType logType:self.logType]];
    
}
@end
