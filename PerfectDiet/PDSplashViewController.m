//
//  PDSplashViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDSplashViewController.h"
#import <Parse/Parse.h>
#import <ProgressHUD/ProgressHUD.h>
#import "PDUser.h"
#import <FacebookSDK/FacebookSDK.h>

@interface PDSplashViewController ()

@end

@implementation PDSplashViewController

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
    if ([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
    {
        
        [self dismissViewControllerAnimated:NO completion:nil];

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

- (IBAction)loginButtonPressed:(id)sender {
    
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"email", @"user_birthday", @"basic_info", @"read_friendlists"];
    
    [ProgressHUD show:@"Please wait..."];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            [ProgressHUD dismiss];
            [ProgressHUD showError:@"Login failed"];
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            
            [self saveUserFacebookDetail];
            
            
        } else {
            NSLog(@"User with facebook logged in!");
            
            [self saveUserFacebookDetail];
            
        }
    }];
}

- (void) saveUserFacebookDetail
{
    [FBRequestConnection
     startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"%@", result);
             
             NSString *facebookId = [result objectForKey:@"id"];
             NSString *avatarString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?height=160&type=normal&width=160", facebookId];
             NSString *name = [result objectForKey:@"name"];
             NSString *email = [result objectForKey:@"email"];
             
             PDUser *user = (PDUser*)[PDUser currentUser];
             
             user.email = email;
             user.avatar = avatarString;
             user.name = name;
             
             [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                 [ProgressHUD dismiss];
                 if (!error) {
                     [self dismissViewControllerAnimated:YES completion:nil];
                 } else {
                     [ProgressHUD showError:@"Error logging in"];
                     [PDUser logOut];
                 }
             }];
             
         }
     }];
}
@end
