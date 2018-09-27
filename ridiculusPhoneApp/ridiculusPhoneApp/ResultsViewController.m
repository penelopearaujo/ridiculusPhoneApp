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
    _resultMessageLabel.text = [NSString stringWithFormat:@"team %d won!", _winnerTeamNumber];
    _resultScoreLabel.text = [NSString stringWithFormat:@"%@ points", _winnerFinalScore];
}


@end
