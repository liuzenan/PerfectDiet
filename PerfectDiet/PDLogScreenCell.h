//
//  PDLogScreenCell.h
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PDLogScreenCellDelegate <NSObject>

@optional
- (void) cellButtonPressed:(id) sender;
- (void) cellButtonPressedWithItemTypeId:(NSString*)itemTypeId itemCategory: (NSInteger)category;

@end

@interface PDLogScreenCell : UICollectionViewCell
@property (weak, nonatomic) id<PDLogScreenCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *logItemButton;
@property (weak, nonatomic) IBOutlet UILabel *logItemLabel;
@property (assign, nonatomic) NSInteger itemCategory;
@property (assign, nonatomic) NSInteger itemId;
@property (strong, nonatomic) NSString *itemTypeId;

- (IBAction)logItemButtonPressed:(id)sender;

@end
