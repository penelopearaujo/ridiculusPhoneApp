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
    int count;
    NSInteger *i;
}

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic) NSInteger *numberOfTeams;
- (void) levelTimerCallback:(NSTimer *)timer;
- (void) updateMatchTimer;

@end
