//
//  HeaderScrollViewDelegate.h
//  Project
//
//  Created by Kai Peng on 1/24/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderScrollViewDelegate:UIViewController <UIScrollViewDelegate>
    @property UIImageView *imageViewSun;
- (HeaderScrollViewDelegate*) init:(UIImageView*)sun;
@end
