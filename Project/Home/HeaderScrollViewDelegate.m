//
//  HeaderScrollViewDelegate.m
//  Project
//
//  Created by Kai Peng on 1/24/13.
//  Copyright (c) 2013 Kai Peng. All rights reserved.
//

#import "HeaderScrollViewDelegate.h"

@implementation HeaderScrollViewDelegate
@synthesize imageViewSun;

- (HeaderScrollViewDelegate*) init:(UIImageView*)sun{
    imageViewSun = sun;
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView{
    
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

@end
