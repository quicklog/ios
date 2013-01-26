//
//  DoRecordAudioCell.h
//  ProcedureLog
//
//  Created by Andrew Vizor on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DoRecordAudioCell : UITableViewCell <AVAudioRecorderDelegate, AVAudioSessionDelegate>

@property (nonatomic, retain) IBOutlet UIButton * startStopButton;
@property (nonatomic, retain) IBOutlet UIProgressView * recordingProgress;
@property (nonatomic, retain) IBOutlet UILabel * recordingProgressLabel;

@end
