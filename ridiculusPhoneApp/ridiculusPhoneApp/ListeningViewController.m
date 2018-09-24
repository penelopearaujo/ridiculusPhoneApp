//
//  ListeningViewController.m
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 18/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import "ListeningViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ListeningViewController ()

@end

@implementation ListeningViewController
@synthesize timerLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timerLabel.text = @"0:00";

    //aux variables
    i = 0;
    
    for (i=0; i<_numberOfTeams; i++) {
        count = 0;
        
        //setting timer
        [self startMatchTimer];
        
        //setting recorder
        AVAudioSession *recordingSession = [AVAudioSession sharedInstance];
        NSError *error;
        [recordingSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        [recordingSession setActive:TRUE error:&error];
        [recordingSession requestRecordPermission:^(BOOL granted) {
            if (granted){
                [self listenMic];
            } else {
                NSLog(@"Error!");
            }
        }];
        
        //setting end of turn
        [recorder stop];
        return;
    }
}

- (void) startMatchTimer {
    matchTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateMatchTimer) userInfo:nil repeats:YES];
}

- (void) updateMatchTimer {
    // formats time for time label
    int min = floor(count/100/60);
    int sec = floor(count/100);
    if (sec >= 60) {
        sec = sec % 60;
    }
    timerLabel.text = [NSString stringWithFormat:@"%2d:%02d", min, sec];
    count++;
    
    //if time's up, stops timer
    if (count == 90){
        [matchTimer invalidate];
    }
    NSLog(@"rolou, %d", count);
}

- (void)listenMic {
    // detects microphone audio
    if (AVAudioSessionRecordPermissionGranted) {
        //        NSURL *url = [NSURL fileURLWithPath:@"/dev/null"]; //works on simulator
        NSURL *url = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"nomeDoArquivo.m4a"]; //works on iphone
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                                  nil];
        NSError *error;
        recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
        
        if (recorder) {
            [recorder prepareToRecord];
            recorder.meteringEnabled = YES;
            [recorder record];
            levelTimer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
        } else
            NSLog(@"%@", [error description]);
    }
}


- (void)levelTimerCallback:(NSTimer *)timer {
    [recorder updateMeters];
    float volume = [recorder averagePowerForChannel:0];
    NSLog(@"tem barulho, nivel %f", volume);
    NSString *volumeString = [NSString stringWithFormat:@"%f", volume];
    [number setText:volumeString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
