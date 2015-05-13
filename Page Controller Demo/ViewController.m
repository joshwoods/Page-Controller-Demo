//
//  ViewController.m
//  Page Controller Demo
//
//  Created by Josh Woods on 5/13/15.
//  Copyright (c) 2015 sdoowhsoj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL firstLoad;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TitleList" ofType:@"plist"];
    _pages = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    _pageControllers = [NSMutableArray array];
    
    for (int i = 0; i<_pages.count; i++)
    {
        NSDictionary *featuredRecipe = [_pages objectAtIndex:i];
        
        ContentViewController *contentViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PageContentViewController"];
        contentViewController.titleText = [featuredRecipe objectForKey:@"Page"];
        contentViewController.pageIndex = i;
        [_pageControllers insertObject:contentViewController atIndex:i];
    }
    
    //Load Starting View
    ContentViewController *startingViewController = _pageControllers[0];
    NSArray *viewControllers =  @[startingViewController];
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedIn:[self class], nil];
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControl.backgroundColor = [UIColor clearColor];
    
    _pageControl.numberOfPages = _pages.count;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    if (_firstLoad) {
        _firstLoad = NO;
        ContentViewController *startingViewController = _pageControllers[0];
        NSArray *viewControllers =  @[startingViewController];
        [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

#pragma mark - Page View Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((ContentViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index--;
    
    if (index == _pages.count) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((ContentViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == _pages.count) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (ContentViewController *)viewControllerAtIndex:(NSInteger)index {
    if ((_pages.count == 0 )|| (index >= _pages.count)) {
        return nil;
    }
    
    //Create a new view controller and pass data
    ContentViewController *pageContentViewController = _pageControllers[index];
    
    return pageContentViewController;
}

#pragma mark - Page View Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    
    //Find index of current page
    ContentViewController *currentViewController = (ContentViewController *)[_pageViewController.viewControllers lastObject];
    NSUInteger indexOfCurrentPage = [_pageControllers indexOfObject:currentViewController];
    _pageControl.currentPage = indexOfCurrentPage;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"PageControllerSegue"])
    {
        // Assign reference to the section root view
        _pageViewController = segue.destinationViewController;
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
