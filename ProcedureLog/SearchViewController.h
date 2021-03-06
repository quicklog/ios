//
//  SearchViewController.h
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *searchResultsTableView;
@property (nonatomic, retain) NSString *search;
@property (nonatomic, retain) NSMutableArray *proceeduresToDisplay, *filteredProcedures;

@property (nonatomic) int amountOfDummies;

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;

@end
