//
//  PDFindFriendTableViewCell.h
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PDAddFriendCellDelegate

- (void) didAddFriend:(NSString*) userName forCell:(id)cell;

@end

@interface PDFindFriendTableViewCell : UITableViewCell
@property (weak, nonatomic) id<PDAddFriendCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIButton *addbutton;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) NSString *userName;
@property (assign, nonatomic) BOOL isFollowed;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
- (IBAction)addPressed:(id)sender;

@end
