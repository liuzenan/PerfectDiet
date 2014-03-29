//
//  PDFriendFeedCell.h
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DALinedTextView/DALinedTextView.h>


@interface PDFriendFeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
- (IBAction)likeButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *photoWrapper;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIView *noteWrapper;
@property (strong, nonatomic) DALinedTextView *note;

@end
