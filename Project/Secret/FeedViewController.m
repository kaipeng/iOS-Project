//
//  FeedViewController.m
//  Project
//
//  Created by Kai Peng on 1/29/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

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
    // Do any additional setup after loading the view from its nib.
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadsFinished:) name:GCUploaderFinished object:nil];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPostButton:nil];
    [self setSliderSwitch:nil];
    [self setFeedScrollView:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
}
- (IBAction)postButtonPushed:(id)sender {
    [self popupSelector];
}

-(void)popupSelector {
    PhotoPickerPlus *temp = [[PhotoPickerPlus alloc] init];
    [temp setDelegate:self];
    [temp setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self presentViewController:temp animated:YES completion:^(void){
        //[self dismissModalViewControllerAnimated:YES];
    }];
}

-(void) PhotoPickerPlusControllerDidCancel:(PhotoPickerPlus *)picker{
    //cancel code
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        
    }];
    
}
-(void) PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //image picked code
    [self dismissViewControllerAnimated:YES completion:^(void){
        PickerViewController *pickerView = [[PickerViewController alloc] init];

        [self presentModalViewController:[[UINavigationController alloc] initWithRootViewController:pickerView] animated:YES];
        [[pickerView selectedImageView] setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        //[[self selectedImageView] setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    }];
    
}
@end
