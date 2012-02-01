//
//  MainController.h
//  BT490
//
//  Created by Elie SAAD on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInController.h"

@interface MainController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *signInButton;
@property (nonatomic, strong) SignInController *signInController;

-(IBAction)signIn:(id)sender;

@end
