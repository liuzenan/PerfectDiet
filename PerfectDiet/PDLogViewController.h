//
//  PDLogViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDLogScreenCell.h"
#import "PDMoodWheelView.h"



@interface PDLogViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, PDLogScreenCellDelegate>

@property (weak, nonatomic) NSArray *logItems;
@property (weak, nonatomic) IBOutlet UIButton *activityButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *moodButton;
@property (weak, nonatomic) IBOutlet UIButton *productivityButton;
@property (weak, nonatomic) IBOutlet UIView *topTabContainer;
@property (strong, nonatomic) UIImageView *tabIndicator;
@property (assign, nonatomic) PDLogType currentType;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)activityButtonPressed:(id)sender;
- (IBAction)foodButtonPressed:(id)sender;
- (IBAction)moodButtonPressed:(id)sender;
- (IBAction)productivityButtonPressed:(id)sender;

@end
