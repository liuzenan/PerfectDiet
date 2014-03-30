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
#import "PDMoreItemTableViewController.h"
#import "PDSaveProductivityLogViewController.h"
#import "PDActivityDataController.h"
#import <SKBounceAnimation/SKBounceAnimation.h>
#import "PDSettingsViewController.h"
#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

@interface PDLogViewController () <PDSettingsDelegate>

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
    
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:BACKGROUND_COLOR]];
    [self.scrollView setBackgroundColor:[UIColor colorWithHexString:BACKGROUND_COLOR]];
    // load collection view
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LogCollectionView" owner:self options:nil];
    self.collectionView = (UICollectionView*) [nib objectAtIndex:0];
    [self.collectionView setCenter:CGPointMake(160, 200)];
    [self.collectionView setContentInset:UIEdgeInsetsMake(10, 0, 0, 0)];
    [self.collectionView setBackgroundColor:[UIColor colorWithHexString:BACKGROUND_COLOR]];
    
    
    [self.scrollView addSubview:self.collectionView];
    
    self.logItems = [PDPropertyListController loadActivityList];
    [self setAppearance];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LogCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:COLLECTION_VIEW_CELL];
    
    self.tabIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_arrow"]];
    CGRect temp = self.tabIndicator.frame;
    temp.origin.x = 37;
    temp.origin.y = 84;
    self.tabIndicator.frame = temp;
    [self.view addSubview:self.tabIndicator];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [self createTopButtonForType:i];
        [self.topTabContainer addSubview:button];
    }
    
    [self setCurrentTypeAndHighlight:kActivity Animated:NO];

}


