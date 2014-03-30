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
        [self.userImage setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self.userImage setUserInteractionEnabled:NO];
}

-(void)setIsFollowed:(BOOL)isFollowed
{
    _isFollowed = isFollowed;
    if (_isFollowed) {
        [self.userImage setImage:[UIImage imageNamed:@"icon_checked_user"]];
    } else {
        [self.userImage setImage:[UIImage imageNamed:@"icon_add_user"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addPressed:(id)sender {
    if (self.userName && !self.isFollowed) {
        [self.userImage setImage:[UIImage imageNamed:@"icon_checked_user"]];
        [self.delegate didAddFriend:self.userName forCell:self];
    }
}
@end
