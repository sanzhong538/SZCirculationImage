//
//  SZCirculationImageView.h
//  SZCirculationImage
//
//  Created by 吴三忠 on 16/4/22.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PlaceOfPageControl){
    kPlaceTopOfView = 1,
    kPlaceBottomOfView
};

@interface SZCirculationImageView : UIView

/**
 *  是否隐藏页面控件，默认为 NO
 */
@property (nonatomic, assign) BOOL hidePageControl;

/**
 *  页面控件位置，默认是底部
 */
@property (nonatomic, assign) PlaceOfPageControl placeOfPageControl;

/**
 *  页面控件未选时颜色，默认为灰色
 */
@property (nonatomic, strong) UIColor *defaultPageColor;

/**
 *  页面控件选中时颜色，默认为红色
 */
@property (nonatomic, strong) UIColor *currentPageColor;

/**
 *  停顿时间, 默认 3s
 */
@property (nonatomic, assign) float pauseTime;

/**
 *  初始化
 *
 *  @param frame
 *  @param array 图片数组
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame withImagesArray:(NSArray *)array;

@end
