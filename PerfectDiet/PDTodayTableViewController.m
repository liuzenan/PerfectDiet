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

#import "PDProductivityTableViewCell.h"
#import "PDMonthTableViewController.h"

@interface PDTodayTableViewController ()<PDDaySelectDelegate>{
    THLabel *date;
    NSDateFormatter *formatter;
    UIImageView *imageView;
}

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
    
    
    if (self.reviewDate == nil) {
        self.reviewDate = [NSDate date];
    }
    
    self.logItems = [NSMutableArray array];
    
    UINib *reviewCell = [UINib nibWithNibName:@"PDReviewCell" bundle:nil];
    UINib *reviewCellWithImage = [UINib nibWithNibName:@"PDReviewCellWithImage" bundle:nil];
    UINib *reviewCellWithNote = [UINib nibWithNibName:@"PDReviewCellWithNote" bundle:nil];
    UINib *reviewCellWithNoteAndImage = [UINib nibWithNibName:@"PDReviewCellWithNoteAndImage" bundle:nil];
    UINib *productivityCell = [UINib nibWithNibName:@"PDProductivityCell" bundle:nil];
    
    [self.tableView registerNib:reviewCell forCellReuseIdentifier:@"ReviewCell"];
    [self.tableView registerNib:reviewCellWithImage forCellReuseIdentifier:@"ReviewCellWithImage"];
    [self.tableView registerNib:reviewCellWithNote forCellReuseIdentifier:@"ReviewCellWithNote"];
    [self.tableView registerNib:reviewCellWithNoteAndImage forCellReuseIdentifier:@"ReviewCellWithNoteAndImage"];
    [self.tableView registerNib:productivityCell forCellReuseIdentifier:@"ProductivityCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    [containerView setAutoresizesSubviews:YES];
    
    date = [[THLabel alloc] initWithFrame:CGRectMake(30, 80, 260, 40)];
    [date setShadowBlur:4.0f];
    [date setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [date setShadowColor:[UIColor blackColor]];
    [date setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    
    formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    [formatter setDateFormat:@" EEEE, d MMMM"];
    
    [date setText:[formatter stringFromDate:self.reviewDate]];
    [date setFont:[UIFont boldSystemFontOfSize:24.0f]];
    [date setTextColor:[UIColor whiteColor]];
    
    
    THLabel *stats = [[THLabel alloc] initWithFrame:CGRectMake(30, 110, 260, 40)];
    [stats setText:@"  2 Activities, 5 Moods, 2 Food"];
    [stats setFont:[UIFont systemFontOfSize:14.0f]];
    [stats setTextColor:[UIColor whiteColor]];
    [stats setShadowBlur:4.0f];
    [stats setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [stats setShadowColor:[UIColor blackColor]];
    [stats setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.reviewDate];
    
    NSString *dayString =  [NSString stringWithFormat:@"%02lu", [comp day]];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"ParallaxImage%@.jpg", dayString]]];
    [imageView setFrame:containerView.frame];
    [imageView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [containerView addSubview:imageView];
    [containerView insertSubview:date aboveSubview:imageView];
    [containerView insertSubview:stats aboveSubview:imageView];
    
    
    
    [self.tableView addParallaxWithView:containerView andHeight:160.0f];
    
    
}


- (void) findProductivity
{
    for (NSInteger i = 0; i < [self.logItems count]; i++) {
        PDPFActivity *item = [self.logItems objectAtIndex:i];
        if (item.item_type == kProductivity) {
            self.productivity = item;
            [self.logItems removeObjectAtIndex:i];
            i--;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadDate];

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

    if (section == 0) {
        return 1;
    } else {
        return [self.logItems count];
    }
}

- (void) reloadDate
{
    self.productivity = nil;
    self.logItems = [NSMutableArray array];
    [self.tableView reloadData];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.reviewDate];
    
    NSString *dayString =  [NSString stringWithFormat:@"%02lu", [comp day]];
    
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ParallaxImage%@.jpg", dayString]]];
    
    [PDActivityDataController getLoggedItemsForDate:self.reviewDate withBlock:^(NSArray *objects, NSError *error) {
        self.logItems = [NSMutableArray arrayWithArray:objects];
        [self findProductivity];
        [self.tableView reloadData];
        
        if ([self.logItems count] == 0) {
            UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"review_background_blank.png"]];
            [tempImageView setFrame:self.tableView.frame];
            
            self.tableView.backgroundView = tempImageView;
        } else {
            UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"review_background.png"]];
            [tempImageView setFrame:self.tableView.frame];
            
            self.tableView.backgroundView = tempImageView;
        }

    }];
    
    [date setText:[formatter stringFromDate:self.reviewDate]];
    
    NSUInteger dayOfYear =
    [gregorian ordinalityOfUnit:NSDayCalendarUnit
                         inUnit:NSYearCalendarUnit forDate:[NSDate date]];
    
    NSUInteger year = [gregorian ordinalityOfUnit:NSYearCalendarUnit
                                           inUnit:NSYearCalendarUnit forDate:[NSDate date]];
    
    NSUInteger rdayOfYear =
    [gregorian ordinalityOfUnit:NSDayCalendarUnit
                         inUnit:NSYearCalendarUnit forDate:self.reviewDate];
    
    NSUInteger ryear = [gregorian ordinalityOfUnit:NSYearCalendarUnit
                                           inUnit:NSYearCalendarUnit forDate:self.reviewDate];
    
    if (year == ryear && dayOfYear == rdayOfYear) {
        [self.navigationItem setTitle:@"Today"];
    } else {
        NSDateFormatter *shortFormatter = [[NSDateFormatter alloc] init];
        NSLocale *locale = [NSLocale currentLocale];
        [shortFormatter setLocale:locale];
        [shortFormatter setDateFormat:@"d MMMM"];
        
        [self.navigationItem setTitle:[shortFormatter stringFromDate:self.reviewDate]];
    }
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.section == 0) {
        PDProductivityTableViewCell *pdc = [tableView dequeueReusableCellWithIdentifier:@"ProductivityCell" forIndexPath:indexPath];
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"p_background.png"]];
        pdc.contentView.backgroundColor = background;
        
        if (self.productivity) {
            [pdc.progressView setProgress:((CGFloat) self.productivity.work_done) / 100.0f];
            [pdc.progressValue setText:[NSString stringWithFormat:@"%ld", self.productivity.work_done]];
            NSArray *desc = [PDActivityDataController getProductivityDescription:self.productivity.work_todo withDone:self.productivity.work_done];
            [pdc.productivityLabel setText:(NSString*)[desc objectAtIndex:1]];
            [pdc.subtitle setText:(NSString*) [desc objectAtIndex:0]];
        } else {
            
            if ([self.navigationItem.title isEqualToString:@"Today"]) {
                [pdc.progressView setProgress:0.0f];
                [pdc.progressValue setText:[NSString stringWithFormat:@"%d", 0]];
                [pdc.subtitle setText:@"Tap to log today's productivity"];
                [pdc.productivityLabel setText:@"Productivity not logged"];
            } else {
                [pdc.progressView setProgress:0.0f];
                [pdc.progressValue setText:[NSString stringWithFormat:@"%d", 0]];
                [pdc.productivityLabel setText:@"Productivity not logged"];
                [pdc.subtitle setText:@"You cannot log for previous days"];
            }

        }
        
        return pdc;
    }
    
    
    PDReviewCell *cell;
    
    PDPFActivity *item = (PDPFActivity*) [self.logItems objectAtIndex:indexPath.row];
    NSString *title = @"";
    
    if ((PDLogType)item.item_type == kProductivity) {
        title = @"Productivity";
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected: %@", self.productivity);
    if (indexPath.section == 0 && self.productivity == nil && [self.navigationItem.title isEqualToString:@"Today"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
        PDSaveProductivityLogViewController *spl = (PDSaveProductivityLogViewController*)[sb instantiateViewControllerWithIdentifier:@"SaveProductivityLog"];
        spl.delegate = self;
        [self presentViewController:spl animated:YES completion:^{
            [ProgressHUD dismiss];
        }];
    } else if(indexPath.section == 0 && self.productivity == nil){
        [ProgressHUD showError:@"Day already passed."];
    } else if(indexPath.section == 0) {
        [ProgressHUD showError:@"Already logged."];
    }
}

-(void)didSaveProductivity
{
    NSRange range = NSMakeRange(0, 0);
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80.0f;
    }
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"PushMonth"]) {
        PDMonthTableViewController *mt = (PDMonthTableViewController*)[segue destinationViewController];
        mt.delegate = self;
    }
}


-(void)didSelectDate:(NSDate *)newDate
{
    self.reviewDate = newDate;
    [self reloadDate];
}


@end
