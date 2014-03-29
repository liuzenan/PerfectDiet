//
//  PDMonthTableViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CKCalendar/CKCalendarView.h>

@protocol PDDaySelectDelegate

- (void)didSelectDate:(NSDate*)newDate;

@end

@interface PDMonthTableViewController : PDBaseTableViewController <CKCalendarDelegate>

- (IBAction)TodayPressed:(id)sender;
@property (nonatomic, weak) id<PDDaySelectDelegate> delegate;

@end
