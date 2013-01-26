//
//  AddItemViewController.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "AddItemViewController.h"

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
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [self.tableView beginUpdates];
    cell.backgroundColor = [UIColor greenColor];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];    
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
            NSLog(@"recordy");
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

//Audio stuff

- (IBAction)cancelRecording:(id)sender
{    
    self.readyToRecord = NO;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [self.tableView beginUpdates];
    cell.backgroundColor = [UIColor greenColor];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

-(IBAction)startOrStopRecording:(id)sender
{    
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

-(void)updatetimeRecorded
{
    self.numberOfSecondsRecordedFor++;
    NSLog(@"%f", self.numberOfSecondsRecordedFor);
}

-(void)startRecording
{
    NSLog(@"recording now...");
    self.recorder = nil;
    [self.recorder prepareToRecord];
    [self.recorder record];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1/60.0f target:self selector:@selector(updatetimeRecorded) userInfo:nil repeats:YES];
}

-(void)stopRecording
{
    NSLog(@"stop recording");
    
    [self.updateTimer invalidate];
    self.updateTimer = nil;
    
    self.numberOfSecondsRecordedFor = 0;
    [self.recorder stop];
    
    self.readyToRecord = NO;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    [self.tableView beginUpdates];
    cell.backgroundColor = [UIColor greenColor];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}


@end
