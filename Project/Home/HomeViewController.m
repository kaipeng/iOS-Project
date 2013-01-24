//
//  HomeViewController.m
//  A3ParallaxScrollViewSample
//
//  Created by Botond Kis on 24.10.12.
//  Copyright (c) 2012 AllAboutApps. All rights reserved.
//

#import "HomeViewController.h"

//#import "UIImage+Color.h"
#import <QuartzCore/QuartzCore.h>

//#import "UITableView+ZGParallelView.h"


@implementation HomeViewController{
    BOOL phone;
    int headerHeight;

}

static int scrollViewWidthMultiplier = 4;
static float scrollViewHeightMultiplier = 1;
static float headerSize = .8;
static int grassBarHeight = 110;
static int mountainHeight = 160;

#define IPHONE_HEADER  .8
#define IPAD_HEADER  1.2
#define SCREEN_WIDTH self.view.frame.size.width

@synthesize scrollView;
@synthesize imageViewSun;
@synthesize topTextField;

@synthesize streamTableViewController;
@synthesize streamViewController;



- (void)viewDidLoad
{
    [super viewDidLoad];
    // iPhone or iPad?
    UIDevice *device = UIDevice.currentDevice;
    phone = device.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    headerSize = phone ? IPHONE_HEADER : IPAD_HEADER;
    headerHeight = headerSize*mountainHeight+grassBarHeight;
    
    // init and set up the scrollview
    scrollView = [[A3ParallaxScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*scrollViewWidthMultiplier, self.view.frame.size.height*scrollViewHeightMultiplier);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    scrollView.showsHorizontalScrollIndicator = scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.directionalLockEnabled = NO;
    scrollView.pagingEnabled = YES;
    scrollView.directionalLockEnabled = YES;
    //[scrollView addGestureRecognizer: addTarget:self action:@selector(backgroundTouch:) forControlEvents:(UIControlEvents) UIControlEventTouchDown];
    UIImage *dirtImage = [UIImage imageNamed:@"bg_dirt.png"];
    scrollView.backgroundColor = [UIColor colorWithPatternImage:dirtImage];

    [self.view addSubview:scrollView];
    

    /*
    // add background dirt image
    UIView *imageViewDirt = [[UIView alloc] init];
    imageViewDirt.backgroundColor = [UIColor colorWithPatternImage:dirtImage];
    //imageViewDirt.contentMode = UIViewContentModeScaleToFill;
     frameImageView = imageViewDirt.frame;
    frameImageView.origin.x = -SCREEN_WIDTH/2;
    frameImageView.origin.y = 165.0f*headerSize;
    frameImageView.size.width = scrollView.contentSize.width*1.5;
    frameImageView.size.height = scrollView.contentSize.height;
    imageViewDirt.frame = frameImageView;
    [scrollView addSubview:imageViewDirt withAcceleration:CGPointMake(1, 1)];
     */


    
    //ADD TABLE VIEWS HERE
    //Page 1
    NSString *streamViewNibName = phone ? @"StreamView_iPhone" : @"StreamView_iPad";
    streamViewController = [[StreamViewController alloc] initWithNibName:streamViewNibName bundle:nil];
    CGRect frameImageView = streamViewController.view.frame;
    frameImageView.origin.x = 0*SCREEN_WIDTH;
    frameImageView.origin.y = headerHeight;
    frameImageView.size.width = SCREEN_WIDTH;
    frameImageView.size.height = self.view.frame.size.height;
    streamViewController.view.frame = frameImageView;
    [scrollView addSubview:streamViewController.view withAcceleration:CGPointMake(1,1)];
    
    //Page 4
    streamTableViewController = [[StreamTableViewController alloc] init];
    frameImageView = streamTableViewController.view.frame;
    frameImageView.origin.x = 3*SCREEN_WIDTH;
    frameImageView.origin.y = headerHeight;
    frameImageView.size.width = SCREEN_WIDTH;
    frameImageView.size.height = self.view.frame.size.height;
    streamTableViewController.view.frame = frameImageView;
    [scrollView addSubview:streamTableViewController.view withAcceleration:CGPointMake(1,1)];
    
    
    
    //ADD TABLE VIEWS HERE
    
    [self initHeader];
}

- (void)initHeader{
    // add sky background
    UIImageView *imageViewSkyBackground = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_sky.png"]];
    imageViewSkyBackground.contentMode = UIViewContentModeRedraw;
    CGRect frameImageViewSky = imageViewSkyBackground.frame;
    frameImageViewSky.origin.x = -SCREEN_WIDTH*.3;
    frameImageViewSky.origin.y = -100;
    frameImageViewSky.size.width =SCREEN_WIDTH*(scrollViewWidthMultiplier+1);
    frameImageViewSky.size.height = (160+100)*headerSize;
    imageViewSkyBackground.frame = frameImageViewSky;
    [scrollView addSubview:imageViewSkyBackground withAcceleration:CGPointMake(1.0/scrollViewWidthMultiplier, 0.5f)];
    //[imageViewSkyBackground release];
    
    
    // add sun
    imageViewSun = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sun.png"]];
    imageViewSun.contentMode = UIViewContentModeScaleToFill;
    CGFloat mWitdh = SCREEN_WIDTH;
    CGRect frameImageViewSun = imageViewSun.frame;
    frameImageViewSun.size.height *= 0.30f*headerSize;
    frameImageViewSun.size.width *= 0.30f*headerSize;
    frameImageViewSun.origin.x = 0;
    frameImageViewSun.origin.y = frameImageViewSun.size.height*.6*headerSize;
    imageViewSun.frame = frameImageViewSun;
    //Sun glare shadow
    imageViewSun.layer.shadowColor = [UIColor yellowColor].CGColor;
    imageViewSun.layer.shadowOffset = CGSizeMake(0, 0);
    imageViewSun.layer.shadowOpacity = .8;
    imageViewSun.layer.shadowRadius = 20.0*headerSize;
    //imageViewSun.layer.clipsToBounds = NO;
    //Moon Min Y position depenent on number (6=>top sixth, 2=> top half)
    CGFloat xAccelMoon = -(mWitdh+frameImageViewSun.size.width/8.0f)/scrollView.contentSize.width*2.5/scrollViewWidthMultiplier;
    [scrollView addSubview:imageViewSun withAcceleration:CGPointMake(xAccelMoon, 0.3)];
    
    
    //// Add Mountains
    CGPoint mountainAccel;
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
        frameImageView.origin.x = i*(frameImageView.size.width+SCREEN_WIDTH/2.0)/20;
        frameImageView.origin.y = 0;
        frameImageView.size.height = mountainHeight*headerSize;
        imageViewMountain.frame = frameImageView;
        imageViewMountain.contentMode = UIViewContentModeScaleToFill;
        mountainAccel = CGPointMake(.3f/scrollViewWidthMultiplier*frameImageView.size.width/SCREEN_WIDTH, 0.5f);
        [scrollView addSubview:imageViewMountain withAcceleration:mountainAccel];
        //[imageViewMountain release];
    }
    
    UIImage *grassImage = [UIImage imageNamed:@"bg_grass.png"];
    UIImageView *imageViewShadow = [[UIImageView alloc]initWithImage:grassImage];
    CGRect frameImageView = imageViewShadow.frame;
    frameImageView.origin.x = -SCREEN_WIDTH/2;
    frameImageView.origin.y = mountainHeight*headerSize-3+grassBarHeight;
    frameImageView.size.width = SCREEN_WIDTH*(scrollViewWidthMultiplier+1);
    frameImageView.size.height = 4;
    imageViewShadow.frame = frameImageView;
    imageViewShadow.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewShadow.layer.shadowOffset = CGSizeMake(0, 5);
    imageViewShadow.layer.shadowOpacity = .6;
    imageViewShadow.layer.shadowRadius = 5;
    [scrollView addSubview:imageViewShadow withAcceleration:mountainAccel];
    //[imageViewShadow release];
    // get grass Image
    for (int i = -1; i < scrollViewWidthMultiplier*3+1; i++) {
        UIImageView *imageViewGrass = [[UIImageView alloc]initWithImage:grassImage];
        imageViewGrass.contentMode = UIViewContentModeScaleToFill;
        CGRect frameImageView = imageViewGrass.frame;
        frameImageView.origin.x = i*(SCREEN_WIDTH)/4;
        frameImageView.origin.y = mountainHeight*headerSize;
        frameImageView.size.width = SCREEN_WIDTH/(4);
        frameImageView.size.height = grassBarHeight;
        imageViewGrass.frame = frameImageView;
        
        [scrollView addSubview:imageViewGrass withAcceleration:mountainAccel];
        //[imageViewGrass release];
    }
    
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageViewLogo = [[UIImageView alloc]initWithImage:logoImage];
    frameImageView = imageViewLogo.frame;
    frameImageView.origin.x = SCREEN_WIDTH*(.5-.35*headerSize);
    frameImageView.origin.y = 15;
    frameImageView.size.width = SCREEN_WIDTH*.7*headerSize;
    frameImageView.size.height = 100*headerSize;
    imageViewLogo.contentMode = UIViewContentModeScaleAspectFit;
    imageViewLogo.frame = frameImageView;
    imageViewLogo.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewLogo.layer.shadowOffset = CGSizeMake(0, 3);
    imageViewLogo.layer.shadowOpacity = .4;
    imageViewLogo.layer.shadowRadius = 4;
    [scrollView addSubview:imageViewLogo withAcceleration:CGPointMake(0,.43f)];
    
    
    // Clouds
    UIImage *cloudsImage = [UIImage imageNamed:@"clouds_top.png"];
    
    for (int i = -1; i < SCREEN_WIDTH/320*scrollViewWidthMultiplier; i++) {
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
        
        [scrollView addSubview:imageViewCloud withAcceleration:CGPointMake(.7f, .7)];
        //[imageViewCloud release];
    }
    
    // middle
    int tabLabelY = 162*headerSize;
    UIImage *highlightImage = [UIImage imageNamed:@"highlight.png"];
    UIImageView *imageViewHighlight = [[UIImageView alloc]initWithImage:highlightImage];
    imageViewHighlight.contentMode = UIViewContentModeScaleToFill;
    frameImageView = imageViewHighlight.frame;
    frameImageView.origin.x = 0;
    frameImageView.origin.y = tabLabelY;
    frameImageView.size.height = 40;
    frameImageView.size.width = SCREEN_WIDTH/scrollViewWidthMultiplier+22;
    imageViewHighlight.frame = frameImageView;
    [scrollView addSubview:imageViewHighlight withAcceleration:CGPointMake(-.90/scrollViewWidthMultiplier, .5)];
    
    //CGFloat xAccelHighlight = -((SCREEN_WIDTH)/scrollView.contentSize.width);
    // add label
    NSArray *tabLabels = [NSArray arrayWithObjects:
                          @"Stream",
                          @"Media",
                          @"Convos",
                          @" Directory",
                          nil];
    for(int i = 0; i < 4; i++){
        CGRect buttonFrame = CGRectMake(i*SCREEN_WIDTH/scrollViewWidthMultiplier, tabLabelY, SCREEN_WIDTH/scrollViewWidthMultiplier+22, 40);
        UIButton *tabButton = [[UIButton alloc] initWithFrame:buttonFrame];
        NSLog(@"Button Seletor: goToTab_%i:",i);
        [tabButton addTarget:self action:NSSelectorFromString([NSString stringWithFormat:@"goToTab_%i:",i]) forControlEvents:(UIControlEvents) UIControlEventTouchUpInside];
        UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/scrollViewWidthMultiplier+22, 40)];
        [tabButton addSubview:labelText];
        labelText.backgroundColor = [UIColor clearColor];
        labelText.textAlignment = NSTextAlignmentCenter;
        labelText.textColor = [UIColor whiteColor];
        labelText.font = [UIFont systemFontOfSize:20];
        labelText.shadowColor = [UIColor brownColor];
        labelText.shadowOffset = CGSizeMake(0, 2);
        //Animate?
        labelText.text = tabLabels[i];
        
        [scrollView addSubview:tabButton withAcceleration:CGPointMake(.1/scrollViewWidthMultiplier, .5)];
        
        //[labelText release];
    }
    
    UIImage *profileImage = [UIImage imageNamed:@"profile.jpg"];
    UIImageView *imageViewProfile = [[UIImageView alloc]initWithImage:profileImage];
    frameImageView = imageViewProfile.frame;
    frameImageView.origin.x = 8;
    frameImageView.origin.y = (int)tabLabelY+42;
    frameImageView.size.width = 55.0;
    frameImageView.size.height = 55.0;
    imageViewProfile.contentMode = UIViewContentModeScaleAspectFit;
    imageViewProfile.frame = frameImageView;
    imageViewProfile.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewProfile.layer.shadowOffset = CGSizeMake(0, 3);
    imageViewProfile.layer.shadowOpacity = .4;
    imageViewProfile.layer.shadowRadius = 4;
    [scrollView addSubview:imageViewProfile withAcceleration:CGPointMake(0,.5)];
    
    UIImage *postImage = [UIImage imageNamed:@"header_signup.png"];
    UIImageView *imageViewPost = [[UIImageView alloc]initWithImage:postImage];
    frameImageView = imageViewPost.frame;
    frameImageView.origin.x = imageViewProfile.frame.origin.x+imageViewProfile.frame.size.width+8;
    frameImageView.origin.y = (int)tabLabelY+42;
    frameImageView.size.width = 242.0;
    frameImageView.size.height = 65.0;
    imageViewPost.contentMode = UIViewContentModeScaleToFill;
    imageViewPost.frame = frameImageView;
    imageViewPost.layer.shadowColor = [UIColor blackColor].CGColor;
    imageViewPost.layer.shadowOffset = CGSizeMake(0, 3);
    imageViewPost.layer.shadowOpacity = .4;
    imageViewPost.layer.shadowRadius = 4;
    [scrollView addSubview:imageViewPost withAcceleration:CGPointMake(0,.5)];
    
    topTextField = [[UITextView alloc]initWithFrame:CGRectMake(imageViewPost.frame.origin.x+6, (int)tabLabelY+42, 172, 50)];
    topTextField.alpha = .8;
    topTextField.font = [UIFont systemFontOfSize:14];
    topTextField.backgroundColor = [UIColor clearColor];
    topTextField.layer.shadowColor = [UIColor blackColor].CGColor;
    topTextField.layer.shadowOffset = CGSizeMake(0, 3);
    topTextField.layer.shadowOpacity = .4;
    topTextField.layer.shadowRadius = 4;
    [scrollView addSubview:topTextField withAcceleration:CGPointMake(0,.5)];
    
    
    // initial content offset position
    //scrollView.contentOffset = CGPointMake((scrollView.contentSize.width-scrollView.frame.size.width)/2.0f, 0);
    
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)backgroundTouch:(id)sender {
    [topTextField resignFirstResponder];
}

- (void) goToTab_0:(id)sender {
    [scrollView setContentOffset:CGPointMake(0*SCREEN_WIDTH, scrollView.contentOffset.y) animated:YES];
}
- (void) goToTab_1:(id)sender {
    [scrollView setContentOffset:CGPointMake(1*SCREEN_WIDTH, scrollView.contentOffset.y) animated:YES];
}
- (void) goToTab_2:(id)sender {
    [scrollView setContentOffset:CGPointMake(2*SCREEN_WIDTH, scrollView.contentOffset.y) animated:YES];
}
- (void) goToTab_3:(id)sender {
    [scrollView setContentOffset:CGPointMake(3*SCREEN_WIDTH, scrollView.contentOffset.y) animated:YES];
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
    CGFloat width = UIInterfaceOrientationIsLandscape(toInterfaceOrientation)?self.view.frame.size.height:SCREEN_WIDTH;
    
    CGFloat xAccelMoon = -(width+imageViewSun.frame.size.width/2.0f)/scrollView.contentSize.width;
    CGPoint accel = CGPointMake(xAccelMoon, 0.3f);
    
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










