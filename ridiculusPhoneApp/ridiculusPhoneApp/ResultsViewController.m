//
//  ResultsViewController.m
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 20/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import "ResultsViewController.h"
#import "ListeningViewController.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // shows winner team
    _resultMessageLabel.text = [NSString stringWithFormat:NSLocalizedString(@"team %d won!", nil), _winnerTeamNumber];
    _resultScoreLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ points", nil), _winnerFinalScore];
}


@end
