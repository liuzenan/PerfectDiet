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
#import "GHWalkThroughView.h"

@interface PDSplashViewController () <GHWalkThroughViewDataSource, GHWalkThroughViewDelegate>
@property (strong, nonatomic) GHWalkThroughView *page;
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
    
    
    _page = [[GHWalkThroughView alloc] initWithFrame:self.view.bounds];
    
    [_page setDataSource:self];
    [_page setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
    
    [_page showInView:self.navigationController.view animateDuration:0.3];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"Welcome to LifeLogger";
    title.font = [UIFont systemFontOfSize:22.0f];
    title.textColor = [UIColor whiteColor];
    [_page setFloatingHeaderView:title];
    
}

-(NSInteger)numberOfPages
{
    return 4;
}

-(void)configurePage:(GHWalkThroughPageCell *)cell atIndex:(NSInteger)index
{

    switch (index) {
        case 0:
            cell.title = @"Activity logging";
            cell.desc = @"LifeLogger is an app aims to make you form better life habits.";
            break;
        case 1:
            cell.title = @"Log your daily activities";
            cell.desc = @"Logging with LifeLogger is simple and fun.";
            break;
        case 2:
            cell.title = @"Know yourself better";
            cell.desc = @"You can learn about insights and trends of your daily activities, moods, diet and productivity";
            break;
        case 3:
            cell.title = @"Follow your friends";
            cell.desc = @"Get support and be motivated by your friends.";
            break;
        default:
            break;
    }
    
    cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"intro%ld.png", index]];
    
    cell.imgPositionY = 30.0f;
    cell.titlePositionY = 160.0f;
    cell.descPositionY = 140.0f;
}

-(UIImage *)bgImageforPage:(NSInteger)index
{
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"splash%ld.png", index + 1]];
    return img;
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
             
             [[PFInstallation currentInstallation] setObject:[PDUser currentUser] forKey:@"user"];
             [[PFInstallation currentInstallation] saveEventually];
             
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
