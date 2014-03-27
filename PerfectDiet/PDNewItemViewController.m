//
//  PDNewItemViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDNewItemViewController.h"

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

    switch (self.logType) {
        case kActivity:
            [self.navigationItem setTitle:@"New Activity"];
            break;
            
        case kFood:
            [self.navigationItem setTitle:@"New Food"];
            break;
            
        case kMood:
            [self.navigationItem setTitle:@"New Mood"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)doneEditing:(id)sender {
    [self.nameField endEditing:YES];
}
@end
