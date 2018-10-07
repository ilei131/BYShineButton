//
//  BYShineAngleLayer.h
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BYShineParams.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYShineAngleLayer : CALayer <CAAnimationDelegate>

@property (nonatomic, strong) BYShineParams *params;
@property (nonatomic, strong) NSMutableArray *shineLayers;
@property (nonatomic, strong) NSMutableArray *smallShineLayers;
@property (nonatomic, strong) CADisplayLink *displaylink;

- (instancetype)initWithFrame:(CGRect)frame params:(BYShineParams *)params;
- (void)startAnim;

@end

NS_ASSUME_NONNULL_END
