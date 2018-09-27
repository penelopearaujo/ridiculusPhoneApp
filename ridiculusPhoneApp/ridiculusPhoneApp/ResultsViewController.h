//
//  ResultsViewController.h
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 20/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListeningViewController.h"

@interface ResultsViewController : UIViewController {
    int ;
}

@property (weak, nonatomic) IBOutlet UILabel *resultMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultScoreLabel;

@property (nonatomic) NSNumber *winnerFinalScore;
@property (nonatomic) int *winnerTeamNumber;


@end
