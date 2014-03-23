//
//  PDTodayTableViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 11/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDTodayTableViewController.h"
#import "PDLocalDataController.h"
#import "PDTodayTopTableViewCell.h"
#import "PDActivity.h"
#import "PDReviewCell.h"
#import "PDPropertyListController.h"

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
    
    self.logItems = [PDLocalDataController getLoggedItemsForDate:[NSDate new]];
    UINib *reviewCell = [UINib nibWithNibName:@"PDReviewCell" bundle:nil];
    [self.tableView registerNib:reviewCell forCellReuseIdentifier:@"ReviewCell"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.logItems = [PDLocalDataController getLoggedItemsForDate:[NSDate new]];
    [self.tableView reloadData];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSInteger numOfRow = 0;
    
    if (section == kTopSection) {
        numOfRow = 1;
    } else if (section == kLogSection){
        numOfRow = [self.logItems count];
    }
    
    return  numOfRow;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == kTopSection) {
        PDTodayTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodayTopCell" forIndexPath:indexPath];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"EEEE, d MMMM"];
        
        [cell.date setText: [[format stringFromDate:[NSDate new]] capitalizedString]];
        
        return cell;
    } else {

        PDReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
        
        PDActivity *item = (PDActivity*) [self.logItems objectAtIndex:indexPath.row];
        
        NSString *title = [PDPropertyListController getItemNameForItemId:item.item_id.integerValue logType:(PDLogType)item.item_type.integerValue];
        
        if ((PDLogType)item.item_type.integerValue == kFood) {
            title = [@"Had " stringByAppendingString:title];
        }
        
        if ((PDLogType)item.item_type.integerValue == kMood) {
            title = [@"Feel " stringByAppendingString:title];
        }
        
        [cell.itemTitle setText:title];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"HH:mm"];
        [cell.time setText:[format stringFromDate:item.time]];
        
        if (item.duration != nil) {
            NSInteger duration = item.duration.integerValue;
            NSString *ds = @"";
            if (duration < 60 * 60) {
                ds = [NSString stringWithFormat:@"%ldm", item.duration.integerValue / 60];
            } else if ((duration / 60) % 60 == 0) {
                ds = [NSString stringWithFormat:@"%ldh", item.duration.integerValue / 3600];
            } else {
                ds = [NSString stringWithFormat:@"%ldh%ldm", item.duration.integerValue / 3600, (item.duration.integerValue / 60) % 60];
            }
            
            [cell.duration setText:ds];
        }
        
        return cell;
    }


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
