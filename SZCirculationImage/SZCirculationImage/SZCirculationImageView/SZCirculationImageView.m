//
//  SZCirculationImageView.m
//  SZCirculationImage
//
//  Created by 吴三忠 on 16/4/22.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SZCirculationImageView.h"

#define W (self.bounds.size.width)
#define H (self.bounds.size.height)

@interface SZCirculationImageView ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIScrollView *imageScrollView;

@end

@implementation SZCirculationImageView

- (instancetype)initWithFrame:(CGRect)frame withImagesArray:(NSArray *)array {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.index = 0;
        self.imagesArray = array;
        [self setupLayout];
    }
    return self;
}

#pragma mark - private method

- (void)setupLayout {
    
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W, H)];
    self.centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W, 0, W, H)];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W * 2, 0, W, H)];
    self.leftImageView.contentMode = UIViewContentModeScaleToFill;
    self.centerImageView.contentMode = UIViewContentModeScaleToFill;
    self.rightImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self setupImage];
    
    [self.imageScrollView addSubview:self.leftImageView];
    [self.imageScrollView addSubview:self.centerImageView];
    [self.imageScrollView addSubview:self.rightImageView];
    
    [self addSubview:self.pageControl];
    [self startTimer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
    [self addGestureRecognizer:tap];
}

- (void)setupImage {
    
    self.centerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.imagesArray[self.index]]];
    self.leftImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.imagesArray[self.index-1>=0?self.index-1:self.imagesArray.count-1]]];
    self.rightImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.imagesArray[self.index+1 <=self.imagesArray.count-1?self.index+1:0]]];
}

- (void)clickImage:(UITapGestureRecognizer *)tap {
    
    [self closeTimer];
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self startTimer];
    }
}

#pragma mark - get 

- (float)pauseTime {
    
    return (_pauseTime ? _pauseTime : 3.0);
}

#pragma mark - set

- (void)setHidePageControl:(BOOL)hidePageControl {
    
    self.pageControl.hidden = hidePageControl;
}

- (void)setPlaceOfPageControl:(PlaceOfPageControl)placeOfPageControl {
    
    switch (placeOfPageControl) {
        case kPlaceTopOfView:
            self.pageControl.frame = CGRectMake(0, H * 0.08, W, H * 0.08);
            break;
        case kPlaceBottomOfView:
            self.pageControl.frame = CGRectMake(0, H - H * 0.08, W, H * 0.08);
            break;
        default:
            break;
    }
}

- (void)setDefaultPageColor:(UIColor *)defaultPageColor {
    
    self.pageControl.pageIndicatorTintColor = defaultPageColor;
}

- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}

#pragma mark - timer

- (void)startTimer
{
    if(self.timer == nil){
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.pauseTime target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
    }
}

- (void)closeTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerStart
{
    self.imageScrollView.contentOffset = CGPointMake(0, 0);
    [self.imageScrollView setContentOffset:CGPointMake(W, 0) animated:YES];

    self.index++;
    if (self.index  > self.imagesArray.count-1 ) {
        self.index = 0;
    }
    [self setupImage];
    self.pageControl.currentPage = self.index;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self closeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (decelerate == NO) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x < W/2.0) {
        scrollView.contentOffset = CGPointMake(W, 0);
        self.index--;
        if (self.index < 0) {
            self.index = self.imagesArray.count-1;
        }
        [self setupImage];
    }
    if (scrollView.contentOffset.x > W *1.5) {
        
        scrollView.contentOffset = CGPointMake(W, 0);
        self.index++;
        if (self.index  > self.imagesArray.count-1 ) {
            self.index = 0;
        }
        [self setupImage];
    }
    self.pageControl.currentPage = self.index;
    [self startTimer];
}


#pragma mark - lazy load

- (UIScrollView *)imageScrollView {
    
    if (_imageScrollView == nil) {
        _imageScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.showsVerticalScrollIndicator = NO;
        _imageScrollView.contentOffset = CGPointMake(W, 0);
        _imageScrollView.contentSize = CGSizeMake(W * 3, H);
        _imageScrollView.pagingEnabled = YES;
        _imageScrollView.delegate = self;
        _imageScrollView.bounces = NO;
        [self addSubview:_imageScrollView];
    }
    return _imageScrollView;
}

- (UIPageControl *)pageControl {
    
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, H - H * 0.1, W, H * 0.1)];
        _pageControl.currentPage = self.index;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = self.imagesArray.count;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}

- (void)dealloc {
    
    [self closeTimer];
}

@end
