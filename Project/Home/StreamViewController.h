//
//  StreamViewController.h
//  Project
//
//  Created by Kai Peng on 1/23/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//
@class MGScrollView, PhotoBox;

#import <UIKit/UIKit.h>

@interface StreamViewController : UIViewController

@property (nonatomic, weak) IBOutlet MGScrollView *scroller;
- (PhotoBox *)photoAddBox;

@end
