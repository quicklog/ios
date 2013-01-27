//
//  AddItemViewController.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "AddItemViewController.h"
#import "DoRecordAudioCell.h"
#import "Item+Helper.h"
#import "Recording.h"
#import "CommentCell.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.audioSession = [AVAudioSession sharedInstance];
        NSError *error = nil;
        [self.audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        // Custom initialization
    }
    return self;
}

-(IBAction)showRecordAudioTools:(id)sender
{
    self.readyToRecord = YES;
    
    [self.tableView beginUpdates];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];    
}

- (void)viewDidLoad
{
    self.navigationItem.hidesBackButton = NO;
    
    UIBarButtonItem * saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveProceedure)];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *tempSoundFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tempRecording.aac"];
    [fileManager removeItemAtPath:tempSoundFilePath error:NULL];
    
    saveButton.title = @"Save";
    self.navigationItem.rightBarButtonItem = saveButton;
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
    return 4;
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
            NSLog(@"recordy");
            static NSString *identifier = @"DoRecordAudioCell";
            DoRecordAudioCell * cell = (DoRecordAudioCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.recordingProgress setProgress:0.0];
            cell.recordingProgressLabel.text = [NSString stringWithFormat:@"%i", 0];
            return cell;
        }
        else
        {
            NSString *tempSoundFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tempRecording.aac"];
            
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:tempSoundFilePath];
            
            if(fileExists)
            {
                static NSString *identifier = @"PlayAudioCell";
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
    }
    else if(indexPath.row == 4)
    {
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
        height = 120;
    }
    
    return height;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = (CommentCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

    [cell.commentText resignFirstResponder];
}

//Audio stuff

- (IBAction)cancelRecording:(id)sender
{
    [self.updateTimer invalidate];
    self.updateTimer = nil;
    
    self.readyToRecord = NO;
    
    [self.tableView beginUpdates];

    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

-(IBAction)startOrStopRecording:(id)sender
{
    NSLog(@"errrr %i", self.numberOfSecondsRecordedFor);
    
    if(self.numberOfSecondsRecordedFor > 0)
    {
        [self stopRecording];
    }
    else
    {
        [self startRecording];
    }
}

- (AVAudioRecorder *)recorder
{
    if (!_recorder) {
        NSString *soundFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tempRecording.aac"];
        
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

-(void)updatetimeRecorded
{
    DoRecordAudioCell *cell = (DoRecordAudioCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [cell.recordingProgress setProgress:(1 - ((float)self.numberOfSecondsRecordedFor/20))];
    cell.recordingProgressLabel.text = [NSString stringWithFormat:@"%i", self.numberOfSecondsRecordedFor];
    
    NSLog(@"progress: %f", 1 - ((float)self.numberOfSecondsRecordedFor/20));
    
    if(self.numberOfSecondsRecordedFor >= MAX_RECORDING_TIME)
    {
        [self stopRecording];
    }
    
    self.numberOfSecondsRecordedFor++;
}


-(void)startRecording
{
    NSLog(@"recording now...");
    
    DoRecordAudioCell *cell = (DoRecordAudioCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [cell.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
    
    self.recorder = nil;
    [self.recorder prepareToRecord];
    [self.recorder record];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatetimeRecorded) userInfo:nil repeats:YES];
}

-(void)stopRecording
{
    NSLog(@"stop recording");
    
    [self.updateTimer invalidate];
    self.updateTimer = nil;
    
    [self.recorder stop];
    self.numberOfSecondsRecordedFor = 0;

    self.readyToRecord = NO;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [self.tableView beginUpdates];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

-(void)saveProceedure
{
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
    
    Item * item = [Item MR_createInContext:localContext];
    item.rating = [NSNumber numberWithFloat:3.0];
    item.timestamp = [NSDate date];
    
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    
    CommentCell *cell = (CommentCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    item.uid = (__bridge NSString *)newUniqueIdString;
    item.comment = cell.commentText.text;

    [localContext MR_saveToPersistentStoreAndWait];
    
    //also move the temp audio file to id'd directory
    
    NSString *tempSoundFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tempRecording.aac"];

    NSString *realSoundFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.aac", item.uid]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager copyItemAtPath:tempSoundFilePath toPath:realSoundFilePath error:&error];
    [fileManager removeItemAtPath:tempSoundFilePath error:NULL];
    
    [item saveToCloud];
    
    NSLog(@"saved proceedure");
}

-(IBAction)playAudio:(id)sender
{
    
}

-(IBAction)deleteAudio:(id)sender
{
    
}


@end
