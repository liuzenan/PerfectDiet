//
//  PDTodayTableViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 11/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDTodayTableViewController.h"
#import "PDActivityDataController.h"
#import "PDTodayTopTableViewCell.h"
#import "PDReviewCell.h"
#import "PDPropertyListController.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>
#import <THLabel/THLabel.h>
#import "PDPFActivity.h"

@interface PDTodayTableViewController ()

@end

@implementation PDTodayTableViewController

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
    
    self.logItems = [NSArray new];
    [PDActivityDataController getLoggedItemsForDate:[NSDate new] withBlock:^(NSArray *objects, NSError *error) {
        self.logItems = objects;
        [self.tableView reloadData];
    }];
    
    UINib *reviewCell = [UINib nibWithNibName:@"PDReviewCell" bundle:nil];
    UINib *reviewCellWithImage = [UINib nibWithNibName:@"PDReviewCellWithImage" bundle:nil];
    UINib *reviewCellWithNote = [UINib nibWithNibName:@"PDReviewCellWithNote" bundle:nil];
    UINib *reviewCellWithNoteAndImage = [UINib nibWithNibName:@"PDReviewCellWithNoteAndImage" bundle:nil];
    
    [self.tableView registerNib:reviewCell forCellReuseIdentifier:@"ReviewCell"];
    [self.tableView registerNib:reviewCellWithImage forCellReuseIdentifier:@"ReviewCellWithImage"];
    [self.tableView registerNib:reviewCellWithNote forCellReuseIdentifier:@"ReviewCellWithNote"];
    [self.tableView registerNib:reviewCellWithNoteAndImage forCellReuseIdentifier:@"ReviewCellWithNoteAndImage"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    [containerView setAutoresizesSubviews:YES];
    
    THLabel *date = [[THLabel alloc] initWithFrame:CGRectMake(30, 80, 260, 40)];
    [date setShadowBlur:4.0f];
    [date setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [date setShadowColor:[UIColor blackColor]];
    [date setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"EEEE, d MMMM"];
    
    [date setText:[formatter stringFromDate:[NSDate new]]];
    [date setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [date setTextColor:[UIColor whiteColor]];
    
    
    THLabel *stats = [[THLabel alloc] initWithFrame:CGRectMake(30, 110, 260, 40)];
    [stats setText:@"2 Activities, 5 Moods, 2 Food"];
    [stats setFont:[UIFont systemFontOfSize:14.0f]];
    [stats setTextColor:[UIColor whiteColor]];
    [stats setShadowBlur:4.0f];
    [stats setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [stats setShadowColor:[UIColor blackColor]];
    [stats setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];

    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ParallaxImage.jpg"]];
    [imageView setFrame:containerView.frame];
    [imageView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [containerView addSubview:imageView];
    [containerView insertSubview:date aboveSubview:imageView];
    [containerView insertSubview:stats aboveSubview:imageView];
    
    [self.tableView addParallaxWithView:containerView andHeight:160.0f];
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"review_background.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PDActivityDataController getLoggedItemsForDate:[NSDate new] withBlock:^(NSArray *objects, NSError *error) {
        self.logItems = objects;
        [self.tableView reloadData];
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

    return [self.logItems count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    

    PDReviewCell *cell;
    
    PDPFActivity *item = (PDPFActivity*) [self.logItems objectAtIndex:indexPath.row];
    
    NSString *title = @"";
    if ((PDLogType)item.item_type == kProductivity) {
        title = @"Productivity";
    } else {
        title = [PDPropertyListController getItemNameForItemId:item.item_id logType:(PDLogType)item.item_type];
    }
    
    if ((PDLogType)item.item_type == kFood) {
        title = [@"Had " stringByAppendingString:title];
    }
        
    if ((PDLogType)item.item_type == kMood) {
        title = [@"Feel " stringByAppendingString:title];
    }
    
    if ((PDLogType)item.item_type == kActivity) {
        
    }
    

    
    if (item.note == nil && item.photo == nil) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
        
    } else if (item.note == nil) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCellWithImage" forIndexPath:indexPath];
        
        [item.photo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            [cell.photo setImage:[UIImage imageWithData:data]];
        }];
        
    } else if (item.photo == nil) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCellWithNote" forIndexPath:indexPath];
        [cell.note setText:item.note];
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCellWithNoteAndImage" forIndexPath:indexPath];
        [item.photo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            [cell.photo setImage:[UIImage imageWithData:data]];
        }];
        [cell.note setText:item.note];
    }
    
    // set title label;
    [cell.itemTitle setText:title];
    
    // set time and location label
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    [cell.time setText:[format stringFromDate:item.time]];
    [cell.location setText:item.location_name];
        
    
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
            
        [cell.duration setText:ds];
    } else {
        [cell.duration setText:@""];
    }
    
    
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    PDPFActivity *item = (PDPFActivity*) [self.logItems objectAtIndex:indexPath.row];
    
    if (item.photo == nil && item.note == nil) {
        height = 76.0;
    } else if (item.photo == nil) {
        height = 208.0;
    } else if (item.note == nil) {
        height = 223.0;
    } else {
        height = 343.0;
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

@end
