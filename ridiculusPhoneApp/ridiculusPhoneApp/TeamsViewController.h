//
//  TeamsViewController.h
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 20/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeamsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberTeamsTextField;
- (IBAction)submitTeamsButton:(id)sender;



@end

NS_ASSUME_NONNULL_END
