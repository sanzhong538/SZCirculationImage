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
    
    SZCirculationImageView *imageView1 = [[SZCirculationImageView alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, 200) andImageNamesArray:@[@"1.jpg", @"2.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg"]];
    imageView1.pauseTime = 1.0;
    [self.view addSubview:imageView1];
    
    
    NSArray *pathArray = @[
                           @"http://i4.cqnews.net/news/attachement/jpg/site82/2016-08-23/9143505007648195979.jpg",
                           @"http://www.people.com.cn/mediafile/pic/20160830/95/17946987410935083075.jpg",
                           @"http://p.nanrenwo.net/uploads/allimg/160912/8388-160912092346-50.jpg",
                           @"http://upload.cbg.cn/2016/0728/1469695681806.jpg",
                           @"http://image.cnpp.cn/upload/images/20160905/09380421552_400x300.jpg",
                           @"http://cnews.chinadaily.com.cn/img/attachement/jpg/site1/20160729/0023ae82c931190560502f.jpg",
                           ];
    NSArray *titles = @[@"美女", @"大美女", @"大大美女", @"大大大美女", @"大大大大美女", @"大大大大大美女"];
    SZCirculationImageView *imageView2 = [[SZCirculationImageView alloc] initWithFrame:CGRectMake(0, 220, self.view.bounds.size.width, 200) andImageURLsArray:pathArray andTitles:titles];
    imageView2.titleViewStatus = SZTitleViewBottomOnlyTitle;
    imageView2.titleAlignment = NSTextAlignmentCenter;
    imageView2.titleColor = [UIColor purpleColor];
    imageView2.pauseTime = 5.0;
    [self.view addSubview:imageView2];
    
    SZCirculationImageView *imageView3 = [[SZCirculationImageView alloc] initWithFrame:CGRectMake(0, 440, self.view.bounds.size.width, 200) andImageURLsArray:pathArray andTitles:titles];
    imageView3.titleViewStatus = SZTitleViewBottomPageControlAndTitle;
    imageView3.titleAlignment = NSTextAlignmentRight;
    imageView3.titleColor = [UIColor purpleColor];
    imageView3.defaultPageColor = [UIColor blueColor];
    imageView3.currentPageColor = [UIColor purpleColor];
    [self.view addSubview:imageView3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
