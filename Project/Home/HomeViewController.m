//
//  HomeViewController.m
//  A3ParallaxScrollViewSample
//
//  Created by Botond Kis on 24.10.12.
//  Copyright (c) 2012 AllAboutApps. All rights reserved.
//

#import "HomeViewController.h"

//#import "UIImage+Color.h"

//#import "UITableView+ZGParallelView.h"


@implementation HomeViewController{
    BOOL phone;
    UITapGestureRecognizer *gestureRecognizer;
    NSMutableArray *scrollViewsByTab;
    int SCREEN_WIDTH;
}

static int scrollViewWidthMultiplier = 4;
static float scrollViewHeightMultiplier = 1;
static float headerSize = .8;
static int grassBarHeight = 110;
static int mountainHeight = 160;
static int yAccel = 1;

#define IPHONE_HEADER  .8
#define IPAD_HEADER  1.2

@synthesize scrollView, topTextField, headerHeight, tabScrollView;

@synthesize streamTableViewController;
@synthesize streamViewController;

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self.view addGestureRecognizer:gestureRecognizer];
    return true;
}

- (void) hideKeyboard {
    [topTextField resignFirstResponder];
    [self.view removeGestureRecognizer:gestureRecognizer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    SCREEN_WIDTH = self.view.frame.size.width;
    
    // iPhone or iPad?
    UIDevice *device = UIDevice.currentDevice;
    phone = device.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    headerSize = phone ? IPHONE_HEADER : IPAD_HEADER;
    headerHeight = headerSize*mountainHeight+grassBarHeight;
    
    tabScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    tabScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*scrollViewWidthMultiplier, self.view.frame.size.height*scrollViewHeightMultiplier);
    tabScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tabScrollView.showsHorizontalScrollIndicator = scrollView.showsVerticalScrollIndicator = NO;
    tabScrollView.pagingEnabled = YES;
    tabScrollView.directionalLockEnabled = YES;
    tabScrollView.delegate = self;
    tabScrollView.bounces = NO;
    UIImage *dirtImage = [UIImage imageNamed:@"bg_dirt.png"];
    tabScrollView.backgroundColor = [UIColor colorWithPatternImage:dirtImage];
    [self.view addSubview:tabScrollView];
    
    // init and set up the scrollview
    scrollView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight+10) headerHeight:headerHeight headerScale:headerSize screenWidth:SCREEN_WIDTH screenHeight:self.view.height pageCount:scrollViewWidthMultiplier parentScrollView:tabScrollView];
    //Initialize buttons and scroller
    [self initHeader];
    
    //ADD TABLE VIEWS HERE
    //Page 1
    NSString *streamViewNibName = phone ? @"StreamView_iPhone" : @"StreamView_iPad";
    streamViewController = [[StreamViewController alloc] initWithNibName:streamViewNibName bundle:nil parentScrollView:tabScrollView headerScrollView:scrollView headerHeight:self.headerHeight navBarHeight:grassBarHeight];
    CGRect frameImageView = streamViewController.view.frame;
    frameImageView.origin.x = 0*SCREEN_WIDTH;
    frameImageView.origin.y = 0;
    frameImageView.size.width = SCREEN_WIDTH;
    frameImageView.size.height = self.view.frame.size.height;
    streamViewController.view.frame = frameImageView;
    [tabScrollView addSubview:streamViewController.view];
    
    //Page 4
    streamTableViewController = [[StreamTableViewController alloc] init];
    frameImageView = streamTableViewController.view.frame;
    frameImageView.origin.x = 3*SCREEN_WIDTH;
    frameImageView.origin.y = headerHeight;
    frameImageView.size.width = SCREEN_WIDTH;
    frameImageView.size.height = self.view.frame.size.height;
    streamTableViewController.view.frame = frameImageView;
    [tabScrollView addSubview:streamTableViewController.view];

    [self.view addSubview:scrollView];
    
    scrollViewsByTab = [NSMutableArray arrayWithObjects:
                        streamViewController.scroller,
                        0,
                        0,
                        streamTableViewController.tableView,
                        nil];
}

