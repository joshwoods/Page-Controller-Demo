//
//  ViewController.h
//  Page Controller Demo
//
//  Created by Josh Woods on 5/13/15.
//  Copyright (c) 2015 sdoowhsoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

// Page view controller
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, weak) IBOutlet UIView *pageContainerView;

// Arrays
@property (nonatomic, strong) NSMutableArray *pageControllers;
@property (nonatomic, strong) NSArray *pages;

// Page control
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *skipButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *skipButtonWidth;

@end

