//
//  ListeningViewController.h
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 18/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>


@interface ListeningViewController : UIViewController {
    AVAudioRecorder *recorder;
    NSTimer *levelTimer;
    
    __weak IBOutlet UILabel *number;
    
    NSTimer *matchTimer;
    int totalSeconds;
    int i;
    int score[10];
}

@property (nonatomic) NSInteger *numberOfTeams;
- (void) levelTimerCallback:(NSTimer *)timer;
- (void) updateMatchTimer;
- (void) setMic;
- (void) teamTimer;

@end
