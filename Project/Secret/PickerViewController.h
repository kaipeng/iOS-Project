//
//  PickerViewController.h
//  Project
//
//  Created by Kai Peng on 1/29/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetChute.h"
#import "UploadPickerViewController.h"
#import "GCCloudGallery.h"
#import "GCConstants.h"

#import "PhotoPickerPlus.h"
#import "GCUploader.h"
#import "MyLineDrawingView.h"



@interface PickerViewController : UIViewController <PhotoPickerPlusDelegate> {
    bool firstTime;
    UIBarButtonItem *uploadButton;
    UIGestureRecognizer *tapGestureRecognizer;
    MyLineDrawingView *drawView;
    
}

@property (strong) IBOutlet UIView *PBForeground;
@property (strong) IBOutlet UIView *PBBackground;
-(IBAction)showUploader;
-(IBAction)showGallery;
@property (weak, nonatomic) IBOutlet UIButton *uploaderButton;
@property (weak, nonatomic) IBOutlet UIButton *galleryButton;
@property (strong) GCChute *chute;
@property (strong) GCChute *createdChute;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

+(UIImage*) drawDrawing:(UIView*) drawing inImage:(UIImage*)  image;
+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point;
@end
