//
//  StatsViewController.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "StatsViewController.h"
#import "Item.h"

@interface StatsViewController ()

@end

@implementation StatsViewController


#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSMutableArray *)theProceedures
{
    if(!_theProceedures)
    {
        self.theProceedures = [[NSMutableArray alloc]init];
    }
    
    return _theProceedures;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timestamp != nil"];
    [self.theProceedures addObjectsFromArray:[Item MR_findAllSortedBy:@"timestamp" ascending:YES withPredicate:predicate]];
}

-(void)showNewProceedureScreen
{
    NSLog(@"open");
}

- (void)viewDidLoad
{
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

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.theProceedures count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item * thisItem = [self.theProceedures objectAtIndex:indexPath.row];
    
    UITableViewCell *cell  = nil;
    NSString * faketag;
    
    if(indexPath.row == 0)
    {
        faketag = @"Blood test";
    }
    else if(indexPath.row == 1)
    {
        faketag = @"Cannula";
    }
    else
    {
        faketag = @"Blood gas";
    }
    
    static NSString *identifier = @"ProceedureHistoryCell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", faketag];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d/MM/Y hh:mm:ss"];
    
    NSString *test = [formatter stringFromDate:thisItem.timestamp];
    
    cell.detailTextLabel.text = test;
    return cell;
}


@end
