//
//  ContentViewController.h
//  Page Controller Demo
//
//  Created by Josh Woods on 5/13/15.
//  Copyright (c) 2015 sdoowhsoj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *label;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSString *titleText;

@end
