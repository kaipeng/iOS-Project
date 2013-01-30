//
//  LoginViewController.m
//  Project
//
//  Created by Kai Peng on 1/25/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    UITapGestureRecognizer *gestureRecognizer;
}

@synthesize nameField, usernameField, passwordfield, signInButton, signInFacebookButton, forgotPasswordButton;

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
    /*
    int screenWidth = self.view.frame.size.width;
    int screenHeight = self.view.frame.size.height;
    tabScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    tabScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*3);
    tabScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabScrollView.showsHorizontalScrollIndicator = scrollView.showsVerticalScrollIndicator = NO;
    tabScrollView.pagingEnabled = YES;
    tabScrollView.directionalLockEnabled = YES;
    tabScrollView.delegate = self;
    tabScrollView.bounces = NO;
    UIImage *dirtImage = [UIImage imageNamed:@"bg_dirt.png"];
    tabScrollView.backgroundColor = [UIColor colorWithPatternImage:dirtImage];
    [self.view addSubview:tabScrollView];
    
    // init and set up the scrollview
    //scrollView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight*.7) headerHeight:screenHeight*.7 headerScale:1 screenWidth:screenWidth screenHeight:screenHeight pageCount:3 parentScrollView:tabScrollView];
    //Initialize buttons and scroller
 
    
    [self.view addSubview:self.tabScrollView];
    //[self.tabScrollView addSubview:self.scrollView];
     */


    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    nameField.delegate = self;
    usernameField.delegate = self;
    passwordfield.delegate = self;
    //self.view.backgroundColor=[UIColor blueColor];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.view addGestureRecognizer:gestureRecognizer];
    //scroll up
    self.view.frame = CGRectMake(0, -50, self.view.frame.size.width, self.view.frame.size.height);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view removeGestureRecognizer:gestureRecognizer];
    self.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if(textField == nameField)
        [usernameField becomeFirstResponder];
    if(textField == usernameField)
        [passwordfield becomeFirstResponder];
    if(textField == passwordfield){
        [self signInPushed:nil];
        [textField resignFirstResponder];
    }
    return NO;
}

- (void) hideKeyboard {
    [usernameField resignFirstResponder];
    [nameField resignFirstResponder];
    [passwordfield resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUsernameField:nil];
    [self setPasswordfield:nil];
    [self setSignInButton:nil];
    [self setSignInFacebookButton:nil];
    [self setForgotPasswordButton:nil];
    [self setNameField:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
}
- (IBAction)passwordChanged:(id)sender {
}


- (IBAction)signInPushed:(id)sender {
    [_activityIndicator startAnimating];

    [self logIn];
    /*PFQuery *query = [PFQuery queryWithClassName:@"UserLoginActionObject"];
    [query whereKey:@"email" equalTo:usernameField.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Error: email '%@' already exists %i time(s)", usernameField.text, objects.count);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User Already Exists"
                                                            message:@"An account has already been associated with this email. If it's yours, reset your password with <Forgot Password?>"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            //POPUP
        } else {
            // Log details of the failure
            NSLog(@"New user to be created: %@", usernameField.text);
            PFObject *userLoginActionObject = [PFObject objectWithClassName:@"UserLoginActionObject"];
            [userLoginActionObject setObject:usernameField.text forKey:@"email"];
            [userLoginActionObject setObject:passwordfield.text forKey:@"password"];
            [userLoginActionObject saveInBackground];
        }
    }];
     */
}

- (void) fbLogIn  {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"email", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self setUserInfo];
            [self dismissViewControllerAnimated:YES completion:^{
                [self presentModalViewController:[[UserSetupViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            }];
        } else {
            NSLog(@"User with facebook logged in!");
            [self setUserInfo];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];

}

- (void) setUserInfo {
    NSString *requestPath = @"me/?fields=name,email,location,education,work";
    PF_FBRequest *request = [PF_FBRequest requestForGraphPath:requestPath];
    [request startWithCompletionHandler:^(PF_FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // handle successful response
            NSDictionary *userData = (NSDictionary *)result; // The result is a dictionary
            NSLog(@"User Info Retrieved: %@", userData.descriptionInStringsFileFormat);
            
            [[PFUser currentUser] setEmail:userData[@"email"]];
            [[PFUser currentUser] setUsername:userData[@"email"]];
            [[PFUser currentUser] setObject:userData[@"location"][@"name"] forKey:@"location"];
            [[PFUser currentUser] setObject:userData[@"name"] forKey:@"name"];
            [[PFUser currentUser] setObject:userData[@"education"] forKey:@"education"];
            [[PFUser currentUser] setObject:userData[@"work"] forKey:@"work"];
            [[PFUser currentUser] save];
            
            PFQuery *query = [PFUser query];
            [query whereKey:@"username" equalTo:[[PFUser currentUser] username]];
            NSArray *usersData = [query findObjects];
            NSLog(@"User Info Retrieved: %@ %@", [usersData[0] username], [usersData[0] email]);
        } else {
            NSLog(@"Some error: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Setting User Info Failed"
                                                            message:error
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];

}

- (void) logIn {
    [PFUser logInWithUsernameInBackground:usernameField.text password:passwordfield.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Succeeded"
                                                                                            message:[NSString stringWithFormat:@"Logged in as: %@", user.username]
                                                                                           delegate:nil
                                                                                  cancelButtonTitle:@"OK"
                                                                                  otherButtonTitles:nil];
                                            
                                            [_activityIndicator stopAnimating]; // Hide loading indicator
                                            [alert show];
                                            [self dismissViewControllerAnimated:YES completion:nil];

                                        } else {
                                            // The login failed. Check error to see why.
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Failed"
                                                                                            message:error.description
                                                                                           delegate:nil
                                                                                  cancelButtonTitle:@"OK"
                                                                                  otherButtonTitles:nil];
                                            [_activityIndicator stopAnimating]; // Hide loading indicator
                                            [alert show];
                                        }
                                    }];

}

- (void) signUp {
    PFUser *user = [PFUser user];
    user.username = usernameField.text;
    user.password = passwordfield.text;
    user.email = usernameField.text;
    
    // other fields can be set just like with PFObject
    //[user setObject:@"415-392-0202" forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [self dismissViewControllerAnimated:YES completion:^{
                [self presentModalViewController:[[UserSetupViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            }];
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            // Show the errorString somewhere and let the user try again.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign Up Failed"
                                                            message:[NSString stringWithFormat:@"Error: %@", errorString]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)facebookSignInPushed:(id)sender {
    [_activityIndicator startAnimating];
    [self fbLogIn];
}
@end
