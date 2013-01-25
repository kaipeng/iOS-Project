//
//  HomeViewController.h
//  A3ParallaxScrollViewSample
//
//  Created by Botond Kis on 24.10.12.
//  Copyright (c) 2012 AllAboutApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A3ParallaxScrollView.h"
#import "StreamTableViewController.h"
#import "StreamViewController.h"
#import "MGScrollView.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>



@interface HomeViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate>

    @property (strong) HeaderView *scrollView;

    @property (strong) UITextView *topTextField;
    @property (strong) StreamTableViewController *streamTableViewController;
    @property (strong) StreamViewController *streamViewController;

    @property (strong) UIScrollView *tabScrollView;



@property (assign) int headerHeight;
- (void)initHeader;
@end
