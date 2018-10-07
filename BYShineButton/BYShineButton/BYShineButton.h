//
//  BYShineButton.h
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYShineParams.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE

@interface BYShineButton : UIControl
// 配置参数
@property (nonatomic, strong) BYShineParams *params;
// 未点击的颜色
@property (nonatomic, strong) IBInspectable UIColor *color;
// 点击后的颜色
@property (nonatomic, strong) IBInspectable UIColor *fillColor;
// button的图片
@property (nonatomic, strong) BYShineImage *image;
// 是否点击的状态
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithFrame:(CGRect)frame params:(BYShineParams *)params;
- (void)setClicked:(BOOL)clicked animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
