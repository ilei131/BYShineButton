//
//  ViewController.m
//  BYShineButton
//
//  Created by Guo Xuelei on 2018/10/7.
//  Copyright © 2018年 Zhanggf. All rights reserved.
//

#import "ViewController.h"
#import "BYShineButton.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet BYShineButton *btn1;
@property (weak, nonatomic) IBOutlet BYShineButton *btn2;
@property (weak, nonatomic) IBOutlet BYShineButton *btn3;
@property (weak, nonatomic) IBOutlet BYShineButton *btn4;
@property (weak, nonatomic) IBOutlet BYShineButton *btn5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BYShineImage *singleImg = [[BYShineImage alloc] initWithNormal:@"like_normal" highlight:nil];
    
    BYShineImage *doubleImg = [[BYShineImage alloc] initWithNormal:@"like_normal" highlight:@"like_selected"];
    
    // 一张图片 默认选中
    BYShineParams *param1 = [[BYShineParams alloc] init];
    param1.bigShineColor = BYRGBColor(153,152,38);
    param1.smallShineColor = BYRGBColor(102,102,102);
    param1.animDuration = 1;
    _btn1.params = param1;
    _btn1.isSelected = YES;
    _btn1.image = singleImg;

    // 一张图片
    BYShineParams *param2 = [[BYShineParams alloc] init];
    param2.bigShineColor = BYRGBColor(255,95,89);
    param2.smallShineColor = BYRGBColor(216,152,148);
    param2.shineCount = 15;
    param2.animDuration = 2;
    param2.smallShineOffsetAngle = -5;
    _btn2.params = param2;
    _btn2.image = singleImg;
    
    // 一张图片 默认选中
    BYShineParams *param3 = [[BYShineParams alloc] init];
    param3.allowRandomColor = YES;
    param3.animDuration = 1;
    _btn3.isSelected = YES;
    _btn3.params = param3;
    _btn3.image = singleImg;
    
    // 一张图片
    BYShineParams *param4 = [[BYShineParams alloc] init];
    param4.enableFlashing = YES;
    param4.animDuration = 2;
    _btn4.params = param4;
    _btn4.image = singleImg;
    
    // 两张图片
    BYShineParams *param5 = [[BYShineParams alloc] init];
    param5.bigShineColor = BYRGBColor(255, 195, 55);
    _btn5.image = doubleImg;
    _btn5.params = param5;
}


@end
