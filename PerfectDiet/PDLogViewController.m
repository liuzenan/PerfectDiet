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
    
    // Do any additional setup after loading the view.
    
    
    
    // load collection view
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LogCollectionView" owner:self options:nil];
    self.collectionView = (UICollectionView*) [nib objectAtIndex:0];
    [self.collectionView setCenter:CGPointMake(160, 200)];
    
    // load mood wheel view
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"LogMoodWheelView" owner:self options:nil];
    self.moodWheel = (PDMoodWheelView*) [nib objectAtIndex:0];
    CGRect frame = self.moodWheel.frame;
    frame.origin = CGPointMake(320, 0);
    [self.moodWheel setFrame:frame];
    
    [self.scrollView addSubview:self.collectionView];
    
    self.logItems = [PDPropertyListController loadActivityList];
    [self setCurrentTypeAndHighlight:kActivity];
    [self setAppearance];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LogCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:COLLECTION_VIEW_CELL];
    
    [super viewDidLoad];
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
    [self removeMoodWheelView];
}

- (IBAction)foodButtonPressed:(id)sender {
    self.logItems = [PDPropertyListController loadFoodList];
    [self.collectionView reloadData];
    [self setCurrentTypeAndHighlight:kFood];
    [self removeMoodWheelView];
}

- (IBAction)moodButtonPressed:(id)sender {
    self.logItems = [PDPropertyListController loadMoodList];
    [self insertMoodWheelView];
    [self.collectionView reloadData];
    [self setCurrentTypeAndHighlight:kMood];
}

- (IBAction)productivityButtonPressed:(id)sender {
    [self setCurrentType:kProductivity];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    PDSaveProductivityLogViewController *spl = (PDSaveProductivityLogViewController*)[sb instantiateViewControllerWithIdentifier:@"SaveProductivityLog"];
    [self presentViewController:spl animated:YES completion:nil];
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

- (void) removeMoodWheelView
{
    [self.moodWheel removeFromSuperview];
    [self.scrollView setContentSize:CGSizeMake(320, self.scrollView.frame.size.height)];
}

#pragma mark - UICollectionViewDelegateFlowLayout


-(void)cellButtonPressedWithItemId:(NSInteger)itemId itemCategory:(NSInteger)category
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    
    if (itemId == -1) {
        NSLog(@"will open more view");
        PDMoreItemsViewController *mi = (PDMoreItemsViewController*)[sb instantiateViewControllerWithIdentifier:@"MoreLog"];
        [self presentViewController:mi animated:YES completion:nil];
    } else {
        NSLog(@"will open save view");
        
        UINavigationController *nc;
        switch (self.currentType) {
            case kActivity:
                nc = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"SaveActivityLog"];
                break;
                
            case kFood:
                nc = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"SaveFoodLog"];
                break;
                
            case kMood:
                nc = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"SaveMoodLog"];
                break;
                
            default:
                break;
        }
        
        PDSaveLogViewController *sl = (PDSaveLogViewController*)nc.topViewController;
        
        [sl setItemId:itemId itemCategory:category logType:self.currentType];
        
        [self presentViewController:nc animated:YES completion:nil];
    }
    
}

#pragma mark - Misc


- (void) setAppearance
{
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
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
