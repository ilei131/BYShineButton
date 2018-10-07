//
//  BYShineAngleLayer.m
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import "BYShineAngleLayer.h"

@implementation BYShineAngleLayer 

- (instancetype)initWithFrame:(CGRect)frame params:(BYShineParams *)params {
    if (self = [super init]) {
        self.frame = frame;
        self.params = params;
        self.shineLayers = [[NSMutableArray alloc] init];
        self.smallShineLayers = [[NSMutableArray alloc] init];
        [self addShines];
    }
    return self;
}

- (CGPoint)getShineCenterAngle:(CGFloat)angle radius:(CGFloat)radius {
    CGFloat cenx = CGRectGetMidX(self.bounds);
    CGFloat ceny = CGRectGetMidY(self.bounds);
    int multiple = 0;
    if (angle >= 0 && angle <= (CGFloat)(90 * M_PI/180)) {
        multiple = 1;
    } else if (angle <= (CGFloat)(M_PI) && angle > (CGFloat)(90 * M_PI/180)) {
        multiple = 2;
    } else if (angle > (CGFloat)(M_PI) && angle <= (CGFloat)(270 * M_PI/180)) {
        multiple = 3;
    } else {
        multiple = 4;
    }
    
    CGFloat resultAngel = (CGFloat)(multiple)*(CGFloat)(90 * M_PI/180) - angle;
    CGFloat a = sin(resultAngel)*radius;
    CGFloat b = cos(resultAngel)*radius;
    if (multiple == 1) {
        return CGPointMake(cenx+b, ceny-a);
    } else if (multiple == 2) {
        return CGPointMake(cenx+a, ceny+b);
    } else if (multiple == 3) {
        return CGPointMake(cenx-b, ceny+a);
    } else {
        return CGPointMake(cenx-a, ceny-b);
    }
}

- (CABasicAnimation *)getAngleAnimShine:(CAShapeLayer *)shine angle:(CGFloat)angle radius:(CGFloat)radius {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = _params.animDuration * 0.87;
    anim.fromValue = (__bridge id _Nullable)(shine.path);
    CGPoint center = [self getShineCenterAngle:angle radius:radius];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:0.1 startAngle:0 endAngle:(CGFloat)(M_PI)*2 clockwise:NO];
    anim.toValue = (__bridge id _Nullable)(path.CGPath);
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.removedOnCompletion = YES;
    anim.fillMode = kCAFillModeForwards;
    
    return anim;
}

- (CABasicAnimation *)getFlashAnim {
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.fromValue = @(1);
    flash.toValue = @(0);
    
    double duration = (double)(arc4random()%20+60)/1000;
    flash.duration = duration;
    flash.repeatCount = MAXFLOAT;
    flash.removedOnCompletion = NO;
    flash.autoreverses = YES;
    flash.fillMode = kCAFillModeForwards;
    return flash;
}

- (void)startAnim {
    CGFloat radius = self.frame.size.width/2 * (CGFloat)(_params.shineDistanceMultiple*1.4);
    
    CGFloat startAngle = 0;
    CGFloat angle = (CGFloat)(M_PI*2/(double)(_params.shineCount)) + startAngle;
    
    if (_params.shineCount%2 != 0) {
        startAngle = (CGFloat)(M_PI*2 - ((double)(angle)/(double)(_params.shineCount)));
    }
    for (int i=0; i<_params.shineCount; i++) {
        CAShapeLayer *bigShine = _shineLayers[i];
        CABasicAnimation *bigAnim = [self getAngleAnimShine:bigShine angle:startAngle + (CGFloat)(angle)*(CGFloat)(i) radius:radius];
        CAShapeLayer *smallShine = _smallShineLayers[i];
        CGFloat radiusSub = self.frame.size.width*0.15*0.66;
        
        if (_params.shineSize != 0) {
            radiusSub = _params.shineSize*0.66;
        }
        CABasicAnimation *smallAnim = [self getAngleAnimShine:smallShine angle:startAngle + (CGFloat)(angle)*(CGFloat)(i) - (CGFloat)(_params.smallShineOffsetAngle)*(CGFloat)(M_PI)/180 radius:radius-radiusSub];
        [bigShine addAnimation:bigAnim forKey:@"path"];
        [smallShine addAnimation:smallAnim forKey:@"path"];

        if (_params.enableFlashing) {
            CABasicAnimation *bigFlash = [self getFlashAnim];
            CABasicAnimation *smallFlash = [self getFlashAnim];
            [bigShine addAnimation:bigFlash forKey:@"bigFlash"];
            [smallShine addAnimation:smallFlash forKey:@"smallFlash"];
        }
    }
    CABasicAnimation *angleAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    angleAnim.duration = _params.animDuration * 0.87;
    angleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    angleAnim.fromValue = @(0);
    angleAnim.toValue = @((CGFloat)_params.shineTurnAngle*(CGFloat)(M_PI)/180);
    angleAnim.delegate = self;
    [self addAnimation:angleAnim forKey:@"rotate"];
    if (_params.enableFlashing) {
        [self startFlash];
    }
}

