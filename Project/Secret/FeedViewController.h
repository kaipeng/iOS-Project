//
//  FeedViewController.h
//  Project
//
//  Created by Kai Peng on 1/29/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGScrollView.h"
#import "CameraViewController.h"
#import "PickerViewController.h"
#import "GetChute.h"

@interface FeedViewController : UIViewController <PhotoPickerPlusDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MGScrollView *feedScrollView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UISwitch *sliderSwitch;
- (IBAction)postButtonPushed:(id)sender;

@end
