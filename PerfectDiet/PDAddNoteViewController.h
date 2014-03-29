//
//  PDAddNoteViewController.h
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CHTTextView/CHTTextView.h>

@protocol AddNoteDelegate

- (void) addNote:(NSString*) note;

@end


@interface PDAddNoteViewController : PDBaseViewController <UITextViewDelegate>
@property (nonatomic, weak) id<AddNoteDelegate> delegate;
@property (weak, nonatomic) IBOutlet CHTTextView *noteView;
- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end
