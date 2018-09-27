//
//  SetMicrophoneViewController.m
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 18/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import "SetMicrophoneViewController.h"
#import "ListeningViewController.h"

@interface SetMicrophoneViewController ()

@end

@implementation SetMicrophoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *inStr = [NSString stringWithFormat:@"%ld", (long)_numberOfTeams];
    _numberTeamsLabel.text = inStr;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)okListenButton:(id)sender {
    // segue para proxima tela
    [self performSegueWithIdentifier:@"setMicToListen" sender:self];
}

//envia objetos para outra viewcontroller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"setMicToListen"]){
        ListeningViewController *ViewControllerObject = [segue destinationViewController];
        ViewControllerObject.numberOfTeams = _numberOfTeams;
    }
}

@end
