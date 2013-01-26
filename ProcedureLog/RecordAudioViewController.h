//
//  RecordAudioViewController.h
//  ProcedureLog
//
//  Created by Andrew Vizor on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordAudioViewController : UIViewController <AVAudioRecorderDelegate, AVAudioSessionDelegate>

@property (nonatomic, retain) AVAudioRecorder *recorder;
@property (nonatomic, retain) AVAudioSession *audioSession;
@property (nonatomic, readwrite) float numberOfSecondsRecordedFor;

-(IBAction)startOrStopRecording:(id)sender;

@end
