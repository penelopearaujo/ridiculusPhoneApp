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
            levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
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

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self listenMic];
    
    AVAudioSession *recordingSession = [AVAudioSession sharedInstance];
    NSError *error;
    [recordingSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    [recordingSession setActive:TRUE error:&error];
    [recordingSession requestRecordPermission:^(BOOL granted) {
        if (granted){
            [self listenMic];
        } else {
            NSLog(@"deu ruim");
        }
    }];
    
//    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
//        if (granted) {
//            [self listenMic];
//        }
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
