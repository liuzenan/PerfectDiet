//
//  PDMessagesTableViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDMessagesTableViewController.h"
#import "PDMessage.h"
#import "PDMessageCell.h"
#import "PDActivityDataController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <NSDate+TimeAgo/NSDate+TimeAgo.h>

@interface PDMessagesTableViewController () <PDAddFriendCellDelegate>

@property (nonatomic, strong) NSArray* messageList;

@end

@implementation PDMessagesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.messageList = [NSArray array];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    PFInstallation *installation = [PFInstallation currentInstallation];
    installation.badge = 0;
    [installation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadData
{
    [PDActivityDataController getMessagesWithBlock:^(NSArray *messages, NSError *error) {
        if (!error) {
            
            @try {
                [[PDUser currentUser] refreshInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                    if (!error) {
                        
                        self.messageList = messages;
                        [self.tableView reloadData];
                    }
                }];
            }
            @catch (NSException *exception) {
            }
            @finally {
            }

        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    // Configure the cell...
    PDMessage *msg = [self.messageList objectAtIndex:indexPath.row];
    PDUser *from = msg.from;
    NSString *msgText = msg.message;
    
    NSURL *avatar = [NSURL URLWithString:from.avatar];
    
    [cell setMessageText:msgText];
    [cell.avatar setImageWithURL:avatar placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    [cell.time setText:[msg.createdAt timeAgo]];
    
    cell.userName = from.username;
    
    NSString *userId = [from username];
    
    PDUser *current = [PDUser currentUser];
    NSArray *followings = current.following;
    
    BOOL isFollowing = NO;
    
    NSLog(@"following:%@", followings);
    
    for (NSString *following in followings) {
        if ([userId isEqualToString:following]) {
            isFollowing = YES;
            break;
        }
    }
    
    [cell setIsFollowed:isFollowing];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddFriend:(NSString *)userName forCell:(id)cell
{
    [PDActivityDataController followUser:userName WithBlock:^(NSError *error) {
        if (!error) {
            PDMessageCell *mc = (PDMessageCell*)cell;
            [mc setIsFollowed:YES];
            [self reloadData];
        }
    }];
}
@end
