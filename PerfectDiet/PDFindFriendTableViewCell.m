//
//  PDFindFriendTableViewCell.m
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDFindFriendTableViewCell.h"

@implementation PDFindFriendTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setIsFollowed:(BOOL)isFollowed
{
    _isFollowed = isFollowed;
    if (_isFollowed) {
        [self.addbutton setImage:[UIImage imageNamed:@"icon_checked_user"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addPressed:(id)sender {
    if (self.userId && !self.isFollowed) {
        [self.delegate didAddFriend:self.userId forCell:self];
    }
}
@end
