//
//  HeaderView.h
//  Project
//
//  Created by Kai Peng on 1/25/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import "A3ParallaxScrollView.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HeaderView : A3ParallaxScrollView <UIScrollViewDelegate>

@property (strong) UIImageView *imageViewSun;
@property  int headerHeight;
@property  int screenWidth;
@property  int pageCount;
@property  int screenHeight;
@property (strong) UIScrollView *parentScrollview;


- (id) initWithFrame:(CGRect)frame headerHeight:(int)headerHeight headerScale:(int)headerSize screenWidth:(int)screenWidth screenHeight:(int)screenHeight pageCount:(int)pageCount parentScrollView:(UIScrollView*)parentView;

-(void) rotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation ;
@end
