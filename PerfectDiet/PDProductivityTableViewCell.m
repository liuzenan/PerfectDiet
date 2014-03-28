//
//  PDProductivityTableViewCell.m
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDProductivityTableViewCell.h"

@implementation PDProductivityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self styleProgressView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self styleProgressView];
}


- (void) styleProgressView
{
    [self.progressView setProgressTintColor:[UIColor colorWithRed:224.0/255.0 green:80.0/255.0 blue:15.0/255.0 alpha:1]];
    [self.progressView setBackgroundTintColor:[UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1]];
    [self.progressView setLineWidth:3.0f];
    [self.progressView setProgress:0.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
