//
//  AddItemViewController.h
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Item.h"

@interface AddItemViewController : UITableViewController <AVAudioRecorderDelegate, AVAudioSessionDelegate, AVAudioPlayerDelegate>

@property (nonatomic, retain) UITableViewCell * recordAudioCell;
@property (nonatomic, readwrite) BOOL readyToRecord;
@property (nonatomic, strong) Item *item;



@property (nonatomic, retain) AVAudioRecorder *recorder;
@property (nonatomic, retain) AVAudioSession *audioSession;
@property (nonatomic, readwrite) int numberOfSecondsRecordedFor;
@property (nonatomic, retain) NSTimer *updateTimer;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

- (IBAction)startOrStopRecording:(id)sender;
- (IBAction)cancelRecording:(id)sender;
- (IBAction)showRecordAudioTools:(id)sender;
-(void)saveProceedure;

-(IBAction)playAudio:(id)sender;
-(IBAction)deleteAudio:(id)sender;

@end
