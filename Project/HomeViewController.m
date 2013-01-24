//
//  HomeViewController.m
//  A3ParallaxScrollViewSample
//
//  Created by Botond Kis on 24.10.12.
//  Copyright (c) 2012 AllAboutApps. All rights reserved.
//

#import "HomeViewController.h"

#import "UIImage+Color.h"
#import <QuartzCore/QuartzCore.h>

//#import "UITableView+ZGParallelView.h"


@implementation HomeViewController

static int scrollViewWidthMultiplier = 4;
static float scrollViewHeightMultiplier = 3;

@synthesize scrollView;
@synthesize imageViewSun;

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    // init and set up the scrollview
    scrollView = [[A3ParallaxScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*scrollViewWidthMultiplier, self.view.frame.size.height*scrollViewHeightMultiplier+40);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    scrollView.showsHorizontalScrollIndicator = scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.directionalLockEnabled = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    
    [self.view addSubview:scrollView];
    
    UIImage *dirtImage = [UIImage imageNamed:@"bg_dirt.png"];
    // add background dirt image
    UIView *imageViewDirt = [[UIView alloc] init];
    imageViewDirt.backgroundColor = [UIColor colorWithPatternImage:dirtImage];
    //imageViewDirt.contentMode = UIViewContentModeScaleToFill;
    CGRect frameImageView = imageViewDirt.frame;
    frameImageView.origin.x = -self.view.frame.size.width/2;
    frameImageView.origin.y = 165.0f;
    frameImageView.size.width = scrollView.contentSize.width*1.5;
    frameImageView.size.height = scrollView.contentSize.height;
    
    imageViewDirt.frame = frameImageView;
    [scrollView addSubview:imageViewDirt withAcceleration:CGPointMake(1, 1)];
    //[imageViewDirt release];
    
    
    
    // add sky background
    UIImageView *imageViewSkyBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_sky.png"]];
    imageViewSkyBackground.contentMode = UIViewContentModeRedraw;
    CGRect frameImageViewSky = imageViewSkyBackground.frame;
    frameImageViewSky.origin.x = -100;
    frameImageViewSky.origin.y = -100;
    frameImageViewSky.size.width =self.view.frame.size.width*(scrollViewWidthMultiplier+1);
    frameImageViewSky.size.height = 160+100;
    imageViewSkyBackground.frame = frameImageViewSky;
    [scrollView addSubview:imageViewSkyBackground withAcceleration:CGPointMake(1.6f/scrollViewWidthMultiplier, 0.5f)];
    //[imageViewSkyBackground release];
    

    // add sun
    imageViewSun = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sun.png"]];
    imageViewSun.contentMode = UIViewContentModeScaleToFill;
    CGFloat mWitdh = self.view.frame.size.width;
    CGRect frameImageViewSun = imageViewSun.frame;
    frameImageViewSun.size.height *= 0.30f;
    frameImageViewSun.size.width *= 0.30f;
    frameImageViewSun.origin.x = 0;
    frameImageViewSun.origin.y = frameImageViewSun.size.height*.6;
    imageViewSun.frame = frameImageViewSun;
    //Sun glare shadow
     imageViewSun.layer.shadowColor = [UIColor yellowColor].CGColor;
     imageViewSun.layer.shadowOffset = CGSizeMake(0, 0);
     imageViewSun.layer.shadowOpacity = .8;
     imageViewSun.layer.shadowRadius = 20.0;
     //imageViewSun.layer.clipsToBounds = NO;
    //Moon Min Y position depenent on number (6=>top sixth, 2=> top half)
    CGFloat xAccelMoon = -(mWitdh+frameImageViewSun.size.width/8.0f)/scrollView.contentSize.width*2.5/scrollViewWidthMultiplier;
    [scrollView addSubview:imageViewSun withAcceleration:CGPointMake(xAccelMoon, 0.1)];
    

    //// Add Mountains
    UIImage *mountains = [UIImage imageNamed:@"header_mountains.png"];
    for (int i = -1; i < 0; i++) {
        UIImageView *imageViewMountain = [[UIImageView alloc]initWithImage:mountains];
        /*
        imageViewMountain.layer.shadowColor = [UIColor brownColor].CGColor;
        imageViewMountain.layer.shadowOffset = CGSizeMake(0, 4);
        imageViewMountain.layer.shadowOpacity = .5;
        imageViewMountain.layer.shadowRadius = 4.0;
                //imageViewMountain.layer.clipsToBounds = NO;
          */
        imageViewMountain.contentMode = UIViewContentModeScaleToFill;
        CGRect frameImageView = imageViewMountain.frame;
        frameImageView.origin.x = i*(frameImageView.size.width+self.view.frame.size.width/2.0)/20;
        frameImageView.origin.y = 0;
        frameImageView.size.height *= 0.5f;
        frameImageView.size.width *= 0.5f;
        imageViewMountain.frame = frameImageView;
        [scrollView addSubview:imageViewMountain withAcceleration:CGPointMake(1.6f/scrollViewWidthMultiplier, 0.5f)];
        //[imageViewMountain release];
    }
        /*
     imageViewMountain.layer.shadowColor = [UIColor brownColor].CGColor;
     imageViewMountain.layer.shadowOffset = CGSizeMake(0, 4);
     imageViewMountain.layer.shadowOpacity = .5;
     imageViewMountain.layer.shadowRadius = 4.0;
     //imageViewMountain.layer.clipsToBounds = NO;
     */
    // add background image
    /*//for (int i = -1; i < scrollViewWidthMultiplier+1; i++) {
        UIView *imageViewGrass = [[UIView alloc] init];
        imageViewGrass.backgroundColor = [UIColor colorWithPatternImage:grassImage];
        imageViewGrass.contentMode = UIViewContentModeScaleToFill;
        CGRect frameImageView = imageViewGrass.frame;
        frameImageView.origin.x = -self.view.frame.size.width;
        frameImageView.origin.y = 162.0f;
        frameImageView.size.width = self.view.frame.size.width*(scrollViewWidthMultiplier+1);
        frameImageView.size.height = self.view.frame.size.height/10;
        
        imageViewGrass.frame = frameImageView;
        [scrollView addSubview:imageViewGrass withAcceleration:CGPointMake(1.6f/scrollViewWidthMultiplier, 0.5f)];
        [imageViewGrass release];
    //}
    */
    UIImage *grassImage = [UIImage imageNamed:@"bg_grass.png"];
    UIImageView *imageViewShadow = [[UIImageView alloc]initWithImage:grassImage];
    frameImageView = imageViewShadow.frame;
    frameImageView.origin.x = -self.view.frame.size.width/2;
    frameImageView.origin.y = 220;
    frameImageView.size.width = self.view.frame.size.width*(scrollViewWidthMultiplier+1);
    frameImageView.size.height = 4;
    imageViewShadow.frame = frameImageView;
    imageViewShadow.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewShadow.layer.shadowOffset = CGSizeMake(0, 5);
    imageViewShadow.layer.shadowOpacity = .6;
    imageViewShadow.layer.shadowRadius = 5;
    [scrollView addSubview:imageViewShadow withAcceleration:CGPointMake(1,.5f)];
    //[imageViewShadow release];
    // get grass Image

    for (int i = -1; i < scrollViewWidthMultiplier*3+1; i++) {
        UIImageView *imageViewGrass = [[UIImageView alloc]initWithImage:grassImage];
        imageViewGrass.contentMode = UIViewContentModeScaleToFill;
        CGRect frameImageView = imageViewGrass.frame;
        frameImageView.origin.x = i*(self.view.frame.size.width)/4;
        frameImageView.origin.y = 162;
        frameImageView.size.width = self.view.frame.size.width/(4);
        frameImageView.size.height = 62;
        imageViewGrass.frame = frameImageView;
         
        [scrollView addSubview:imageViewGrass withAcceleration:CGPointMake(1.6f/scrollViewWidthMultiplier, 0.5f)];
        //[imageViewGrass release];
    }
    
     // Clouds
     UIImage *cloudsImage = [UIImage imageNamed:@"clouds_top.png"];
     for (int i = -1; i < scrollViewWidthMultiplier; i++) {
         UIImageView *imageViewCloud = [[UIImageView alloc]initWithImage:cloudsImage];
         imageViewCloud.contentMode = UIViewContentModeScaleToFill;
         CGRect frameImageView = imageViewCloud.frame;
         
         frameImageView.size.height = 120;
         frameImageView.size.width = self.view.frame.size.width*1.5;
         frameImageView.origin.x = i*(self.view.frame.size.width*1.5);
         frameImageView.origin.y = 0;
         imageViewCloud.frame = frameImageView;
         
         [UIView animateWithDuration:40 delay:0 options:UIViewAnimationOptionRepeat+UIViewAnimationOptionCurveLinear animations:^{
             /*imageViewCloud.transform = CGAffineTransformTranslate(imageViewCloud.transform, self.view.frame.size.width/scrollViewWidthMultiplier+imageViewCloud.frame.origin.x, self.view.frame.size.width/scrollViewWidthMultiplier+imageViewCloud.frame.origin.x);
              */
             [imageViewCloud setFrame:CGRectMake(imageViewCloud.frame.origin.x+self.view.frame.size.width*1.5, 0, self.view.frame.size.width*1.5, 120)];
             
         } completion:nil];
         
         [scrollView addSubview:imageViewCloud withAcceleration:CGPointMake(.7f, .7)];
         //[imageViewCloud release];
     }
     
    /*
    // middle
    UIImage *middleTreeImage = [UIImage imageNamed:@"leafys.png"];
    for (int i = -1; i < scrollViewWidthMultiplier/2; i++) {
        UIImageView *imageViewTree = [[UIImageView alloc]initWithImage:middleTreeImage];
        imageViewTree.contentMode = UIViewContentModeScaleToFill;
        CGRect frameImageView = imageViewTree.frame;
        frameImageView.origin.x = i*(frameImageView.size.width+self.view.frame.size.width/2.0)/scrollViewWidthMultiplier*2;
        frameImageView.origin.y = 300;
        frameImageView.size.height *= 0.90f;
        frameImageView.size.width *= 0.90f;
        imageViewTree.frame = frameImageView;
        [scrollView addSubview:imageViewTree withAcceleration:CGPointMake(0.6f, 0.6f)];
        [imageViewTree release];
    }
     */
    /*
    // near
    UIImage *treeImage = [UIImage imageNamed:@"header_mountains.png"];
    for (int i = -1; i < scrollViewWidthMultiplier*6+1; i++) {
        UIImageView *imageViewTree = [[UIImageView alloc]initWithImage:treeImage];
        imageViewTree.contentMode = UIViewContentModeScaleToFill;
        CGRect frameImageView = imageViewTree.frame;
        frameImageView.origin.x = i*(frameImageView.size.width+backgroundImage.size.width+self.view.frame.size.width/2.0)/6;
        frameImageView.origin.y = 400;
        frameImageView.size.height *= 1.0f;
        frameImageView.size.width *= 1.0f;
        imageViewTree.frame = frameImageView;
        [scrollView addSubview:imageViewTree withAcceleration:CGPointMake(0.8f, 0.8f)];
        [imageViewTree release];
    }
     */
    // middle
    UIImage *highlightImage = [UIImage imageNamed:@"highlight.png"];
    UIImageView *imageViewHighlight = [[UIImageView alloc]initWithImage:highlightImage];
    imageViewHighlight.contentMode = UIViewContentModeScaleToFill;
    frameImageView = imageViewHighlight.frame;
    frameImageView.origin.x = -5;
    frameImageView.origin.y = 155;
    frameImageView.size.height = 40;
    frameImageView.size.width = self.view.frame.size.width/scrollViewWidthMultiplier+22;
    imageViewHighlight.frame = frameImageView;
    [scrollView addSubview:imageViewHighlight withAcceleration:CGPointMake(-.93/scrollViewWidthMultiplier, .5)];
    
    //CGFloat xAccelHighlight = -((self.view.frame.size.width)/scrollView.contentSize.width);
    // add label
    NSArray *tabLabels = [NSArray arrayWithObjects:
                          @"Stream",
                          @"Convos",
                          @" Photos",
                          @"Directory",
                          nil];
    for(int i = 0; i < 4; i++){
        UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(15+i*self.view.frame.size.width/scrollViewWidthMultiplier, 160, self.view.frame.size.width, 40)];
        labelText.backgroundColor = [UIColor clearColor];
        labelText.textAlignment = NSTextAlignmentCenter;
        labelText.textColor = [UIColor whiteColor];
        labelText.font = [UIFont systemFontOfSize:20];
        labelText.shadowColor = [UIColor brownColor];
        labelText.shadowOffset = CGSizeMake(0, 2);
        //Animate?
        labelText.text = tabLabels[i];
        [labelText sizeToFit];
        [scrollView addSubview:labelText withAcceleration:CGPointMake(.1/scrollViewWidthMultiplier, .5)];
        
        //[labelText release];
    }

    
    // initial content offset position
    //scrollView.contentOffset = CGPointMake((scrollView.contentSize.width-scrollView.frame.size.width)/2.0f, 0);
}



- (void)viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)dealloc {
    [super dealloc];
    [scrollView release];
    [imageViewSun release];
}*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{    
    return NO;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    // calc new sun acceleration
    CGFloat width = UIInterfaceOrientationIsLandscape(toInterfaceOrientation)?self.view.frame.size.height:self.view.frame.size.width;
    
    CGFloat xAccelMoon = -(width+imageViewSun.frame.size.width/2.0f)/scrollView.contentSize.width;
    CGPoint accel = CGPointMake(xAccelMoon, 0.0f);
    
    // set the new animation
    [scrollView setAcceleration:accel forView:imageViewSun];
    
    // animate layout
    [UIView animateWithDuration:duration animations:^{
        [scrollView setNeedsLayout];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView{
    
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

@end










