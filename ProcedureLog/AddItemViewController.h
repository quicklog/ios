//
//  AddItemViewController.h
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AddItemViewController : UITableViewController <AVAudioRecorderDelegate, AVAudioSessionDelegate>

@property (nonatomic, retain) UITableViewCell * recordAudioCell;
@property (nonatomic, readwrite) BOOL readyToRecord;

@property (nonatomic, retain) AVAudioRecorder *recorder;
@property (nonatomic, retain) AVAudioSession *audioSession;
@property (nonatomic, readwrite) int numberOfSecondsRecordedFor;
@property (nonatomic, retain) NSTimer *updateTimer;

- (IBAction)startOrStopRecording:(id)sender;
- (IBAction)cancelRecording:(id)sender;
- (IBAction)showRecordAudioTools:(id)sender;
-(void)saveProceedure;

@end
