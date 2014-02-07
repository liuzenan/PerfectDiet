//
//  PDLogViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 7/2/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDLogViewController.h"
#import "PDPropertyListController.h"
#import "PDSaveLogViewController.h"
#import "PDMoreItemsViewController.h"
#import "PDSaveProductivityLogViewController.h"

@interface PDLogViewController ()

@end

@implementation PDLogViewController

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
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    self.logItems = [PDPropertyListController loadActivityList];
    [self setCurrentTypeAndHighlight:kActivity];
    [self setAppearance];
}

- (void) setCurrentTypeAndHighlight:(PDLogType)currentType
{
    _currentType = currentType;
    [self highlightSelectedTab:currentType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)activityButtonPressed:(id)sender {
    self.logItems = [PDPropertyListController loadActivityList];
    [self.collectionView reloadData];
    [self setCurrentTypeAndHighlight:kActivity];
}

- (IBAction)foodButtonPressed:(id)sender {
    self.logItems = [PDPropertyListController loadFoodList];
    [self.collectionView reloadData];
    [self setCurrentTypeAndHighlight:kFood];
    
}

- (IBAction)moodButtonPressed:(id)sender {
    self.logItems = [PDPropertyListController loadMoodList];
    [self.collectionView reloadData];
    [self setCurrentTypeAndHighlight:kMood];
}

- (IBAction)productivityButtonPressed:(id)sender {
    [self setCurrentType:kProductivity];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    PDSaveProductivityLogViewController *spl = (PDSaveProductivityLogViewController*)[sb instantiateViewControllerWithIdentifier:@"SaveProd"];
    [self presentViewController:spl animated:YES completion:nil];
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return LOG_BUTTON_NUM;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"LogScreenCell";
    
    PDLogScreenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row < LOG_BUTTON_NUM - 1) {
        [cell.logItemButton setImage:[UIImage imageNamed:self.logItems[indexPath.row][@"Icon"]] forState:UIControlStateNormal];
        [cell.logItemLabel setText:self.logItems[indexPath.row][@"Name"]];
        [cell.logItemButton setTag:(NSInteger)self.logItems[indexPath.row][@"ID"]];
    } else {
        [cell.logItemButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [cell.logItemLabel setText:@"More"];
        [cell.logItemButton setTag:ADD_BUTTON_ID];
    }

    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(1, -40);
}


-(void)cellButtonPressed:(id)sender
{
    UIButton *button = (UIButton*) sender;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    NSInteger itemId = button.tag;
    if (itemId == -1) {
        NSLog(@"will open more view");
        PDMoreItemsViewController *mi = (PDMoreItemsViewController*)[sb instantiateViewControllerWithIdentifier:@"MoreLog"];
        [self presentViewController:mi animated:YES completion:nil];
    } else {
        NSLog(@"will open save view");
        PDSaveLogViewController *sl = (PDSaveLogViewController*)[sb instantiateViewControllerWithIdentifier:@"SaveLog"];
        [self presentViewController:sl animated:YES completion:nil];
    }
    
}

#pragma mark - Misc


- (void) setAppearance
{
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setTitle:@"LifeLogger"];
}

- (void) highlightSelectedTab:(NSInteger) selectedTab
{
    NSArray* subviews = [self.topTabContainer subviews];
    for (UIView* view in subviews) {
        if (view.tag == selectedTab) {
            [view setAlpha:1];
        } else {
            [view setAlpha:0.5];
        }
    }
}

    
@end
