//
//  ViewController.h
//  BT490
//
//  Created by Elie SAAD on 12-01-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "OptionsViewController.h"

@interface SignInController : UIViewController <OptionsViewControllerDelegate, UITextFieldDelegate>
{
    UITextField *activeTextField;
}

@property (strong, nonatomic) NSMutableData *userData;
@property (strong, nonatomic) Player *player;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loginIndicator;
@property (strong, nonatomic) IBOutlet UILabel *errorMessageField;
@property (strong, nonatomic) NSURLConnection *connection;
@property (nonatomic, strong) OptionsViewController *optionsViewController;

-(IBAction)login:(id)sender;

@end
