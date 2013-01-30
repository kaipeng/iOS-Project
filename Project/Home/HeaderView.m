//
//  HeaderView.m
//  Project
//
//  Created by Kai Peng on 1/25/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView


@synthesize imageViewSun;
static int yAccel = 1;
static int grassBarHeight = 110;
static int mountainHeight;


- (id)initWithFrame:(CGRect)frame headerHeight:(int)headerHeight headerScale:(int)headerSize screenWidth:(int)screenWidth screenHeight:(int)screenHeight pageCount:(int)pageCount parentScrollView:(UIScrollView*)parentView
{
    self.parentScrollview = parentView;
    mountainHeight = headerHeight - grassBarHeight;
    self.headerHeight = headerHeight;
    self.screenWidth = screenWidth;
    self.screenHeight = screenHeight;
    self.pageCount = pageCount;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentSize = CGSizeMake(screenWidth*pageCount, headerHeight+10);
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.showsHorizontalScrollIndicator = self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.directionalLockEnabled = YES;
        self.scrollEnabled = YES;
        self.bounces = NO;
        self.delegate = self;

    // add sky background
    UIImageView *imageViewSkyBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_sky.png"]];
    imageViewSkyBackground.contentMode = UIViewContentModeRedraw;
    CGRect frameImageViewSky = imageViewSkyBackground.frame;
    frameImageViewSky.origin.x = -screenWidth*.3;
    frameImageViewSky.origin.y = -screenHeight/2;
    frameImageViewSky.size.width =screenWidth*(pageCount+1);
    frameImageViewSky.size.height = (screenHeight/2)+headerHeight;
    imageViewSkyBackground.frame = frameImageViewSky;
    [self addSubview:imageViewSkyBackground withAcceleration:CGPointMake(1.0/pageCount, yAccel)];
    //[imageViewSkyBackground release];
    
    
    // add sun
    imageViewSun = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sun.png"]];
    imageViewSun.contentMode = UIViewContentModeScaleToFill;
    CGFloat mWitdh = screenWidth;
    CGRect frameImageView = imageViewSun.frame;
    frameImageView.size.height = headerHeight/5;
    frameImageView.size.width = frameImageView.size.height;
    frameImageView.origin.x = 0;
    frameImageView.origin.y = frameImageView.size.height*.6;
    imageViewSun.frame = frameImageView;
    //Sun glare shadow
    imageViewSun.layer.shadowColor = [UIColor yellowColor].CGColor;
    imageViewSun.layer.shadowOffset = CGSizeMake(0, 0);
    imageViewSun.layer.shadowOpacity = .8;
    imageViewSun.layer.shadowRadius = frameImageView.size.width/2;
    //imageViewSun.layer.clipsToBounds = NO;
    //Moon Min Y position depenent on number (6=>top sixth, 2=> top half)
    CGFloat xAccelMoon = -(mWitdh+frameImageView.size.width/8.0f)/self.contentSize.width*2.5/pageCount;
    [self addSubview:imageViewSun withAcceleration:CGPointMake(xAccelMoon, yAccel*.8)];
    
    
    //// Add Mountains
    CGPoint mountainAccel;
    UIImage *mountains = [UIImage imageNamed:@"header_mountains.png"];
    UIImageView *imageViewMountain = [[UIImageView alloc]initWithImage:mountains];
    frameImageView = imageViewMountain.frame;
    int width = frameImageView.size.width*(mountainHeight/frameImageView.size.height);
    frameImageView.origin.x = -screenWidth/8;
    //frameImageView.origin.y = 0;
    frameImageView.size.height = mountainHeight;
    frameImageView.size.width = width;
    imageViewMountain.frame = frameImageView;
    imageViewMountain.contentMode = UIViewContentModeScaleAspectFill;
    mountainAccel = CGPointMake(.25f/pageCount*width/screenWidth, yAccel);
    [self addSubview:imageViewMountain withAcceleration:mountainAccel];
    //[imageViewMountain release];
    
    
    UIImage *grassImage = [UIImage imageNamed:@"bg_grass.png"];
    UIImageView *imageViewShadow = [[UIImageView alloc]initWithImage:grassImage];
    frameImageView = imageViewShadow.frame;
    frameImageView.origin.x = -screenWidth/2;
    frameImageView.origin.y = headerHeight-2;
    frameImageView.size.width = screenWidth*(pageCount+1);
    frameImageView.size.height = 4;
    imageViewShadow.frame = frameImageView;
    imageViewShadow.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewShadow.layer.shadowOffset = CGSizeMake(0, 2);
    imageViewShadow.layer.shadowOpacity = .6;
    imageViewShadow.layer.shadowRadius = 3;
    [self addSubview:imageViewShadow withAcceleration:mountainAccel];
    //[imageViewShadow release];
    // get grass Image
    for (int i = -1; i < pageCount*3+1; i++) {
        UIImageView *imageViewGrass = [[UIImageView alloc]initWithImage:grassImage];
        imageViewGrass.contentMode = UIViewContentModeScaleToFill;
        CGRect frameImageView = imageViewGrass.frame;
        frameImageView.origin.x = i*(screenWidth)/4;
        frameImageView.origin.y = mountainHeight;
        frameImageView.size.width = screenWidth/(4);
        frameImageView.size.height = grassBarHeight;
        imageViewGrass.frame = frameImageView;
        
        [self addSubview:imageViewGrass withAcceleration:mountainAccel];
        //[imageViewGrass release];
    }
    
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageViewLogo = [[UIImageView alloc]initWithImage:logoImage];
    frameImageView = imageViewLogo.frame;
    frameImageView.origin.x = screenWidth*(.5-.35*headerSize);
    frameImageView.origin.y = 15;
    frameImageView.size.width = screenWidth*.7*headerSize;
    frameImageView.size.height = 100*headerSize;
    imageViewLogo.contentMode = UIViewContentModeScaleAspectFit;
    imageViewLogo.frame = frameImageView;
    imageViewLogo.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewLogo.layer.shadowOffset = CGSizeMake(0, 3);
    imageViewLogo.layer.shadowOpacity = .4;
    imageViewLogo.layer.shadowRadius = 4;
    [self addSubview:imageViewLogo withAcceleration:CGPointMake(0,yAccel*.88)];
    
    
    // Clouds
    UIImage *cloudsImage = [UIImage imageNamed:@"clouds_top.png"];
    for (int i = -1; i < screenWidth/320*pageCount; i++) {
        UIImageView *imageViewCloud = [[UIImageView alloc]initWithImage:cloudsImage];
        imageViewCloud.contentMode = UIViewContentModeScaleToFill;
        CGRect frameImageView = imageViewCloud.frame;
        
        frameImageView.size.height = 120*headerSize;
        frameImageView.size.width = 1.5*320*headerSize;
        frameImageView.origin.x = i*(320*1.5)*headerSize;
        frameImageView.origin.y = 0;
        imageViewCloud.frame = frameImageView;
        imageViewCloud.layer.shadowColor = [UIColor blackColor].CGColor;
        imageViewCloud.layer.shadowOffset = CGSizeMake(0, 6);
        imageViewCloud.layer.shadowOpacity = .4;
        imageViewCloud.layer.shadowRadius = 5;
        
        [UIView animateWithDuration:40 delay:0 options:UIViewAnimationOptionRepeat+UIViewAnimationOptionCurveLinear animations:^{
            [imageViewCloud setFrame:CGRectMake(imageViewCloud.frame.origin.x+320*1.5*headerSize, 0, 320*1.5*headerSize, 120*headerSize)];
            
        } completion:nil];
        [self addSubview:imageViewCloud withAcceleration:CGPointMake(.7f, yAccel*.8)];
    }
    
    // initial content offset position
    //self.contentOffset = CGPointMake((self.contentSize.width-self.frame.size.width)/2.0f, 0);
    }
    return self;
}
    
    
    - (void)scrollViewDidScroll:(UIScrollView *)aScrollView{
        if(self.parentScrollview != nil){
            [self.parentScrollview setContentOffset:CGPointMake(aScrollView.contentOffset.x, self.parentScrollview.contentOffset.y)];
        }
        
            //scrollView.is
            // calc sun frame, let's make a nice wave :D
            float normalizedContentOffsetX = aScrollView.contentOffset.x;
            
            normalizedContentOffsetX /= (aScrollView.contentSize.width-aScrollView.bounds.size.width)/2;
            normalizedContentOffsetX = MIN(2, normalizedContentOffsetX);
            normalizedContentOffsetX = MAX(0, normalizedContentOffsetX);
            
            CGFloat yMultiplier = cosf(normalizedContentOffsetX*M_PI);
            
            // remember orig transform
            CGAffineTransform trans = imageViewSun.transform;
            
            // reset transform bacause frame won't return a useful frame if a transform is applied
            imageViewSun.transform = CGAffineTransformIdentity;
            
            // do calculation
            CGRect newSunFrame = imageViewSun.frame;
            newSunFrame.origin.y = newSunFrame.size.height*0.3f*yMultiplier + (newSunFrame.size.height*0.3f);
            
            // assign new frame
            imageViewSun.frame = newSunFrame;
            
            // apply original transform
            imageViewSun.transform = trans;
        
}

-(void) rotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
{
    // calc new sun acceleration
    CGFloat width = UIInterfaceOrientationIsLandscape(toInterfaceOrientation)?self.screenHeight : self.screenWidth;
    
    CGFloat xAccelMoon = -(width+imageViewSun.frame.size.width/2.0f)/self.contentSize.width;
    CGPoint accel = CGPointMake(xAccelMoon, .4);
    
    // set the new animation
    [self setAcceleration:accel forView:imageViewSun];
    
    // animate layout
    [UIView animateWithDuration:.5 animations:^{
        [self setNeedsLayout];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
    

@end
