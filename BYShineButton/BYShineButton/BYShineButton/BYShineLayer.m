//
//  BYShineLayer.m
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import "BYShineLayer.h"
#import "BYShineAngleLayer.h"

@implementation BYShineLayer

- (instancetype)init {
    if (self = [super init]) {
        _fillColor = BYRGBColor(255, 102, 102);
        _shapeLayer = [[CAShapeLayer alloc] init];
        [self initLayers];
    }
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        [self initLayers];
    }
    return self;
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    _shapeLayer.strokeColor = fillColor.CGColor;
}

- (void)startAnim {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    anim.duration = _params.animDuration * 0.1;
    CGSize size = self.frame.size;
    CGPathRef fromPath = [[UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:1 startAngle:0 endAngle:(CGFloat)(M_PI) * 2.0 clockwise:NO] CGPath];
    CGPathRef toPath = [[UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2, size.height/2) radius:size.width/2 * (CGFloat)(_params.shineDistanceMultiple) startAngle:0 endAngle:(CGFloat)(M_PI) * 2.0 clockwise:NO] CGPath];

    anim.delegate = self;
    anim.values = @[(__bridge id _Nullable)fromPath, (__bridge id _Nullable)toPath];
    anim.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeForwards;
    [_shapeLayer addAnimation:anim forKey:@"path"];
    if (_params.enableFlashing) {
        [self startFlash];
    }
}

//MARK: Privater Methods
- (void)initLayers {
    _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    _shapeLayer.strokeColor = _fillColor.CGColor;
    _shapeLayer.lineWidth = 1.5;
    [self addSublayer:_shapeLayer];
}

- (void)startFlash {
    _displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flashAction)];
    if (@available(iOS 10.0, *)) {
        _displaylink.preferredFramesPerSecond = 6;
    } else {
        _displaylink.frameInterval = 10;
    }
    [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)flashAction {
    int index = (int)(arc4random()%(uint32_t)(_params.colorRandom.count));
    _shapeLayer.strokeColor = [(UIColor *)_params.colorRandom[index] CGColor];
}

//MARK: CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [_displaylink invalidate];
        _displaylink = nil;
        [_shapeLayer removeAllAnimations];
        BYShineAngleLayer *angleLayer = [[BYShineAngleLayer alloc] initWithFrame:self.bounds params:_params];
        [self addSublayer:angleLayer];
        [angleLayer startAnim];
        if (_endAnim) {
            _endAnim();
        }
    }
}

@end
