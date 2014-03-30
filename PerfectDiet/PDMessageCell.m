//
//  PDMessageCell.m
//  PerfectDiet
//
//  Created by Liu Zenan on 30/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDMessageCell.h"

@implementation PDMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setStyling];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self setStyling];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setMessageText:(NSString*) text
{
    if (self.message == nil) {
        [self setStyling];
    }
    [self.message setText:text];
    [self.message setNumberOfLines:0];
    [self.message sizeToFit];
    [self addSubview:self.message];
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

- (IBAction)addPressed:(id)sender {
    if (self.userName && !self.isFollowed) {
        [self.userImage setImage:[UIImage imageNamed:@"icon_checked_user"]];
        [self.delegate didAddFriend:self.userName forCell:self];
    }
}

- (void) setStyling
{
    if (self.message == nil) {
        self.message = [[UILabel alloc] initWithFrame:CGRectMake(88, 10, 178, 50)];
    }
    self.message.lineBreakMode = NSLineBreakByWordWrapping;
    [self.message setFont:[UIFont systemFontOfSize:16.0]];
}

@end
