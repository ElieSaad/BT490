//
//  OptionsViewController.h
//  BT490
//
//  Created by Elie SAAD on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionDetailsViewController.h"
#import "Player.h"

@class OptionsViewController;

@protocol OptionsViewControllerDelegate <NSObject>

- (void)optionsViewControllerDidSignOut: (OptionsViewController *)controller;

@end

@interface OptionsViewController : UITableViewController <OptionDetailsViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *options;
@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;
@property (nonatomic, strong) NSString *welcomeText;
@property (nonatomic, weak) id <OptionsViewControllerDelegate> delegate;

- (IBAction)signOut:(id)sender;
- (void)updateWelcomeLabel:(NSString *)welcomeText;

@end
