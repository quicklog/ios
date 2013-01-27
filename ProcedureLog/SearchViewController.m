//
//  SearchViewController.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "SearchViewController.h"
#import "Item+Helper.h"
#import "AddItemViewController.h"
#import "Item.h"
#import "TagsViewController.h"
#import "Tag.h"


@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSMutableArray *)proceeduresToDisplay
{
    if(!_proceeduresToDisplay)
    {
        self.proceeduresToDisplay = [[NSMutableArray alloc]init];
    }
    
    return _proceeduresToDisplay;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.proceeduresToDisplay addObjectsFromArray:[Item MR_findAll]];
}

- (void)viewDidLoad
{
    UIBarButtonItem * addNewButton = [[UIBarButtonItem alloc]initWithTitle:@"New Proceedure" style:UIBarButtonItemStylePlain target:self action:@selector(showNewProceedureScreen)];
    self.navigationItem.rightBarButtonItem = addNewButton;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//table view stuff


#pragma mark tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredProcedures count];
    }
    else
    {
        return [self.proceeduresToDisplay count];
    }
    
    return [self.proceeduresToDisplay count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Item *thisItem;
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        thisItem = [self.filteredProcedures objectAtIndex:indexPath.row];
    }
    else
    {
        thisItem = [self.proceeduresToDisplay objectAtIndex:indexPath.row];
    }
    
    UITableViewCell *cell  = nil;

    static NSString *identifier = @"ProceedureSummaryCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell == nil)
    {
        NSLog(@"Cell was nil");
        
        cell = [[UITableViewCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", thisItem.comment];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

       
 //   AddItemViewController *viewController = [[AddItemViewController alloc] init];

  //  [self.navigationController pushViewController:viewController animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   // TagSelectedSegue
   Item *thisItem;
   NSIndexPath *indexPath = [self.searchResultsTableView indexPathForSelectedRow];
    
    if (self.searchResultsTableView == self.searchDisplayController.searchResultsTableView)
    {
        thisItem = [self.filteredProcedures objectAtIndex:indexPath.row];
    }
    else
    {
        thisItem = [self.proceeduresToDisplay objectAtIndex:indexPath.row];
    }
    
    AddItemViewController *viewController = segue.destinationViewController;
    
    viewController.item = thisItem;
}


#pragma mark search filtering

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredProcedures removeAllObjects];
     // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.comment contains[c] %@",searchText];
    self.filteredProcedures = [NSMutableArray arrayWithArray:[[Item MR_findAll] filteredArrayUsingPredicate:predicate]];
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



@end
