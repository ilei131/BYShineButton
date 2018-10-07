//
//  BYShineParams.h
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define BYRGBColor(r, g, b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

NS_ASSUME_NONNULL_BEGIN

@interface BYShineParams : NSObject

// shine是否随机颜色
@property (nonatomic, assign) BOOL allowRandomColor;
// shine动画时间，秒
@property (nonatomic, assign) BOOL animDuration;
// 大Shine的颜色
@property (nonatomic, strong) UIColor *bigShineColor;
// 是否需要Flash效果
@property (nonatomic, assign) BOOL enableFlashing;
// shine的个数
@property (nonatomic, assign) int shineCount;
// shine的扩散的旋转角度
@property (nonatomic, assign) float shineTurnAngle;
// shine的扩散的范围的倍数
@property (nonatomic, assign) float shineDistanceMultiple;
// 小shine与大shine之前的角度差异
@property (nonatomic, assign) float smallShineOffsetAngle;
// 小shine的颜色
@property (nonatomic, strong) UIColor *smallShineColor;
// shine的大小
@property (nonatomic, assign) float shineSize;
// 随机的颜色列表
@property (nonatomic, strong) NSArray *colorRandom;

@end

@interface BYShineImage : NSObject

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *__nullable highlightImage;

- (instancetype)initWithNormal:(nonnull NSString *)normalImage
                     highlight:(nullable NSString *)highlightImage;

@end

NS_ASSUME_NONNULL_END
