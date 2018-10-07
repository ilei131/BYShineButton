//
//  BYShineClickLayer.h
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BYShineParams.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYShineClickLayer : CALayer

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) BYShineImage *image;
@property (nonatomic, assign) BOOL clicked;
@property (nonatomic, assign) double animDuration;

- (void)startAnim;

@end

NS_ASSUME_NONNULL_END
