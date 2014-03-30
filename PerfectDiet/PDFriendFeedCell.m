//
//  PDFriendFeedCell.m
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDFriendFeedCell.h"

@implementation PDFriendFeedCell

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

-(void)setIsLiked:(BOOL)isLiked
{
    _isLiked = isLiked;
    if (_isLiked) {
        [self.likeButton setImage:[UIImage imageNamed:@"icon_liked"] forState:UIControlStateNormal];
        [self.likeButton setTintColor:[UIColor colorWithHexString:@"#e74c3c"]];

    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        [self.likeButton setTintColor:[UIColor colorWithHexString:@"#e74c3c"]];

    }
}

- (IBAction)likeButtonPressed:(id)sender {
    
    if (self.feedId && !self.isLiked) {
        [self.likeButton setImage:[UIImage imageNamed:@"icon_liked"] forState:UIControlStateNormal];
        [self.delegate didLikeFeed:self.feedId forCell:self];
    }
    
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
    
    [self.title setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [_note setFont:[UIFont fontWithName:@"Georgia" size:12.0f]];
    [_note setBackgroundColor:[UIColor colorWithHexString:BACKGROUND_COLOR]];
    
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 20.0f;
    
    [self.likeButton setTintColor:[UIColor colorWithHexString:@"#e74c3c"]];
    
}
@end
