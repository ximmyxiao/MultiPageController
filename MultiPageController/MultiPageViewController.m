//
//  MultiPageViewController.m
//  MultiPageController
//
//  Created by Piao Piao on 2017/10/26.
//  Copyright © 2017年 Piao Piao. All rights reserved.
//

#import "MultiPageViewController.h"

#define TOP_BAR_HEIGHT (44)
#define SCROLL_ITEM_WIDTH (60)
#define INDICATOR_HEIGHT (4)

@interface MultiPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property(nonatomic,strong) UIPageViewController* pageCtrl;
@property(nonatomic,strong) UIScrollView* topScrollView;
@property(nonatomic,strong) NSArray* allTypes;
@property(nonatomic,strong) NSArray* allControllers;
@property(nonatomic,strong) NSMutableArray* allTopItems;
@property(nonatomic,strong) UIView* topIndicatorView;
@end

@implementation MultiPageViewController
- (instancetype)initWithAllControllers:(NSArray*) controllers AndTypes:(NSArray*)types;
{
    self = [super init];
    if (self)
    {
        self.allControllers = controllers;
        self.allTypes = types;
    }
    return self;
}
//    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

- (void)constructTopBar
{
    [self.allTopItems  makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.allTopItems = [NSMutableArray array];

    CGFloat itemWidth = SCROLL_ITEM_WIDTH;
    NSInteger i = 0;
    for (NSString* title  in self.allTypes)
    {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth,TOP_BAR_HEIGHT)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [self.topScrollView addSubview:label];
        [self.allTopItems addObject:label];
        i++;
    }
    
    self.topScrollView.contentSize = CGSizeMake(i*itemWidth, 0);
    
    if (i > 0)
    {
        self.topIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT - INDICATOR_HEIGHT, itemWidth, INDICATOR_HEIGHT)];
        self.topIndicatorView.backgroundColor = self.view.tintColor;
        [self.topScrollView addSubview:self.topIndicatorView];
    }
}

- (void)animateIndicator
{
    NSInteger currentIndex = [self currentPageCtrlShowIndex];
    [UIView animateWithDuration:0.3 animations:^{
        self.topIndicatorView.frame = CGRectMake(currentIndex *  SCROLL_ITEM_WIDTH, TOP_BAR_HEIGHT - INDICATOR_HEIGHT, SCROLL_ITEM_WIDTH, INDICATOR_HEIGHT);
    }];
    
    UILabel* currentLabel = self.allTopItems[currentIndex];
    CGRect windowRect = [self.topScrollView convertRect:currentLabel.frame toView:nil];
    if (windowRect.origin.x + windowRect.size.width >= [UIScreen mainScreen].bounds.size.width)
    {
        
        [self.topScrollView setContentOffset:CGPointMake(self.topScrollView.contentOffset.x + windowRect.origin.x + windowRect.size.width - [UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    }
    else if (windowRect.origin.x < 0)
    {
        [self.topScrollView setContentOffset:CGPointMake(self.topScrollView.contentOffset.x + windowRect.origin.x, 0) animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageCtrl.delegate = self;
    self.pageCtrl.dataSource = self;
    self.pageCtrl.view.frame = CGRectMake(0, TOP_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - TOP_BAR_HEIGHT);
    self.pageCtrl.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addChildViewController:self.pageCtrl];
    [self.view addSubview:self.pageCtrl.view];
    [self.pageCtrl didMoveToParentViewController:self];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topScrollViewTapAction:)];
    
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TOP_BAR_HEIGHT)];
    self.topScrollView.backgroundColor = [UIColor blueColor];
    self.topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.topScrollView addGestureRecognizer:gesture];
    [self.view addSubview:self.topScrollView];
    [self.pageCtrl setViewControllers:@[self.allControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self constructTopBar];

}

- (void)topScrollViewTapAction:(UITapGestureRecognizer*)gesture
{
    CGPoint position = [gesture locationInView:self.topScrollView];
    NSLog(@"tap postion:%@", NSStringFromCGPoint(position));
    NSInteger tapIndex = position.x / SCROLL_ITEM_WIDTH;
    
    NSInteger currentIndex = [self currentPageCtrlShowIndex];
    if (currentIndex > tapIndex)
    {
        [self.pageCtrl setViewControllers:@[self.allControllers[tapIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        [self animateIndicator];

    }
    else if (currentIndex < tapIndex)
    {
        [self.pageCtrl setViewControllers:@[self.allControllers[tapIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        [self animateIndicator];
    }
    else
    {
        
    }
    
}

- (NSInteger)currentPageCtrlShowIndex
{
    NSInteger currentIndex = [self.allControllers indexOfObject: [self.pageCtrl.viewControllers lastObject]];
    return currentIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.allControllers indexOfObject:viewController];
    if (index >= 1 && index != NSNotFound)
    {
        return self.allControllers[index - 1];
    }
    else
    {
        return nil;
    }
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.allControllers indexOfObject:viewController];
    if (index < [self.allControllers count] - 1  && index != NSNotFound)
    {
        return self.allControllers[index + 1];
    }
    else
    {
        return nil;
    }
}


#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    [self animateIndicator];
}

@end
