//
//  PDMoreItemTableViewController.m
//  PerfectDiet
//
//  Created by Liu Zenan on 28/3/14.
//  Copyright (c) 2014 NUS. All rights reserved.
//

#import "PDMoreItemTableViewController.h"
#import "PDNewItemViewController.h"
#import "PDActivityDataController.h"
#import "PDSaveLogViewController.h"

@interface PDMoreItemTableViewController ()

@end

@implementation PDMoreItemTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    switch (self.logType) {
        case kActivity:
            [self.navigationItem setTitle:@"Choose Activity"];
            break;
            
        case kFood:
            [self.navigationItem setTitle:@"Choose Food"];
            break;
            
        case kMood:
            [self.navigationItem setTitle:@"Choose Mood"];
            break;
            
        default:
            break;
    }
    
    self.itemList = [NSArray new];
    self.filterArray = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [PDActivityDataController getItemTypeList:self.logType withBlock:^(NSArray *objects, NSError *error) {
        self.itemList = objects;
        self.filterArray = [NSMutableArray arrayWithCapacity:[self.itemList count]];
        [self.tableView reloadData];
    }];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filterArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.item_name contains[c] %@",searchText];
    self.filterArray = [NSMutableArray arrayWithArray:[self.itemList filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filterArray count];
    } else {
        return [self.itemList count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"LogItemCell" forIndexPath:indexPath];
    
    PDActivityType * type;
    // Configure the cell...
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        type = [self.filterArray objectAtIndex:indexPath.row];
    } else {
        type = [self.itemList objectAtIndex:indexPath.row];
    }
    
    
    [cell.textLabel setText:type.item_name];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDActivityType *item;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        item = [self.filterArray objectAtIndex:indexPath.row];
    } else {
        item = [self.itemList objectAtIndex:indexPath.row];
    }

    if (self.isAttachMode) {
        [self.typeDelegate didSelectItem:item];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:STORYBOARD_NAME bundle:nil];

    UINavigationController *nc;
    switch (self.logType) {
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
        return;
    }
    
    PDSaveLogViewController *sl = (PDSaveLogViewController*)nc.topViewController;
    
    PDActivityType *type = item;
    
    
    [sl setItemObjectId:type];
    [self.navigationController pushViewController:sl animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"CreateNew"]) {
        PDNewItemViewController *ni = (PDNewItemViewController*) [segue destinationViewController];
        [ni setLogType:self.logType];
    }
}


- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
