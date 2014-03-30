//
//  PDFriendsTableViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDFriendsTableViewController.h"
#import "PDActivityDataController.h"
#import "PDFriendFeedCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <NSDate+TimeAgo/NSDate+TimeAgo.h>
#import "BBBadgeBarButtonItem.h"

@interface PDFriendsTableViewController () <PDFriendFeedCellDelegate>

@end

@implementation PDFriendsTableViewController

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
    
    UINib *reviewCell = [UINib nibWithNibName:@"PDFriendFeedCell" bundle:nil];
    UINib *reviewCellWithImage = [UINib nibWithNibName:@"PDFriendFeedCellWithImage" bundle:nil];
    UINib *reviewCellWithNote = [UINib nibWithNibName:@"PDFriendFeedCellWithNote" bundle:nil];
    UINib *reviewCellWithNoteAndImage = [UINib nibWithNibName:@"PDFriendFeedCellWithNoteAndImage" bundle:nil];
    
    [self.tableView registerNib:reviewCell forCellReuseIdentifier:@"FriendFeedCell"];
    [self.tableView registerNib:reviewCellWithImage forCellReuseIdentifier:@"FriendFeedCellWithImage"];
    [self.tableView registerNib:reviewCellWithNote forCellReuseIdentifier:@"FriendFeedCellWithNote"];
    [self.tableView registerNib:reviewCellWithNoteAndImage forCellReuseIdentifier:@"FriendFeedCellWithNoteAndImage"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.feedList = [NSArray array];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
}


-(void)messageButtonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"ReadMessage" sender:self];
}

- (void) reloadData
{
    
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [messageButton setFrame:CGRectMake(0, 0, 25, 25)];
    [messageButton setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
    BBBadgeBarButtonItem *barButtonItem = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:messageButton];
    barButtonItem.badgeValue = [NSString stringWithFormat:@"%ld", [UIApplication sharedApplication].applicationIconBadgeNumber];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    [messageButton addTarget:self action:@selector(messageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [PDActivityDataController getUserFollowFeedWithBlock:^(NSArray *feeds) {
        self.feedList = feeds;
        [self.tableView reloadData];
        if ([self.feedList count] == 0) {
            UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"review_background_feeds_blank.png"]];
            [tempImageView setFrame:self.tableView.frame];
            
            self.tableView.backgroundView = tempImageView;
        } else {
            UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"review_background.png"]];
            [tempImageView setFrame:self.tableView.frame];
            
            self.tableView.backgroundView = tempImageView;
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
    return [self.feedList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDFriendFeedCell *cell;
    
    
    PDPFActivity *item = (PDPFActivity*) [self.feedList objectAtIndex:indexPath.row];
    
    NSString *title = @"";
    
    if ((PDLogType)item.item_type == kProductivity) {
        
        NSArray *desc = [PDActivityDataController getProductivityDescription:item.work_todo withDone:item.work_done];
        
        title = (NSString*)[desc objectAtIndex:1];
        
    } else {
        
        title = item.item_name;
        
    }
    
    if ((PDLogType)item.item_type == kFood) {
        title = [@"Had " stringByAppendingString:title];
    }
    
    if ((PDLogType)item.item_type == kMood) {
        title = [@"Feeling " stringByAppendingString:title];
    }
    
    if ((PDLogType)item.item_type == kActivity) {
        
    }
    
    
    if (item.note == nil && item.photo == nil) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendFeedCell" forIndexPath:indexPath];
        
    } else if (item.note == nil) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendFeedCellWithImage" forIndexPath:indexPath];
        
        [item.photo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            [cell.photo setImage:[UIImage imageWithData:data]];
        }];
        
    } else if (item.photo == nil) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendFeedCellWithNote" forIndexPath:indexPath];
        [cell.note setText:item.note];
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"FriendFeedCellWithNoteAndImage" forIndexPath:indexPath];
        [item.photo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            [cell.photo setImage:[UIImage imageWithData:data]];
        }];
        [cell.note setText:item.note];
    }
    
    // set title label;
    [cell.title setText:title];
    
    // set time and location label
    [cell.time setText:[item.time timeAgo]];
    [cell.likeButton setTintColor:[UIColor colorWithHexString:@"#e74c3c"]];

    
    PDUser *user = item.creatorObject ;
    NSURL *url = [NSURL URLWithString:user.avatar];
    [cell.avatar setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    // set duration label
    if ((PDLogType)item.item_type == kActivity) {
        NSInteger duration = item.duration;
        NSString *ds = @"";
        if (duration < 60 * 60) {
            ds = [NSString stringWithFormat:@"%ldm", item.duration / 60];
        } else if ((duration / 60) % 60 == 0) {
            ds = [NSString stringWithFormat:@"%ldh", item.duration / 3600];
        } else {
            ds = [NSString stringWithFormat:@"%ldh%ldm", item.duration / 3600, (item.duration / 60) % 60];
        }
        
        [cell.subtitle setText:[NSString stringWithFormat:@"%@ • %@", item.location_name, ds]];
    } else {
        [cell.subtitle setText:item.location_name];
    }
    
    
    cell.delegate = self;
    cell.feedId = item.objectId;
    
    BOOL isLiked = NO;
    
    NSString *userName = [[PDUser currentUser] username];
    
    for (NSString *userId in item.likedBy) {
        if ([userId isEqualToString:userName]) {
            isLiked = YES;
            break;
        }
    }
    
    [cell setIsLiked:isLiked];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height;
    
    PDPFActivity *item = (PDPFActivity*) [self.feedList objectAtIndex:indexPath.row];
    
    if (item.photo == nil && item.note == nil) {
        height = 88.0f;
    } else if (item.photo == nil) {
        height = 218.0f;
    } else if (item.note == nil) {
        height = 234.0f;
    } else {
        height = 361.0f;
    }
    
    return height;
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

-(void)didLikeFeed:(id)likedItem forCell:(id)cell
{
    NSString *itemId = (NSString*) likedItem;
    [PDActivityDataController likePDActivityFeed:itemId WithBlock:^(NSError *error) {
        if (!error) {
            PDFriendFeedCell *ffc = cell;
            [ffc setIsLiked:YES];
            [self reloadData];
        }
    }];
    
}

@end
