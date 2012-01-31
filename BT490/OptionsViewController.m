//
//  OptionsViewController.m
//  BT490
//
//  Created by Elie SAAD on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionsViewController.h"
#import "Option.h"
#import "OptionCell.h"
#import "OptionDetailsViewController.h"


@implementation OptionsViewController

@synthesize options;
@synthesize delegate;
@synthesize player;
@synthesize welcomeLabel;
@synthesize welcomeText;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    options = [NSMutableArray arrayWithCapacity:20];
    Option *option = [[Option alloc] init];
    option.name = @"Achievements";
    option.value = @"...";
    option.idNum = 1;
    [options addObject:option];
    //
    option = [[Option alloc] init];
    option.name = @"Statistics";
    option.value = @"...";
    option.idNum = 2;
    [options addObject:option];
    //    
    option = [[Option alloc] init];
    option.name = @"Settings";
    option.value = @"...";
    option.idNum = 3;
    [options addObject:option];
    //    
    option = [[Option alloc] init];
    option.name = @"Search";
    option.value = @"...";
    option.idNum = 4;
    [options addObject:option];
    //  
    option = [[Option alloc] init];
    option.name = @"Store";
    option.value = @"...";
    option.idNum = 5;
    [options addObject:option];
    //
//    option = [[Option alloc] init];
//    option.name = @"Profile";
//    option.value = @"...";
//    option.idNum = 6;
//    option.dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", player.playerID],@"id", player.token, @"token", nil];
//    [options addObject:option];
    
    [self updateWelcomeLabel:welcomeText];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.options count];
}


-(UIImage *)imageForOption:(int)idNumber
{
    switch (idNumber) {
        case 1: //Achievements
            return [UIImage imageNamed:@"achievement.png"];
            break;
        case 2: //Statistics
            return [UIImage imageNamed:@"stats.png"];
            break;
        case 3: //Settings
            return [UIImage imageNamed:@"settings.png"];
            break;
        case 4: //Search
            return [UIImage imageNamed:@"search1.png"];
            break;
        case 5: //Store
            return [UIImage imageNamed:@"store.png"];
            break;    
//        case 6: //Profile
//            return [UIImage imageNamed:@"avatar.png"];
//            break; 
        default:
            break;
    }
    
    return nil;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"OptionCell";
    
    OptionCell *cell = (OptionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Option *option = [self.options objectAtIndex:indexPath.row];
    cell.nameLabel.text = option.name;
    cell.valueLabel.text = option.value;
    cell.optionImageView.image = [self imageForOption:option.idNum];
    

    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ViewOption"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        OptionDetailsViewController *optionDetailsViewController = [[navigationController viewControllers] objectAtIndex:0];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Option *option = [self.options objectAtIndex:indexPath.row];
        optionDetailsViewController.optionToShow = option;
        optionDetailsViewController.delegate = self;
        
    }
}

- (void)optionDetailsViewControllerDidDone:(OptionDetailsViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signOut:(id)sender
{
    //Add the sign out code: do a sign out request
    [self.delegate optionsViewControllerDidSignOut:self];
}

- (void)updateWelcomeLabel:(NSString *)theText
{
    welcomeLabel.text = theText;
}

@end
