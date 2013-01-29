//
//  LoginViewController.h
//  Project
//
//  Created by Kai Peng on 1/25/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "HeaderView.h"
#import <Parse/Parse.h>
#import "UserSetupViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordfield;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signInFacebookButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)passwordChanged:(id)sender;
- (IBAction)signInPushed:(id)sender;
- (IBAction)facebookSignInPushed:(id)sender;

- (void) signUp;
- (void) logIn;
- (void) fbLogIn;

@end
