//
//  PDAddMoodViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 9/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDAddMoodViewController.h"
#import "PDPropertyListController.h"
#import "PDActivityDataController.h"

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
    
    
    // register collection view cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"LogCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:COLLECTION_VIEW_CELL];
    
    [self.scrollView addSubview:self.collectionView];

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
        [cell setItemTypeId:self.logItems[indexPath.row][@"ObjectId"]];
    } else {
        
        [cell.logItemButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [cell.logItemLabel setText:@"More"];
        [cell setItemId:ADD_BUTTON_ID];
        [cell setItemTypeId:nil];
    }
    
    return cell;
    
}

-(void)cellButtonPressedWithItemTypeId:(NSString *)itemTypeId itemCategory:(NSInteger)category
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    if (itemTypeId == nil) {
        PDMoreItemTableViewController *mi = (PDMoreItemTableViewController*)[sb instantiateViewControllerWithIdentifier:@"ChooseItem"];
        mi.logType = kMood;
        mi.isAttachMode = YES;
        mi.typeDelegate = self;
        [self.navigationController pushViewController:mi animated:YES];
    } else {
        
        [PDActivityDataController getItemType:itemTypeId withBlock:^(PDActivityType *object, NSError *error) {
            PDPFActivity *mood = [PDPFActivity object];
            mood.item_type = kMood;
            mood.item_activity_type = object;
            [self.delegate addMood:mood];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];

    }
}

-(void)didSelectItem:(PDActivityType *)type
{
    PDPFActivity *mood = [PDPFActivity object];
    mood.item_type = kMood;
    mood.item_activity_type = type;
    [self.delegate addMood:mood];
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
