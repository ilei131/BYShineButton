//
//  BYShineParams.m
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import "BYShineParams.h"

@implementation BYShineParams

- (instancetype)init {
    if (self = [super init]) {
        // shine动画时间，秒
        _animDuration = 1;
        // 大Shine的颜色
        _bigShineColor = BYRGBColor(255, 102, 102);
        // shine的个数
        _shineCount = 7;
        // shine的扩散的旋转角度
        _shineTurnAngle = 20;
        // shine的扩散的范围的倍数
        _shineDistanceMultiple = 1.5;
        // 小shine与大shine之前的角度差异
        _smallShineOffsetAngle = 20;
        // 小shine的颜色
        _smallShineColor = [UIColor lightGrayColor];
        // shine的大小
        _shineSize = 0;
        // 随机的颜色列表
        _colorRandom = @[BYRGBColor(255, 255, 153),
                         BYRGBColor(255, 204, 204),
                         BYRGBColor(153, 102, 153),
                         BYRGBColor(255, 102, 102),
                         BYRGBColor(255, 255, 102),
                         BYRGBColor(244, 67, 54),
                         BYRGBColor(102, 102, 102),
                         BYRGBColor(204, 204, 0),
                         BYRGBColor(102, 102, 102),
                         BYRGBColor(153, 153, 51)];
    }
    return self;
}

@end

@implementation BYShineImage

- (instancetype)initWithNormal:(nonnull NSString *)normalImage
                     highlight:(nullable NSString *)highlightImage {
    if (self = [super init]) {
        _normalImage = [UIImage imageNamed:normalImage];
        if (highlightImage) {
            _highlightImage = [UIImage imageNamed:highlightImage];
        }
    }
    return self;
}

@end