-(void) initHeader {
    // middle
    int tabLabelY = 162*headerSize;
    UIImage *highlightImage = [UIImage imageNamed:@"highlight.png"];
    UIImageView *imageViewHighlight = [[UIImageView alloc]initWithImage:highlightImage];
    imageViewHighlight.contentMode = UIViewContentModeScaleToFill;
    CGRect frameImageView = imageViewHighlight.frame;
    frameImageView.origin.x = 0;
    frameImageView.origin.y = tabLabelY;
    frameImageView.size.height = 40;
    frameImageView.size.width = SCREEN_WIDTH/scrollViewWidthMultiplier+22;
    imageViewHighlight.frame = frameImageView;
    [scrollView addSubview:imageViewHighlight withAcceleration:CGPointMake(-.90/scrollViewWidthMultiplier, yAccel)];
    
    //CGFloat xAccelHighlight = -((SCREEN_WIDTH)/self.contentSize.width);
    // add label
    NSArray *tabLabels = [NSArray arrayWithObjects:
                          @"Stream",
                          @"Albums",
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
        
        [scrollView addSubview:tabButton withAcceleration:CGPointMake(.1/scrollViewWidthMultiplier, yAccel)];
        
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
    [scrollView addSubview:imageViewProfile withAcceleration:CGPointMake(0,yAccel)];
    
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
    [scrollView addSubview:imageViewPost withAcceleration:CGPointMake(0,yAccel)];
    
    topTextField = [[UITextView alloc]initWithFrame:CGRectMake(imageViewPost.frame.origin.x+6, (int)tabLabelY+42, 172, 50)];
    topTextField.delegate = self;
    topTextField.alpha = .8;
    topTextField.font = [UIFont systemFontOfSize:14];
    topTextField.backgroundColor = [UIColor clearColor];
    topTextField.layer.shadowColor = [UIColor blackColor].CGColor;
    topTextField.layer.shadowOffset = CGSizeMake(0, 3);
    topTextField.layer.shadowOpacity = .4;
    topTextField.layer.shadowRadius = 4;
    [scrollView addSubview:topTextField withAcceleration:CGPointMake(0,yAccel)];
}

- (void) goToTab_0:(id)sender {
    [scrollView setContentOffset:CGPointMake(0*SCREEN_WIDTH, scrollView.contentOffset.y) animated:YES];
    NSLog(@"Button Pressed: ");
}
- (void) goToTab_1:(id)sender {
    [scrollView setContentOffset:CGPointMake(1*SCREEN_WIDTH, scrollView.contentOffset.y) animated:YES];
    NSLog(@"Button Pressed: ");

}
- (void) goToTab_2:(id)sender {
    [scrollView setContentOffset:CGPointMake(2*SCREEN_WIDTH, scrollView.contentOffset.y) animated:YES];
    NSLog(@"Button Pressed: ");

}
- (void) goToTab_3:(id)sender {
    [scrollView setContentOffset:CGPointMake(3*SCREEN_WIDTH, scrollView.contentOffset.y) animated:YES];
    NSLog(@"Button Pressed: ");

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
    [scrollView rotateToInterfaceOrientation:toInterfaceOrientation];


}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    streamViewController.scroller.scrollEnabled = NO;
    NSLog(@"Home Scrolled: %s","SCROLL OFF");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    streamViewController.scroller.scrollEnabled = YES;
    NSLog(@"Home Scrolled: %s","SCROLL ON");

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    streamViewController.scroller.scrollEnabled = YES;
    NSLog(@"Home Scrolled: %s","SCROLL ON");
}


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView{
    if(aScrollView == tabScrollView){
        [scrollView setContentOffset:CGPointMake(aScrollView.contentOffset.x, scrollView.contentOffset.y)];
        static NSInteger previousPage = 0;
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        if (previousPage != page) {
            CGFloat pageWidth = scrollView.frame.size.width;
            int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            int offset = 0;
            if(page >= 0 && page < scrollViewsByTab.count){
                offset = ((UIScrollView*)scrollViewsByTab[page]).contentOffset.y;
            }
            NSLog(@"Landed on page: %d, with last y: %d", page, offset);
            
            [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.scrollView setFrame:CGRectMake(0, -MIN(offset,headerHeight-grassBarHeight), self.scrollView.frame.size.width, headerHeight+10)];
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0)];
            } completion:nil];
            previousPage = page;
        }
    }
}

@end










