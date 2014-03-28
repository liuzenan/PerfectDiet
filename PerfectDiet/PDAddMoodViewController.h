//
//  PDAddMoodViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDMoodWheelView.h"
#import "PDLogScreenCell.h"
#import "PDPFActivity.h"
#import "PDMoreItemTableViewController.h"


@protocol AddMoodDelegate <NSObject>

- (void) addMood: (PDPFActivity*) mood;

@end

@interface PDAddMoodViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, PDLogScreenCellDelegate, PDMoreItemDelegate>

@property (weak, nonatomic) id<AddMoodDelegate> delegate;
@property (weak, nonatomic) NSArray *logItems;
@property (strong, nonatomic) PDMoodWheelView *moodWheel;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)cancelButtonPressed:(id)sender;
- (void) setDelegate:(id<AddMoodDelegate>)delegate;

@end
