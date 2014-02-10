//
//  PDTodayTopTableViewCell.h
//  PerfectDiet
//
//  Created by Liu Zenan on 11/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDTodayTopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *stats;

@end
