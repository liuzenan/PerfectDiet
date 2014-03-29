//
//  PDAddFriendsViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 8/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDAddFriendsViewController.h"
#import "PDFindFriendTableViewCell.h"
#import "PDActivityDataController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "PDUser.h"

@interface PDAddFriendsViewController () <PDAddFriendCellDelegate>

@end

@implementation PDAddFriendsViewController

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
    self.userList = [NSArray array];
    
    [PDActivityDataController getAllActiveUsersWithBlock:^(NSArray *users, NSError *error) {
        if (!error) {
            self.userList = users;
            [self.tableView reloadData];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.userList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddFriendCell";
    PDFindFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    PDUser *user = [self.userList objectAtIndex: indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:user.avatar];
    [cell.profileImage setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    [cell.name setText:user.name];
    cell.userId = user.objectId;
    cell.delegate = self;
    
    NSString *userId = user.objectId;
    
    PDUser *current = [PDUser currentUser];
    NSArray *followings = current.following;
    
    BOOL isFollowing = NO;
    
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddFriend:(NSString *)userId forCell:(id)cell
{
    PDFindFriendTableViewCell *ffCell = (PDFindFriendTableViewCell*)cell;
    PDUser *me = [PDUser currentUser];
    NSArray *fo = me.following;
    NSMutableArray *array = [NSMutableArray array];
    if (fo) {
       array = [NSMutableArray arrayWithArray:fo];
    }
    
    BOOL exists = NO;
    for (NSString *user  in array) {
        if ([user isEqualToString:userId]) {
            exists = YES;
            break;
        }
    }
    if (!exists) {
        [array addObject:userId];
        me.following = array;
        [me saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [ffCell setIsFollowed:YES];
            [self.tableView reloadData];
        }];
    }
    
}

@end
