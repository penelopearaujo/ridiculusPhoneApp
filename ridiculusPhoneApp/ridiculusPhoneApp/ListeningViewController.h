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
    int i; //contador do time que está jogando. (substituir por playingTeam ou algo do tipo)
    int score[10]; //guarda os scores dos times (no máximo 10 times)
    NSMutableArray *totalScores; //array que guarda os scores também (pra comparar e dizer quem é o time vencedor)
    int winnerTeam; //número do time vencedor (o número vem de i)
    NSNumber *winnerTeamScore; //pontuacao do time vencedor
}

@property (nonatomic) NSInteger *numberOfTeams;
- (void) levelTimerCallback:(NSTimer *)timer;
- (void) setMic;
- (void) prepareTimer;
- (void) setWinner;

@end
