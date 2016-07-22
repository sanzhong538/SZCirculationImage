//
//  ViewController.m
//  SZCirculationImage
//
//  Created by 吴三忠 on 16/4/22.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "ViewController.h"
#import "SZCirculationImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SZCirculationImageView *scrollView = [[SZCirculationImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) withImagesArray:@[@"1", @"2", @"4", @"5", @"6", @"7"]];
    scrollView.placeOfPageControl = kPlaceBottomOfView;
    scrollView.defaultPageColor = [UIColor blueColor];
    scrollView.currentPageColor = [UIColor purpleColor];
    scrollView.pauseTime = 1.0;
//    scrollView.hidePageControl = YES;
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
