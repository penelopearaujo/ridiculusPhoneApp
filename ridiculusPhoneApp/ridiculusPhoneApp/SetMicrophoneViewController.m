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

- (IBAction)okListenButton:(id)sender {
    
    // segue para proxima tela
    [self performSegueWithIdentifier:@"setMicToListen" sender:self];
    
    
}
@end
