//
//  PDLogViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDLogScreenCell.h"

typedef enum{
    kActivity = 0,
    kFood = 1,
    kMood = 2,
    kProductivity
} PDLogType;

@interface PDLogViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, PDLogScreenCellDelegate>

@property (weak, nonatomic) NSArray *logItems;
@property (weak, nonatomic) IBOutlet UIButton *activityButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *moodButton;
@property (weak, nonatomic) IBOutlet UIButton *productivityButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *topTabContainer;
@property (assign, nonatomic) PDLogType currentType;

- (IBAction)activityButtonPressed:(id)sender;
- (IBAction)foodButtonPressed:(id)sender;
- (IBAction)moodButtonPressed:(id)sender;
- (IBAction)productivityButtonPressed:(id)sender;

@end
