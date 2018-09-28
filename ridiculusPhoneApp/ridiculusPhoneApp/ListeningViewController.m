//
//  ListeningViewController.m
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 18/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import "ListeningViewController.h"
#import "ResultsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"


@interface ListeningViewController ()
@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation ListeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"numero de times %d", self.numberOfTeams);

    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [self prepareTimer];
    totalScores = [NSMutableArray new];
    
}


- (void) prepareTimer {
    // conta 4 segundos e, após 4 segundos, chama a funçao de começar a partida
    NSLog(@"entrou no prepare");
    matchTimer = [NSTimer scheduledTimerWithTimeInterval:4 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self startMatchTimer];
    }];
}

- (void) correctingBugTimer {
    matchTimer = [NSTimer scheduledTimerWithTimeInterval:4 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self performSegueWithIdentifier:@"listenToResult" sender:self];
    }];
}


- (void) startMatchTimer {
    // timer da partida. enquanto conta 1:30, escuta o barulho do ambiente. depois de 1:30, para de ouvir, registra a pontuacao do time e vai pro próximo time. se for o último time, chama a tela de resultado.
    
    NSLog(@"team number %d is playing", i);
    matchTimer = [NSTimer scheduledTimerWithTimeInterval:90 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self stopListeningMic];
        [totalScores addObject:[NSNumber numberWithInt:score[i]]]; //coloca o score do time num array
        NSLog(@"totsl scores:%@", self->totalScores);
        NSLog(@"team %d, score: %d", i, score[i]);
        i++;
        if (i<self.numberOfTeams){
            [self prepareTimer];
        } else {
            [self setWinner];
            [self correctingBugTimer];
        }
    }];
    [self setMic];
    [self listenMic];
    return;
}

- (void) setMic {
    //setting microphone for listening
    AVAudioSession *recordingSession = [AVAudioSession sharedInstance];
    NSError *error;
    [recordingSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    [recordingSession setActive:TRUE error:&error];
    [recordingSession requestRecordPermission:^(BOOL granted) {
        if (granted){
            return;
        } else {
            NSLog(@"Error!");
        }
    }];
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
            [recorder recordForDuration:90];
            levelTimer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
        } else {
            NSLog(@"%@", [error description]);
        }
    }
}

- (void)stopListeningMic {
    //stops the recording and mic listening
    [recorder stop];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (void)levelTimerCallback:(NSTimer *)timer {
    [recorder updateMeters];
    float volume = [recorder averagePowerForChannel:0];
    volume = volume*(-1);
    int volumeInt = (int) volume;
//    NSLog(@"tem barulho, nivel %f", volume);
    NSLog(@"tem barulho, nivel %d", volumeInt);
    score[i] = score[i]+volumeInt;
    
    // manda valor atual pra TV
    NSString *currentValue = [NSString stringWithFormat:@"r%d", volumeInt];
    NSLog(@"%@", currentValue);
    NSData *currentValueAsData = [currentValue dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    
    [self.appDelegate.mpcHandler.session sendData:currentValueAsData
                                          toPeers:self.appDelegate.mpcHandler.session.connectedPeers
                                         withMode:MCSessionSendDataReliable
                                            error:&error];
    
    // exibe na tela do iphone o volume registrado
    NSString *volumeString = [NSString stringWithFormat:@"%f", volume];
    [number setText:volumeString];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // envia para a tela seguinte quem é o vencedor do jogo
    if ([[segue identifier] isEqualToString:@"listenToResult"]){
        // chama função que envia dados do time vencedor para a TV
        [self sendData];
        ResultsViewController *ViewControllerObject = [segue destinationViewController];
        ViewControllerObject.winnerFinalScore = winnerTeamScore;
        ViewControllerObject.winnerTeamNumber = winnerTeam;
    }
}

- (void) sendData {
    // envia qual time vencedor
    NSString *winner = [[NSNumber numberWithInt:winnerTeam] stringValue];
    NSLog(@"%@", winner);
    NSData *winnerAsData = [winner dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    
    [self.appDelegate.mpcHandler.session sendData:winnerAsData
                                          toPeers:self.appDelegate.mpcHandler.session.connectedPeers
                                         withMode:MCSessionSendDataReliable
                                            error:&error];
    // envia qual o score do time vencedor
    NSString *winnerScore = [[NSNumber numberWithInt:winnerTeamScore] stringValue];
    NSLog(@"%@", winnerScore);
    NSData *winnerScoreAsData = [winnerScore dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error2;
    
    [self.appDelegate.mpcHandler.session sendData:winnerScoreAsData
                                          toPeers:self.appDelegate.mpcHandler.session.connectedPeers
                                         withMode:MCSessionSendDataReliable
                                            error:&error2];
}

- (void) setWinner {
    // calcula qual o time vencedor. a funcao chamada é min.self porque a conversao de decibeis para pontos é feita de forma que quem soma menos pontos é o vencedor (será que isso faz sentido)
    winnerTeamScore = [totalScores valueForKeyPath:@"@min.self"];
    winnerTeam = [totalScores indexOfObject:winnerTeamScore]+1;
    NSLog(@"%@", winnerTeamScore);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
