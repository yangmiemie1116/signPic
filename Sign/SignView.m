//
//  SignView.m
//  SignView
//
//  Created by sheep on 2017/8/28.
//  Copyright © 2017年 sheep. All rights reserved.
//

#import "SignView.h"
@interface SignView()
{
    CGPoint points[5];
}
@property(nonatomic,assign) NSInteger point;
@property(nonatomic,strong) UIBezierPath *beizerPath;
@end


@implementation SignView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setMultipleTouchEnabled:NO];
        self.beizerPath = [UIBezierPath bezierPath];
        [self.beizerPath setLineWidth:2];
    }
    return self;
}

- (void)setLineWidth:(NSInteger)lineWidth {
    [self.beizerPath setLineWidth:lineWidth];
}

#pragma mark - 绘图操作
- (void)drawRect:(CGRect)rect{
    //设置签名的颜色
    UIColor *strokeColor = self.signColor;
    [strokeColor setStroke];
    //签名的路径绘制
    [self.beizerPath stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.point = 0;
    UITouch *touch = [touches anyObject];
    points[0] = [touch locationInView:self];
    CGPoint startPoint = points[0];
    CGPoint endPoint = CGPointMake(startPoint.x + 1.5, startPoint.y + 2);
    [self.beizerPath moveToPoint:startPoint];
    [self.beizerPath addLineToPoint:endPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    self.point++;
    points[self.point] = touchPoint;
    
    if (self.point == 4){
        points[3] = CGPointMake((points[2].x + points[4].x)/2.0, (points[2].y + points[4].y)/2.0);
        //设置画笔起始点
        [self.beizerPath moveToPoint:points[0]];
        //endPoint终点 controlPoint1、controlPoint2控制点
        [self.beizerPath addCurveToPoint:points[3] controlPoint1:points[1] controlPoint2:points[2]];
        [self setNeedsDisplay];
        points[0] = points[3];
        points[1] = points[4];
        self.point = 1;
    }
}

#pragma mark - 清除签名
- (void)clearSignature{
    [self.beizerPath removeAllPoints];
    [self setNeedsDisplay];
}

#pragma mark - 获取图片
- (UIImage *)generateSignatureImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *signatureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return signatureImage;
}

- (NSData*)generatePNGSignData {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *signatureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImagePNGRepresentation(signatureImage);
}

- (NSData*)generateJPEGSignData:(CGFloat)compressionQuality {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *signatureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(signatureImage, compressionQuality);
}

@end
