//
//  HomeViewController.h
//  A3ParallaxScrollViewSample
//
//  Created by Botond Kis on 24.10.12.
//  Copyright (c) 2012 AllAboutApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A3ParallaxScrollView.h"

@interface HomeViewController : UIViewController <UIScrollViewDelegate>

    @property (strong) A3ParallaxScrollView *scrollView;
    @property (strong) UIImageView *imageViewSun;


@end
