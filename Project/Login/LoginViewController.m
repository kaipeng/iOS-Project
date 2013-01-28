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
    self.view.backgroundColor=[UIColor blueColor];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.view addGestureRecognizer:gestureRecognizer];
    //scroll up
    self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);
    return true;
}

- (void) hideKeyboard {
    [usernameField resignFirstResponder];
    [nameField resignFirstResponder];
    [passwordfield resignFirstResponder];
    [self.view removeGestureRecognizer:gestureRecognizer];
    self.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);

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
    [super viewDidUnload];
}
@end
