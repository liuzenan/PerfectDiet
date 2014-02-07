//
//  PDLogViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDLogViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) NSArray *logItems;
@property (weak, nonatomic) IBOutlet UIButton *activityButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *moodButton;
@property (weak, nonatomic) IBOutlet UIButton *productivityButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)activityButtonPressed:(id)sender;
- (IBAction)foodButtonPressed:(id)sender;
- (IBAction)moodButtonPressed:(id)sender;
- (IBAction)productivityButtonPressed:(id)sender;

@end
