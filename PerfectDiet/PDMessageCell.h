//
//  PDMessageCell.h
//  PerfectDiet
//
//  Created by Liu Zenan on 30/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDAddFriendCellDelegate

- (void) didAddFriend:(NSString*) userName forCell:(id)cell;

@end

@interface PDMessageCell : UITableViewCell
@property (weak, nonatomic) id<PDAddFriendCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) UILabel *message;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (assign, nonatomic) BOOL isFollowed;
@property (nonatomic, strong) NSString *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
- (void) setMessageText:(NSString*) text;
- (IBAction)addPressed:(id)sender;

@end
