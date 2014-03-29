//
//  PDMoreItemTableViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDActivityType.h"

@protocol PDMoreItemDelegate

- (void) didSelectItem:(PDActivityType*)type;

@end

@interface PDMoreItemTableViewController : PDBaseTableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
- (IBAction)cancelButtonPressed:(id)sender;

@property (weak, nonatomic) id<PDMoreItemDelegate> typeDelegate;
@property (strong, nonatomic) NSArray *itemList;
@property (assign, nonatomic) PDLogType logType;
@property (assign, nonatomic) BOOL isAttachMode;
@property (strong, nonatomic) NSMutableArray *filterArray;

@end
