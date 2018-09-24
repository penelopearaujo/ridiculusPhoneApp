//
//  TeamsViewController.m
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 20/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import "TeamsViewController.h"
#import "SetMicrophoneViewController.h"

@interface TeamsViewController ()

@property (nonatomic) NSInteger *numberOfPeopleInt;
@property (nonatomic) NSInteger *numberOfTeamsInt;

@end

@implementation TeamsViewController

@synthesize numberTeamsTextField, questionLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)submitTeamsButton:(id)sender {
    //calcula numero de times
    NSString *inputTextField = [numberTeamsTextField text];
    _numberOfTeamsInt = [inputTextField integerValue]/3;
//    NSLog(@"numerooo %d\n", _numberOfPeopleInt); //checkpoint kkk

    //chama a segue para a próxima tela
    [self performSegueWithIdentifier:@"teamsToSetMicrophone" sender:self];
}

//envia objetos para outra viewcontroller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"teamsToSetMicrophone"]){
        SetMicrophoneViewController *ViewControllerObject = [segue destinationViewController];
        ViewControllerObject.numberOfTeams = _numberOfTeamsInt;
//        [ViewControllerObject setNumberOfTeams:20]; //faz a mesma coisa da linha anterior
    }
}

@end
