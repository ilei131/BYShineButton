//
//  BYShineClickLayer.m
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import "BYShineClickLayer.h"

@interface BYShineClickLayer()

@property (nonatomic, strong) CALayer *maskLayer;

@end

@implementation BYShineClickLayer

- (CALayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [[CALayer alloc] init];
    }
    return _maskLayer;
}

- (instancetype)init {
    if (self = [super init]) {
        _color = [UIColor grayColor];
        _fillColor = BYRGBColor(255, 102, 102);
        _animDuration = 0.5;
    }
    return self;
}

- (void)setImage:(BYShineImage *)image {
    _image = image;
    if (image.highlightImage) {
        self.mask = nil;
        self.contents = (__bridge id _Nullable)(image.normalImage.CGImage);
    } else {
        self.maskLayer.contents = (__bridge id _Nullable)(image.normalImage.CGImage);
        self.mask = self.maskLayer;
    }

}

- (void)setClicked:(BOOL)clicked {
    _clicked = clicked;
    if (self.image.highlightImage) {
        self.backgroundColor = [UIColor clearColor].CGColor;
        if (clicked) {
            self.contents = (__bridge id _Nullable)(_image.highlightImage.CGImage);
        }else {
            self.contents = (__bridge id _Nullable)(_image.normalImage.CGImage);
        }
    } else {
        if (clicked) {
            self.backgroundColor = self.fillColor.CGColor;
        } else {
            self.backgroundColor = self.color.CGColor;
        }
    }
}

- (void)startAnim {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration  = _animDuration;
    anim.values = @[@0.4, @1, @0.9, @1];
    anim.calculationMode = kCAAnimationCubic;
    
    if (self.image.highlightImage) {
        [self addAnimation:anim forKey:@"scale"];
    } else {
        [self.maskLayer addAnimation:anim forKey:@"scale"];
    }
}

- (void)layoutSublayers {
    [super layoutSublayers];
    if (self.image.highlightImage) {
        self.backgroundColor = [UIColor clearColor].CGColor;
    } else {
        self.maskLayer.frame = self.bounds;
        self.maskLayer.contents = (__bridge id _Nullable)(_image.normalImage.CGImage);
        self.mask = self.maskLayer;
        if (_clicked) {
            self.backgroundColor = self.fillColor.CGColor;
        } else {
            self.backgroundColor = self.color.CGColor;
        }
    }
}

@end
