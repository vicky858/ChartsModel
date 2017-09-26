//
//  ZFHorizontalBar.m
//  ZFChartView
//
//  Created by apple on 16/5/31.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ZFHorizontalBar.h"
#import "ZFColor.h"

@interface ZFHorizontalBar()

/** bar height limit */
@property (nonatomic, assign) CGFloat barWidthLimit;
/** 动画时间 */
@property (nonatomic, assign) CGFloat animationDuration;

@end

@implementation ZFHorizontalBar

/**
 *  Initialize the default variable
 */
- (void)commonInit{
    _barWidthLimit = self.frame.size.width;
    _percent = 0;
    _animationDuration = 0.5f;
    _isShadow = YES;
    _shadowColor = ZFLightGray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

#pragma mark - bar

/**
 *  Not filled
 *
 *  @return UIBezierPath
 */
- (UIBezierPath *)noFill{
    UIBezierPath * bezier = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 0, self.frame.size.height)];
    return bezier;
}

/**
 *  filling
 *
 *  @return UIBezierPath
 */
- (UIBezierPath *)fill{
    CGFloat currentWidth = _barWidthLimit * self.percent;
    _endXPos = currentWidth;
    
    UIBezierPath * bezier = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, currentWidth, self.frame.size.height)];
    return bezier;
}

/**
 *  CAShapeLayer
 *
 *  @return CAShapeLayer
 */
- (CAShapeLayer *)shapeLayer{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = _barColor.CGColor;
    layer.lineCap = kCALineCapRound;
    layer.path = [self fill].CGPath;
    layer.opacity = _opacity;
    
    if (_isShadow) {
        layer.shadowOpacity = 0.5f;
        layer.shadowColor = _shadowColor.CGColor;
        layer.shadowOffset = CGSizeMake(2, 1);
    }
    
    if (_isAnimated) {
        CABasicAnimation * animation = [self animation];
        [layer addAnimation:animation forKey:nil];
    }
    
    return layer;
}

/**
 *  Gradient color
 */
- (CALayer *)barGradientColor{
    CALayer * layer = [CALayer layer];
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    gradientLayer.colors = _gradientAttribute.colors;
    gradientLayer.locations = _gradientAttribute.locations;
    gradientLayer.startPoint = _gradientAttribute.startPoint;
    gradientLayer.endPoint = _gradientAttribute.endPoint;
    [layer addSublayer:gradientLayer];
    layer.mask = [self shapeLayer];
    
    return layer;
}

#pragma mark - 动画

/**
 *  Fill the animation process
 *
 *  @return CABasicAnimation
 */
- (CABasicAnimation *)animation{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    fillAnimation.duration = _animationDuration;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = (__bridge id)([self noFill].CGPath);
    fillAnimation.toValue = (__bridge id)([self fill].CGPath);
    
    return fillAnimation;
}

/**
 *  Clear all subLayers before
 */
- (void)removeAllLayer{
    NSArray * sublayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in sublayers) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}

#pragma mark - public method

/**
 *  Redrawed
 */
- (void)strokePath{
    [self removeAllLayer];
    [self.layer addSublayer:[self shapeLayer]];
    
    if (_gradientAttribute) {
        [self.layer addSublayer:[self barGradientColor]];
    }
}

@end
