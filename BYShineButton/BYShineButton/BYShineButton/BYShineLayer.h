//
//  BYShineLayer.h
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BYShineParams.h"

typedef void(^EndAnimBolck)(void);

NS_ASSUME_NONNULL_BEGIN

@interface BYShineLayer : CALayer <CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) BYShineParams *params;
@property (nonatomic, strong) CADisplayLink *displaylink;
@property (nonatomic, copy) EndAnimBolck endAnim;

- (void)startAnim;

@end

NS_ASSUME_NONNULL_END
