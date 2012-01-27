//
//  ViewController.m
//  BT490
//
//  Created by Elie SAAD on 12-01-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//Macro for a background queue
#define BTBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "SignInController.h"
#import "Reachability.h"

@implementation SignInController

@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize loginButton;
@synthesize loginIndicator;
@synthesize errorMessageField;
@synthesize userData;
@synthesize player;
@synthesize connection;
@synthesize optionsViewController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    connection = nil;
    usernameTextField.delegate = self;
    passwordTextField.delegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [self setLoginButton:nil];
    [self setLoginIndicator:nil];
    [self setErrorMessageField:nil];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSString *)stringFromStatus:(NetworkStatus) status 
{
    NSString *string;
    switch(status) {
        case NotReachable:
            string = @"Not Reachable";
            break;
        case ReachableViaWiFi:
            string = @"Reachable via WiFi";
            break;
        case ReachableViaWWAN:
            string = @"Reachable via WWAN";
            break;
        default:
            string = @"Unknown";
            break;
    }
    return string;
}

-(IBAction)login:(id)sender
{
    loginIndicator.hidden = FALSE; //Show the activity indicator
    [loginIndicator startAnimating];
    
    loginButton.enabled = FALSE; //Disable login button
    
    Reachability *reach = [[Reachability reachabilityWithHostName:@"www.blueteam490.com"] init];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    NSString *statusMessage = [self stringFromStatus:status];
    
    if ([statusMessage isEqualToString:@"Unknown"] || 
        [statusMessage isEqualToString:@"Not Reachable"] 
//        ||
//        [statusMessage isEqualToString:@"Reachable via WiFi"] || 
//        [statusMessage isEqualToString:@"Not Reachable"]
        ) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Internet Connection"
                              message:statusMessage
                              delegate:self 
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        
        [alert show];
        [loginIndicator stopAnimating];
        loginIndicator.hidden = TRUE;
        loginButton.enabled = TRUE; //Reenable the login button
    }
    else if (usernameTextField.text.length == 0 || passwordTextField.text.length == 0) {
        errorMessageField.text = @"Please enter a valid username and/or password";
    }
    else 
    {
        userData = [[NSMutableData alloc] init];
        
        //Post request to authenticate the user
        NSMutableString *requestBody = [[NSMutableString alloc] init];
        [requestBody appendString:[NSString stringWithFormat:@"id=%@&password=%@", usernameTextField.text, passwordTextField.text]];
        NSString *post = [NSString stringWithString:requestBody];
        
        NSData *postData = [NSData dataWithBytes:[post UTF8String] length:[post length]];
        //NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        //NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://www.blueteam490.com"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"/CreateAuthToken" forHTTPHeaderField:@"action"];
        //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        
        [request setHTTPBody:postData];
    
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //Asynchronous call
    
        if(connection)
        {
            errorMessageField.text = @"Connection established!";
                
        }
        else
        {
            NSLog(@"The Connection is NULL");
            errorMessageField.text = @"No connection is established!";
        }
    }
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
    return request;
}

// the delegate methods templates...

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [userData setLength:0];  // clear the data in case it was a redirect in between.
}

//Method called when data has been received
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [userData appendData:data];  // collect the data from server as it comes in.
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Error code
}

-(void)fetchedData:(NSData *)responseData //(OptionsViewController *)controller 
{
    //Parse the json data
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if (!error) {
        NSString *userId = [json objectForKey:@"id"];
        NSString *token = [json objectForKey:@"token"];
        optionsViewController.player.name = [NSString stringWithString:userId];
        optionsViewController.player.token = [NSString stringWithString:token];
        errorMessageField.text = [NSString stringWithString:optionsViewController.player.name];
    }

}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //
    
    NSString *response = [[[NSString alloc] initWithData:userData encoding:NSUTF8StringEncoding] copy];
    if (response.length >= 1) 
    {
        player.authenticated = TRUE;
        errorMessageField.text = response;//@"Player is authenticated";
        
        UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"BT490NavigationController"];
        
        optionsViewController = [[navigationController viewControllers] objectAtIndex:0];//[self.storyboard instantiateViewControllerWithIdentifier:@"BT490"];
        optionsViewController.delegate = self;
        optionsViewController.player = [[Player alloc] init];
        optionsViewController.player.name = [[NSString alloc] initWithString:usernameTextField.text];
        
        optionsViewController.welcomeText = [NSString stringWithFormat:@"Welcome %@", optionsViewController.player.name];
        dispatch_async(BTBgQueue, ^{ 
            NSData *data = [NSData dataWithData:userData];
            [self fetchedData:data];
            //[self performSelectorOnMainThread:@selector(fetchedData:)withObject:data waitUntilDone:YES];
        });
        //[self fetchedData:optionsViewController];
//        if (userData.length >= 1) {
//            dispatch_async(BTBgQueue, ^{
//                [self performSelectorOnMainThread:@selector(fetchedData:)withObject:userData waitUntilDone:YES];
//            });
//        }
        
        [self.navigationController presentModalViewController:navigationController animated:YES];
    }
    else
    {
        player.authenticated = FALSE;
        errorMessageField.text = @"Player not authenticated, please try again!";
    }
    
    // Once this method is invoked, "userData" contains the complete result
    [loginIndicator stopAnimating];
    loginIndicator.hidden = TRUE;
    loginButton.enabled = TRUE; //Reenable the login button
}


//Delegate methods to complete the sign out and close the screen
- (void)optionsViewControllerDidSignOut:(OptionsViewController *)controller
{
    errorMessageField.text = @"Please SignIn to access your Profile";
    usernameTextField.text = nil;
    passwordTextField.text = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SignIn"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        optionsViewController = [[navigationController viewControllers] objectAtIndex:0];
        optionsViewController.delegate = self;
    }
}

//Show/hide the keyboard
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    activeTextField = textField;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {   
    [textField resignFirstResponder]; 
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    activeTextField = nil;
    [textField resignFirstResponder];
    return YES;
}

@end
