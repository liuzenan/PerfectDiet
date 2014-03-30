//
//  PDLogViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDLogScreenCell.h"

@interface PDLogViewController : PDBaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, PDLogScreenCellDelegate>

@property (weak, nonatomic) NSArray *logItems;
@property (weak, nonatomic) IBOutlet UIView *topTabContainer;
@property (strong, nonatomic) UIImageView *tabIndicator;
@property (assign, nonatomic) PDLogType currentType;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *scrollView;

@end
