//
//  ViewController.h
//  ridiculusPhoneApp
//
//  Created by Penélope Araújo on 18/09/18.
//  Copyright © 2018 Penélope Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface ConnectViewController : UIViewController <MCBrowserViewControllerDelegate>
- (IBAction)connectButton:(id)sender;


@end

