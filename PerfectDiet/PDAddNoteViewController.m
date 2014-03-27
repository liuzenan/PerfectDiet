//
//  PDAddNoteViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDAddNoteViewController.h"


@implementation PDAddNoteViewController {
    CGSize _keyboardSize;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.noteView.placeholder = @"Write your note here...";
    
    CGRect frame = self.noteView.frame;
    frame.size.height -= 216;
    self.noteView.frame = frame;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.noteView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    if (!(self.noteView.text == nil || [self.noteView.text isEqualToString:@""])) {
        [self.delegate addNote:self.noteView.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
