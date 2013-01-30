//
//  UploadPickerViewController.h
//  Project
//
//  Created by Kai Peng on 1/29/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCMultiImagePicker.h"

@interface UploadPickerViewController : GCMultiImagePicker

@property (strong) GCChute *chute;

-(void)uploadSelectedAssets;

@end