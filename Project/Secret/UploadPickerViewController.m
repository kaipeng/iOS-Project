//
//  UploadPickerViewController.m
//  Project
//
//  Created by Kai Peng on 1/29/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import "UploadPickerViewController.h"

@interface UploadPickerViewController ()

@end

@implementation UploadPickerViewController
@synthesize chute;

-(void)uploadSelectedAssets{
    if([[self selectedImages] count] == 0)
        return;
    //for( in self.selectedImages){
        
    //}
    GCParcel *parcel = [GCParcel objectWithAssets:[self selectedImages] andChutes:[NSArray arrayWithObject:[self chute]]];
    [[GCUploader sharedUploader] addParcel:parcel];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    UIBarButtonItem *uploadButton = [[UIBarButtonItem alloc] initWithTitle:@"Upload" style:UIBarButtonItemStylePlain target:self action:@selector(uploadSelectedAssets)];
    self.navigationItem.rightBarButtonItem = uploadButton;
}
@end
