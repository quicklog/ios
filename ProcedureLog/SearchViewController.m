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

-(void)showNewProceedureScreen
{
    NSLog(@"open");
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.proceeduresToDisplay count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item * thisItem = [self.proceeduresToDisplay objectAtIndex:indexPath.row];
    
    UITableViewCell *cell  = nil;
    
    static NSString *identifier = @"ProceedureSummaryCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", thisItem.timestamp];
    
    return cell;
}


@end
