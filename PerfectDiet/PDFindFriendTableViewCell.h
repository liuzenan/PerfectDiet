//
//  PDFindFriendTableViewCell.h
//  PerfectDiet
//
//  Created by Liu Zenan on 29/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFindFriendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIButton *addbutton;
@property (weak, nonatomic) IBOutlet UILabel *name;
- (IBAction)addPressed:(id)sender;

@end
