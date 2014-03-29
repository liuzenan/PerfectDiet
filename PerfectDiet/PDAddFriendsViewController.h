//
//  PDAddFriendsViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 8/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PDAddFriendsViewController : PDBaseTableViewController

@property (nonatomic, strong) NSArray *userList;

- (IBAction)doneButtonPressed:(id)sender;

@end
