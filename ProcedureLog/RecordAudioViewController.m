//
//  RecordAudioViewController.m
//  ProcedureLog
//
//  Created by Andrew Vizor on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "RecordAudioViewController.h"

@interface RecordAudioViewController ()

@end

@implementation RecordAudioViewController

- (AVAudioRecorder *)recorder
{    
    if (!_recorder) {
        NSString *soundFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"testRecording"];
        
        NSURL *recordURL = [NSURL fileURLWithPath:soundFilePath];
        NSLog(@"Will record to: %@", recordURL);
        
        AudioChannelLayout channelLayout;
        memset(&channelLayout, 0, sizeof(channelLayout));
        channelLayout.mChannelLayoutTag = kAudioChannelLayoutTag_Mono;
        
        NSDictionary *recordSettings =
        [NSDictionary dictionaryWithObjectsAndKeys:
         [NSNumber numberWithInt:AAC_BIT_RATE], AVEncoderBitRateKey,
         [NSNumber numberWithFloat: SAMPLE_RATE], AVSampleRateKey,
         [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
         [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
         [NSData dataWithBytes:&channelLayout length:sizeof(AudioChannelLayout)], AVChannelLayoutKey,
         nil];
        NSError *error = nil;
        _recorder = [[AVAudioRecorder alloc] initWithURL:recordURL settings:recordSettings error:&error];
        _recorder.delegate = self;
        _recorder.meteringEnabled = YES;
        
        if (error) {
            NSLog(@"%@", error);
        }
        
    }
    
    NSLog(@"recorder initialised");
    return _recorder;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)startOrStopRecording:(id)sender
{
    NSLog(@"starting or stopping recording");

    if(self.numberOfSecondsRecordedFor > 0)
    {
        [self stopRecording];
    }
    else
    {
        [self startRecording];
    }
}

-(void)startRecording
{
    NSLog(@"recording now...");
    self.recorder = nil;
    [self.recorder prepareToRecord];
    [self.recorder record];
}

-(void)stopRecording
{
    self.numberOfSecondsRecordedFor = 0;
    [self.recorder stop];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