- (UIButton*) createTopButtonForType:(PDLogType) type
{
    UIButton *container = [[UIButton alloc] initWithFrame:CGRectMake(80.0f*type, -5.0f, 80.0f, 80.0f)];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 15.0f, 40.0f, 40.0f)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 55.0f, 80.0f, 21.0f)];
    [label setFont:[UIFont systemFontOfSize:12.0f]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    switch (type) {
        case kActivity:
            [image setImage:[UIImage imageNamed:@"icon_activity"]];
            [label setText:@"Activity"];
            [container addTarget:self action:@selector(activityButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case kFood:
            [image setImage:[UIImage imageNamed:@"icon_food"]];
            [label setText:@"Food"];
            [container addTarget:self action:@selector(foodButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case kMood:
            [image setImage:[UIImage imageNamed:@"icon_mood"]];
            [label setText:@"Mood"];
            [container addTarget:self action:@selector(moodButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case kProductivity:
            [image setImage:[UIImage imageNamed:@"icon_productivity"]];
            [label setText:@"Productivity"];
            [container addTarget:self action:@selector(productivityButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    
    image.userInteractionEnabled = NO;
    label.userInteractionEnabled = NO;
    [container addSubview:image];
    [container addSubview:label];
    container.tag = type;
    return container;
}

- (void) setCurrentTypeAndHighlight:(PDLogType)currentType Animated:(BOOL)animated
{
    _currentType = currentType;
    [self highlightSelectedTab:currentType Animated:animated];
    [self positionTabIndicator:currentType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    for (int i = 0; i < 4; i ++) {
//        UIView *v = [self.topTabContainer.subviews objectAtIndex:i];
//        NSLog(@"tag:%ld", v.tag);
//        CGRect f = v.frame;
//        if (v.tag == self.currentType) {
//            f.origin.y = 5.0f;
//        } else {
//            f.origin.y = -5.0f;
//        }
//        v.frame = f;
//        
//        NSLog(@"will: %@", NSStringFromCGRect(v.frame));
//    }
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowSettings"]) {
        UINavigationController *nc = [segue destinationViewController];
        PDSettingsViewController *sv = (PDSettingsViewController*)[nc topViewController];
        sv.delegate = self;
    }
}

- (void) resetTabs
{
    [self setCurrentTypeAndHighlight:self.currentType Animated:YES];
}

- (void)activityButtonPressed:(id)sender {
    [self setCurrentTypeAndHighlight:kActivity Animated:YES];
    self.logItems = [PDPropertyListController loadActivityList];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)foodButtonPressed:(id)sender {
    [self setCurrentTypeAndHighlight:kFood Animated:YES];
    self.logItems = [PDPropertyListController loadFoodList];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)moodButtonPressed:(id)sender {
    [self setCurrentTypeAndHighlight:kMood Animated:YES];
    self.logItems = [PDPropertyListController loadMoodList];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)productivityButtonPressed:(id)sender {
    [ProgressHUD show:@"Loading..."];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    PDSaveProductivityLogViewController *spl = (PDSaveProductivityLogViewController*)[sb instantiateViewControllerWithIdentifier:@"SaveProductivityLog"];
    [self presentViewController:spl animated:YES completion:^{
        [ProgressHUD dismiss];
    }];
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

#pragma mark - UICollectionViewDelegateFlowLayout

-(void)cellButtonPressedWithItemTypeId:(NSString *)itemTypeId itemCategory:(NSInteger)category
{
    [ProgressHUD show:@"Loading..."];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
    
    if (itemTypeId == nil) {
        NSLog(@"will open more view");
        
        UINavigationController *nc = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"MoreLog"];
        
        if (nc == nil) {
            [ProgressHUD dismiss];
            return;
        }
        
        PDMoreItemTableViewController *mi = (PDMoreItemTableViewController*) nc.topViewController;
        
        [mi setLogType:self.currentType];
        
        
        
        [self presentViewController:nc animated:YES completion:^{
            [ProgressHUD dismiss];
        }];
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
        
        if (nc == nil) {
            [ProgressHUD dismiss];
            return;
        }
        
        
        [PDActivityDataController getItemType:itemTypeId withBlock:^(PDActivityType *object, NSError *error) {
            PDSaveLogViewController *sl = (PDSaveLogViewController*)nc.topViewController;
            [sl setItemObjectId:object];
            [self presentViewController:nc animated:YES completion:^{
                [ProgressHUD dismiss];
            }];
        }];
        
        
    }
}

#pragma mark - Misc


- (void) setAppearance
{
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
}

- (void) highlightSelectedTab:(NSInteger) selectedTab Animated:(BOOL) animated
{
    NSArray* subviews = [self.topTabContainer subviews];
    for (UIView* view in subviews) {
        if (view.tag == selectedTab) {
            [view setAlpha:1];
            [self bounceDown:view Animated:animated];
        } else {
            [view setAlpha:0.8];
            [self bounceUp:view Animated:animated];
        }
    }
}


- (void) bounceUp:(UIView*)view Animated:(BOOL) animated
{
    
    NSString *keyPath = @"position.y";
    
    CGFloat f = 35.0f;
    
    NSNumber *value = [view.layer valueForKeyPath:keyPath];
    
    if (fequal([value floatValue], f)) {
        return;
    }
    
    id finalValue = [NSNumber numberWithFloat:f];
    
    SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
    bounceAnimation.fromValue = [NSNumber numberWithFloat:view.layer.position.y];
    bounceAnimation.toValue = finalValue;
    bounceAnimation.duration = 1.0f;
    bounceAnimation.numberOfBounces = 2;
    bounceAnimation.removedOnCompletion = NO;
    
    [view.layer addAnimation:bounceAnimation forKey:@"bounceUp"];
    [view.layer setValue:finalValue forKeyPath:keyPath];


}

- (void) bounceDown:(UIView*)view Animated:(BOOL) animated
{
    CGFloat f = 45.0f;
    

    NSString *keyPath = @"position.y";
    
    id finalValue = [NSNumber numberWithFloat:f];
    
    SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
    bounceAnimation.fromValue = [NSNumber numberWithFloat:view.layer.position.y];
    bounceAnimation.toValue = finalValue;
    bounceAnimation.duration = 1.0f;
    bounceAnimation.numberOfBounces = 2;
    bounceAnimation.removedOnCompletion = NO;

    
    [view.layer addAnimation:bounceAnimation forKey:@"bounceDown"];
    [view.layer setValue:finalValue forKeyPath:keyPath];

}

- (void) positionTabIndicator:(PDLogType)type
{
    if (type == kActivity) {
        CGRect temp = self.tabIndicator.frame;
        temp.origin.x = 37;
        self.tabIndicator.frame = temp;
    }else if (type == kFood) {
        CGRect temp = self.tabIndicator.frame;
        temp.origin.x = 117;
        self.tabIndicator.frame = temp;
    }else if (type == kMood) {
        CGRect temp = self.tabIndicator.frame;
        temp.origin.x = 197;
        self.tabIndicator.frame = temp;
    }
    
    NSLog(@"tab indicator: x:%ld", (long)self.tabIndicator.frame.origin.x);
}

-(void)didLogout
{
    NSLog(@"did logout");
    [self dismissViewControllerAnimated:YES completion:^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];
        UINavigationController *sv = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"SplashView"];
        [self presentViewController:sv animated:YES completion:nil];
    }];
}
    
@end
