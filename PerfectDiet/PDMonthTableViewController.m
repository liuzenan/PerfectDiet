//
//  PDMonthTableViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDMonthTableViewController.h"
#import "PDActivityDataController.h"
#import "PDTrendTableViewCell.h"
#import <OHAttributedLabel/NSAttributedString+Attributes.h>
#import <OHAttributedLabel/OHASBasicMarkupParser.h>

@interface PDMonthTableViewController ()

@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) CKCalendarView *calendar;
@property (nonatomic, strong) NSArray *formattedList;

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
    
    self.formattedList = [NSArray array];
    
    
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 40.0f, 0, 0)];
    
    self.currentDate = [NSDate date];
    
    [self reloadData:self.currentDate];

}

- (void) reloadData:(NSDate*) date
{

    if (![self.currentDate isEqualToDate:date]) {
        return;
    }
    
    [PDActivityDataController getMonthLoggedDates:date withBlock:^(NSDictionary *dates, NSDate *originalDate, NSError *error) {
        
        if (![self.currentDate isEqualToDate:originalDate]) {
            return;
        }
        
        [self.calendar colorLoggedDateButtons:dates];
    }];
    
    [PDActivityDataController getMonthTrendsForDate:date WithBlock:^(NSArray *trends, NSDate *originalDate, NSError *error) {
        
        
        if (![self.currentDate isEqualToDate:originalDate]) {
            return;
        }
        
        NSArray *trendList = trends;
        
        [self createFormattedString:trendList];
        
        @try {
            NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        @catch (NSException *exception) {
            
        }


    }];
}


- (void) reloadDataWithDelay:(NSDate*) date
{
    [self performSelector:@selector(reloadData:) withObject:date afterDelay:0.5f];
}

- (void) createFormattedString:(NSArray*)texts
{
    int idx = 0;
    NSMutableArray *formatted = [NSMutableArray array];
    for (NSString *text in texts) {
        NSMutableAttributedString* mas = [NSMutableAttributedString attributedStringWithString:text];
        
        if (idx == 0) {
            [mas setFont:[UIFont systemFontOfSize: 24.0f]];
        } else {
            [mas setFont:[UIFont systemFontOfSize: 15.0f]];
        }
        
       
        [mas setTextColor:[UIColor blackColor]];
        [mas setTextAlignment:kCTLeftTextAlignment lineBreakMode:kCTLineBreakByWordWrapping];
        [OHASBasicMarkupParser processMarkupInAttributedString:mas];
        
        [formatted addObject:mas];
        idx ++;
    }
    
    self.formattedList = formatted;
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

    
    
    NSDate *now = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:now];
    
    NSDateComponents *dateComponents = [cal components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
    
    [components setYear:[dateComponents year]];
    [components setMonth:[dateComponents month]];
    
    NSDate *newDate = [cal dateFromComponents:components];
    
    self.formattedList = [NSArray array];
    
    @try {
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    @catch (NSException *exception) {
        
    }
    
    self.currentDate = newDate;


    [self reloadDataWithDelay:self.currentDate];
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
    return [self.formattedList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    } else {
        return 40.0f;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarCell" forIndexPath:indexPath];
        [cell addSubview:self.calendar];
        return cell;
        
    } else {
        PDTrendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendCell" forIndexPath:indexPath];
        
        if (cell.trendTextLabel) {
            [cell.trendTextLabel removeFromSuperview];
        }
        
        CGFloat left;
        
        if (indexPath.row == 0) {
            left = 20.0f;
        } else {
            left = 40.0f;
        }
        
        NSAttributedString* attrStr = [self.formattedList objectAtIndex:indexPath.row];
        CGSize sz = [attrStr sizeConstrainedToSize:CGSizeMake(320.0f - left - 20.0f, CGFLOAT_MAX)];
        
        cell.trendTextLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(left, 20, 320.0f - left - 20.0f, sz.height)];
        cell.trendTextLabel.centerVertically = YES;
        
        [cell addSubview:cell.trendTextLabel];
        
        cell.trendTextLabel.attributedText = [self.formattedList objectAtIndex:indexPath.row];
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 350.0f;
    } else {
        NSAttributedString* attrStr = [self.formattedList objectAtIndex:indexPath.row];
        CGSize sz = [attrStr sizeConstrainedToSize:CGSizeMake(280.0f, CGFLOAT_MAX)];
        return sz.height + 2*20.0f;
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
