//
//  PDReviewCell.m
//  PerfectDiet
//
//  Created by Liu Zenan on 11/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDReviewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation PDReviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupNote];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self setupNote];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setupNote
{
    _note = [[DALinedTextView alloc] init];
    _note.frame = self.noteWrapper.bounds;
    _note.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    [self.noteWrapper addSubview:_note];
    
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.noteWrapper.bounds];
    self.noteWrapper.layer.masksToBounds = NO;
    self.noteWrapper.layer.shadowColor = [UIColor blackColor].CGColor;
    self.noteWrapper.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.noteWrapper.layer.shadowOpacity = 0.2f;
    self.noteWrapper.layer.shadowRadius = 1.0f;
    self.noteWrapper.layer.shadowPath = shadowPath.CGPath;
    

    UIBezierPath *photoShadowPath = [UIBezierPath bezierPathWithRect:self.photoWrapper.bounds];
    self.photoWrapper.layer.masksToBounds = NO;
    self.photoWrapper.layer.shadowColor = [UIColor blackColor].CGColor;
    self.photoWrapper.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.photoWrapper.layer.shadowOpacity = 0.2f;
    self.photoWrapper.layer.shadowRadius = 1.0f;
    self.photoWrapper.layer.shadowPath = photoShadowPath.CGPath;
    [self.photoWrapper.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.photoWrapper.layer setBorderWidth:2.0f];
    self.photo.layer.masksToBounds = YES;
    [self.photo setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.itemTitle setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [_note setFont:[UIFont fontWithName:@"Georgia" size:12.0f]];
    [_note setBackgroundColor:[UIColor colorWithHexString:BACKGROUND_COLOR]];
}

@end
