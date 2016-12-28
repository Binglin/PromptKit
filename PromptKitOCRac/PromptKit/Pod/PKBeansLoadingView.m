//
//  PKBeansLoadingView.m
//  
//
//  Created by ET|冰琳 on 16/3/4.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

#import "PKBeansLoadingView.h"

@interface PKBeansLoadingView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) CAShapeLayer *dot1;
@property (nonatomic, strong) CAShapeLayer *dot2;
@property (nonatomic, strong) CAShapeLayer *dot3;

@end

@implementation PKBeansLoadingView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.dot1 = [CAShapeLayer new];
        self.dot2 = [CAShapeLayer new];
        self.dot3 = [CAShapeLayer new];
        
        CGFloat dotWidth = 3;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, dotWidth, dotWidth)];
        self.dot1.path = path.CGPath;
        self.dot2.path = path.CGPath;
        self.dot3.path = path.CGPath;
        
        self.dot1.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + 3 ,
                                     CGRectGetMaxY(self.textLabel.frame) - dotWidth,
                                     dotWidth, dotWidth);
        self.dot2.frame = CGRectMake(CGRectGetMaxX(self.dot1.frame) + 3 ,
                                     CGRectGetMaxY(self.textLabel.frame) - dotWidth,
                                     dotWidth, dotWidth);
        self.dot3.frame = CGRectMake(CGRectGetMaxX(self.dot2.frame) + 3 ,
                                     CGRectGetMaxY(self.textLabel.frame) - dotWidth,
                                     dotWidth, dotWidth);
        
        [self.layer addSublayer:self.dot1];
        [self.layer addSublayer:self.dot2];
        [self.layer addSublayer:self.dot3];
    }
    return self;
}


- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.text = @"Loading";
        [_textLabel sizeToFit];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}


- (void)startAnimating{
    CGFloat maxY = 0;
    CGFloat minY = -self.textLabel.frame.size.height/2.0;
    
    CAKeyframeAnimation *kAni1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    kAni1.duration = 1;
    kAni1.keyTimes = @[@(0),@(0.2) , @(0.4), @(0.6) , @(0.8), @(1)];
    kAni1.values = @[@(maxY),@(minY),@(maxY),@(maxY),@(maxY),@(maxY)];
    kAni1.repeatCount = NSNotFound;
    [self.dot1 addAnimation:kAni1 forKey:@"bean"];
    
    CAKeyframeAnimation *kAni2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    kAni2.duration = 1;
    kAni2.keyTimes = kAni1.keyTimes;
    kAni2.values = @[@(maxY),@(maxY),@(minY),@(maxY),@(maxY),@(maxY)];
    kAni2.repeatCount = NSNotFound;
    [self.dot2 addAnimation:kAni2 forKey:@"bean"];
    
    CAKeyframeAnimation *kAni3 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    kAni3.duration = 1;
    kAni3.keyTimes = kAni1.keyTimes;
    kAni3.values = @[@(maxY),@(maxY),@(maxY),@(minY),@(maxY),@(maxY)];
    kAni3.repeatCount = NSNotFound;
    [self.dot3 addAnimation:kAni3 forKey:@"bean"];
}

@end

