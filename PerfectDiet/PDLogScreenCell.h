//
//  PDLogScreenCell.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDLogScreenCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *logItemButton;
@property (weak, nonatomic) IBOutlet UILabel *logItemLabel;
- (IBAction)logItemButtonPressed:(id)sender;

@end
