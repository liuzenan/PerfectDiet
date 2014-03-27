//
//  PDAddMoodViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDAddMoodViewController.h"
#import "PDPropertyListController.h"
#import "PDMoreItemTableViewController.h"


@implementation PDAddMoodViewController

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
    
    // add mood list
    self.logItems = [PDPropertyListController loadMoodList];
    
    // load collection view
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LogCollectionView" owner:self options:nil];
    self.collectionView = (UICollectionView*) [nib objectAtIndex:0];
    [self.collectionView setCenter:CGPointMake(160, 240)];
    [self.collectionView setContentInset:UIEdgeInsetsMake(30, 0, 0, 0)];
    
    // load mood wheel view
    nib = [[NSBundle mainBundle] loadNibNamed:@"LogMoodWheelView" owner:self options:nil];
    self.moodWheel = (PDMoodWheelView*) [nib objectAtIndex:0];
    CGRect frame = self.moodWheel.frame;
    frame.origin = CGPointMake(320, 0);
    [self.moodWheel setFrame:frame];
    
    // register collection view cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"LogCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:COLLECTION_VIEW_CELL];
    
    [self.scrollView addSubview:self.collectionView];
    [self insertMoodWheelView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return LOG_BUTTON_NUM;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PDLogScreenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_VIEW_CELL forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row < LOG_BUTTON_NUM - 1) {
        
        [cell.logItemButton setImage:[UIImage imageNamed:self.logItems[indexPath.row][@"Icon"]] forState:UIControlStateNormal];
        [cell.logItemLabel setText:self.logItems[indexPath.row][@"Name"]];
        [cell setItemId:[self.logItems[indexPath.row][@"ID"] integerValue]];
        [cell setItemCategory:[self.logItems[indexPath.row][@"Type"] integerValue]];
    } else {
        
        [cell.logItemButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [cell.logItemLabel setText:@"More"];
        [cell setItemId:ADD_BUTTON_ID];
    }
    
    return cell;
    
}

- (void) insertMoodWheelView
{
    [self.scrollView addSubview:self.moodWheel];
    [self.scrollView setContentSize:CGSizeMake(640, self.scrollView.frame.size.height)];
}


-(void)cellButtonPressedWithItemId:(NSInteger)itemId itemCategory:(NSInteger)category
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    NSLog(@"cell button pressed in add mood:%@", self.delegate);
    if (itemId == ADD_BUTTON_ID) {
        PDMoreItemTableViewController *mi = (PDMoreItemTableViewController*)[sb instantiateViewControllerWithIdentifier:@"MoreLog"];
        [self presentViewController:mi animated:YES completion:nil];
    } else {
        
        PDPFActivity *mood = [PDPFActivity object];
        mood.item_id = itemId;
        mood.item_type = kMood;
        [self.delegate addMood:mood];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
