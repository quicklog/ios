//
//  AddItemViewController.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "AddItemViewController.h"
#import "RecordAudioViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

-(RecordAudioViewController *)recordAudioViewController
{
    if(!_recordAudioViewController)
    {
        self.readyToRecord = NO;

        _recordAudioViewController = [[RecordAudioViewController alloc]initWithNibName:@"RecordAudioViewController" bundle:nil];
    }
    
    return _recordAudioViewController;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

        // Custom initialization
    }
    return self;
}

-(IBAction)showRecordAudioTools:(id)sender
{
    self.readyToRecord = YES;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [self.tableView beginUpdates];
    cell.backgroundColor = [UIColor greenColor];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
    //[self.view addSubview:self.recordAudioViewController.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = nil;
    
    if(indexPath.row  == 0)
    {
        static NSString *identifier = @"ProcedureCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if(indexPath.row == 1)
    {
        static NSString *identifier = @"RatingCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if(indexPath.row == 2)
    {
        static NSString *identifier = @"CommentCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if(indexPath.row == 3)
    {
        if(self.readyToRecord)
        {
            static NSString *identifier = @"DoRecordAudioCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else
        {
            static NSString *identifier = @"RecordAudioCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    else if(indexPath.row == 4)
    {
        NSLog(@"menu");
        static NSString *identifier = @"MenuOptionsCell";
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 85;
    
    if(indexPath.row == 2)
    {
        height = 214;
    }
    
    if(indexPath.row == 3 && self.readyToRecord)
    {
        height = 160;
    }
    
    return height;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
