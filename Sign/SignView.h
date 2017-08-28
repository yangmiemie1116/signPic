//
//  SignView.h
//  SignView
//
//  Created by sheep on 2017/8/28.
//  Copyright © 2017年 sheep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignView : UIView
/**
 签名的线宽
 */
@property (nonatomic, assign) NSInteger lineWidth;

/**
 签名的颜色
 */
@property (nonatomic, strong) UIColor *signColor;

/**
 * 清除签名
 */
- (void)clearSignature;

/**
 * 获取签名图片
 */
- (UIImage *)generateSignatureImage;

/**
 生成PNG data

 @return png
 */
- (NSData*)generatePNGSignData;

/**
 生成JPEG data

 @param compressionQuality compressionQuality 0...1
 @return jpeg
 */
- (NSData*)generateJPEGSignData:(CGFloat)compressionQuality;
@end
