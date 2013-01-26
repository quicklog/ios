//
//  AddItemViewController.h
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordAudioViewController.h"

@interface AddItemViewController : UITableViewController

@property (nonatomic, retain) RecordAudioViewController * recordAudioViewController;
@property (nonatomic, retain) UITableViewCell * recordAudioCell;
@property (nonatomic, readwrite) BOOL readyToRecord;

-(IBAction)showRecordAudioTools:(id)sender;

@end
