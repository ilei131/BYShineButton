//
//  BYShineButton.m
//  babydiary
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import "BYShineButton.h"
#import "BYShineLayer.h"
#import "BYShineClickLayer.h"

@interface BYShineButton()

@property (nonatomic, strong) BYShineClickLayer *clickLayer;
@property (nonatomic, strong) BYShineLayer *shineLayer;

@end

@implementation BYShineButton

- (void)setParams:(BYShineParams *)params {
    _params = params;
    self.clickLayer.animDuration = _params.animDuration/3;
    self.shineLayer.params = params;
}

- (BYShineClickLayer *)clickLayer {
    if (!_clickLayer) {
        _clickLayer = [[BYShineClickLayer alloc] init];
    }
    return _clickLayer;
}

- (BYShineLayer *)shineLayer {
    if (!_shineLayer) {
        _shineLayer = [[BYShineLayer alloc] init];
    }
    return _shineLayer;
}

// 未点击的颜色
- (void)setColor:(UIColor *)color {
    _color = color;
    self.clickLayer.color = color;
}

// 点击后的颜色
- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.clickLayer.fillColor = fillColor;
    self.shineLayer.fillColor = fillColor;
}

- (void)setImage:(BYShineImage *)image {
    _image = image;
    self.clickLayer.image = image;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.clickLayer.clicked = isSelected;
}

- (instancetype)initWithFrame:(CGRect)frame params:(BYShineParams *)params {
    if (self = [super initWithFrame:frame]) {
        self.fillColor = BYRGBColor(255, 102, 102);
        self.params = params;
        [self initLayers];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _params = [[BYShineParams alloc] init];
        [self initLayers];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _params = [[BYShineParams alloc] init];
        [self layoutIfNeeded];
        [self initLayers];
    }
    return self;
}

- (void)setClicked:(BOOL)clicked animated:(BOOL)animated {
    if (clicked != self.clickLayer.clicked) {
        if (clicked) {
            __weak typeof(self) weakSelf = self;
            self.shineLayer.endAnim = ^{
                weakSelf.clickLayer.clicked = clicked;
                if (animated) {
                    [weakSelf.clickLayer startAnim];
                }
                weakSelf.isSelected = clicked;
            };
            if (animated) {
                [self.shineLayer startAnim];
            } else {
                if (self.shineLayer.endAnim) {
                    self.shineLayer.endAnim();
                }
            }
        } else {
            self.clickLayer.clicked = clicked;
            _isSelected = clicked;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (!self.clickLayer.clicked) {
        __weak typeof(self) weakSelf = self;
        self.shineLayer.endAnim = ^{
            weakSelf.clickLayer.clicked = !weakSelf.clickLayer.clicked;
            [weakSelf.clickLayer startAnim];
            weakSelf.isSelected = weakSelf.clickLayer.clicked;
            [weakSelf sendActionsForControlEvents:UIControlEventValueChanged];
        };
        [self.shineLayer startAnim];
    } else {
        self.clickLayer.clicked = !self.clickLayer.clicked;
        _isSelected = self.clickLayer.clicked;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)initLayers {
    self.clickLayer.animDuration = _params.animDuration/3;
    self.shineLayer.params       = _params;
    self.clickLayer.frame = self.bounds;
    self.shineLayer.frame = self.bounds;
    [self.layer addSublayer:self.clickLayer];
    [self.layer addSublayer:self.shineLayer];
}

@end
