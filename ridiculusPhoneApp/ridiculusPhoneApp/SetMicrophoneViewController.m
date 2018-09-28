//
//  SetMicrophoneViewController.m
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 18/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import "SetMicrophoneViewController.h"
#import "ListeningViewController.h"
#import "AppDelegate.h"


@interface SetMicrophoneViewController ()
@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation SetMicrophoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleReceivedDataWithNotification:)
                                                 name:@"MPCDemo_DidReceiveDataNotification"
                                               object:nil];
    
    
}

- (void)handleReceivedDataWithNotification:(NSNotification *)notification {
    // Get the user info dictionary that was received along with the notification.
    NSDictionary *userInfoDict = [notification userInfo];
    
    // Convert the received data into a NSString object.
    NSData *receivedData = [userInfoDict objectForKey:@"data"];
    NSString *message = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    
    if ([message isEqualToString:@"New Game"]) {
        NSLog(@"%@", message);
        [self performSegueWithIdentifier:@"setMicToListen" sender:self];
        NSLog(@"foi pra outra tela");
    } else {
        // determina numero de times
        NSLog(@"%@", message);
        int b = [message intValue];
        NSLog(@"numero de times %d", b);

        self.numberOfTeams = b;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//envia objetos para outra viewcontroller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"entrou em prepare for segue");
    if ([[segue identifier] isEqualToString:@"setMicToListen"]){
        ListeningViewController *ViewControllerObject = [segue destinationViewController];
        //ViewControllerObject.numberOfTeams = _numberOfTeams;
        NSLog(@"%d", self.numberOfTeams);
        ViewControllerObject.numberOfTeams = self.numberOfTeams;

    }
}

@end
