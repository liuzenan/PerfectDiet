//
//  PDProductivityTableViewCell.h
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BKECircularProgressView/BKECircularProgressView.h>

@interface PDProductivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productivityLabel;
@property (weak, nonatomic) IBOutlet BKECircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressValue;

@end