- (void)startFlash {
    _displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(flashAction)];
    if (@available(iOS 10.0, *)) {
        _displaylink.preferredFramesPerSecond = 10;
    }else {
        _displaylink.frameInterval = 6;
    }
    [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)addShines {
    CGFloat startAngle = 0;
    CGFloat angle = (CGFloat)(M_PI*2/(double)_params.shineCount) + startAngle;
    
    if (_params.shineCount%2 != 0) {
        startAngle = (CGFloat)(M_PI*2 - ((double)(angle)/(double)(_params.shineCount)));
    }

    CGFloat radius = self.frame.size.width/2 * (CGFloat)(_params.shineDistanceMultiple);
    for (int i=0; i<_params.shineCount; i++) {
        CAShapeLayer *bigShine = [[CAShapeLayer alloc] init];
        CGFloat bigWidth = self.frame.size.width*0.15;
        if (_params.shineSize != 0) {
            bigWidth = _params.shineSize;
        }
        CGPoint center = [self getShineCenterAngle:startAngle + (CGFloat)(angle)*(CGFloat)(i) radius:radius];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:bigWidth startAngle:0 endAngle:(CGFloat)(M_PI)*2 clockwise:NO];
        bigShine.path = path.CGPath;
        if (_params.allowRandomColor) {
            int index = (int)(arc4random()%(uint32_t)(_params.colorRandom.count));
            bigShine.fillColor = [(UIColor *)_params.colorRandom[index] CGColor];
        } else {
            bigShine.fillColor = _params.bigShineColor.CGColor;
        }
        [self addSublayer:bigShine];
        [_shineLayers addObject:bigShine];
        CAShapeLayer *smallShine = [[CAShapeLayer alloc] init];
        CGFloat smallWidth = bigWidth*0.66;
        CGPoint smallCenter = [self getShineCenterAngle:startAngle + (CGFloat)(angle)*(CGFloat)(i) - (CGFloat)(_params.smallShineOffsetAngle)*(CGFloat)(M_PI)/180 radius:radius-bigWidth];
        UIBezierPath *smallPath = [UIBezierPath bezierPathWithArcCenter:smallCenter radius:smallWidth startAngle:0 endAngle:(CGFloat)(M_PI)*2 clockwise:NO];
        smallShine.path = smallPath.CGPath;
        if (_params.allowRandomColor) {
            int index = (int)(arc4random()%(uint32_t)(_params.colorRandom.count));
            smallShine.fillColor = [(UIColor *)_params.colorRandom[index] CGColor];
        }else {
            smallShine.fillColor = _params.smallShineColor.CGColor;
        }
        [self addSublayer:smallShine];
        [_smallShineLayers addObject:smallShine];
    }
}

- (void)flashAction {
    for (int i=0; i<_params.shineCount; i++) {
        CAShapeLayer *bigShine = _shineLayers[i];
        CAShapeLayer *smallShine = _smallShineLayers[i];
        int index1 = (int)(arc4random()%(uint32_t)(_params.colorRandom.count));
        bigShine.fillColor = [(UIColor *)_params.colorRandom[index1] CGColor];
        int index2 = (int)(arc4random()%(uint32_t)(_params.colorRandom.count));
        smallShine.fillColor = [(UIColor *)_params.colorRandom[index2] CGColor];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [_displaylink invalidate];
        _displaylink = nil;
        [self removeAllAnimations];
        [self removeFromSuperlayer];
    }
}

@end
