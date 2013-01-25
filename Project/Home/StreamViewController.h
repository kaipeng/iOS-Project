//
//  StreamViewController.h
//  Project
//
//  Created by Kai Peng on 1/23/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//
@class MGScrollView, PhotoBox;

#import <UIKit/UIKit.h>
//#import "HomeViewController.h"

@interface StreamViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet MGScrollView *scroller;
- (PhotoBox *)photoAddBox;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parentScrollView:(UIScrollView *)psv headerScrollView:(UIScrollView *)hsv headerHeight:(int)hH navBarHeight:(int)nbh;
@end
