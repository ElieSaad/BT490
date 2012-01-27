//
//  OptionDetailsViewController.h
//  BT490
//
//  Created by Elie SAAD on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Option.h"

@class OptionDetailsViewController;

//Define a new delegate protocole used to communicate back from a 
//specific option screen to the complete list of options.
@protocol OptionDetailsViewControllerDelegate <NSObject>

- (void)optionDetailsViewControllerDidDone: (OptionDetailsViewController *)controller;

@end

@interface OptionDetailsViewController : UITableViewController

@property (strong, nonatomic) Option *optionToShow;
@property (nonatomic, weak) id <OptionDetailsViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
