//
//  MainViewController.m
//  Project
//
//  Created by Kai Peng on 1/28/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //Check User
    if ([PFUser currentUser] && // Check if a user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) // Check if user is linked to Facebook
    {
        NSLog(@"User already logged in %@", [[PFUser currentUser] username]);
        
        NSLog(@"Checking session validity.");
        // Create request for user's Facebook data
        NSString *requestPath = @"me/?fields=name,location,email";
        
        PF_FBRequest *request = [PF_FBRequest requestForGraphPath:requestPath];
        [request startWithCompletionHandler:^(PF_FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                // handle successful response
                // Push the next view controller without animation
                NSLog(@"Session validated: %@ %@", [[PFUser currentUser] username], [[PFUser currentUser] email]);
                NSLog(@"Pushing home screen.");
                [self.navigationController pushViewController:[[FeedViewController alloc] init] animated:NO];
                
            } else if ([error.userInfo[PF_FBErrorParsedJSONResponseKey][@"body"][@"error"][@"type"] isEqualToString:@"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
                NSLog(@"The facebook session was invalidated");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Failed"
                                                                message:@"The facebook session was invalidated."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [PFUser logOut];
                [self showLoginScreen];
            } else {
                NSLog(@"Some other error: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Failed"
                                                                message:error
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [PFUser logOut];
                [self showLoginScreen];
            }
        }];
    }else{
        NSLog(@"New User!");
        [self showLoginScreen];
    }
    //NSLog(@"Pushing home screen.");
    //[self.navigationController pushViewController:[[FeedViewController alloc] init] animated:NO];
}

-(void)showLoginScreen {
    UIDevice *device = UIDevice.currentDevice;
    UIUserInterfaceIdiom phone = device.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    NSString *viewNibName = phone ? @"LoginView_iPhone" : @"LoginView_iPad";
    LoginViewController* loginViewController = [[LoginViewController alloc] initWithNibName:viewNibName bundle:nil];
    NSLog(@"User NOT logged in - Pushing login View.");
    [self presentModalViewController:loginViewController animated:YES];
    NSLog(@"Pushing home screen.");
    [self.navigationController pushViewController:[[FeedViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
