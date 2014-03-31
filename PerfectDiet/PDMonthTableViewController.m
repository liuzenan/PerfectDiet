//
//  PDMonthTableViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDMonthTableViewController.h"
#import "PDActivityDataController.h"

@interface PDMonthTableViewController ()

@property (nonatomic, strong) CKCalendarView *calendar;

@end

@implementation PDMonthTableViewController

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
    
    self.calendar = [[CKCalendarView alloc] init];
    
    self.calendar.delegate = self;
    
    [PDActivityDataController getMonthLoggedDates:[NSDate date] withBlock:^(NSDictionary *dates, NSError *error) {
        [self.calendar colorLoggedDateButtons:dates];
    }];
    
    [PDActivityDataController getMonthTrendsForDate:[NSDate date] WithBlock:^(NSArray *trends, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Calendar delegates

-(void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    if (date == nil) {
        return;
    }
    
    if ([date compare:[NSDate date]] == NSOrderedDescending) {
        return;
    }
    
    NSLog(@"did select date:%@", date);
    
    [self.delegate didSelectDate:date];
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)calendar:(CKCalendarView *)calendar didChangeToMonth:(NSDate *)date
{
    [PDActivityDataController getMonthLoggedDates:date withBlock:^(NSDictionary *dates, NSError *error) {
        [self.calendar colorLoggedDateButtons:dates];
    }];
}


-(BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date
{
    return YES;
}

-(BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date
{
    return YES;
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
    if (section==0) {
        return 1;
    }
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarCell" forIndexPath:indexPath];
        [cell addSubview:self.calendar];
        return cell;
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TrendCell" forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 350.0f;
    } else {
        return 44.0f;
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Trends";
    } else {
        return nil;
    }
}

- (IBAction)TodayPressed:(id)sender {
    [self.delegate didSelectDate:[NSDate date]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
