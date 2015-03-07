//
//  UIImage+MyImage.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyImage)

+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)imageLocalizedNamed:(NSString *)name;
+ (UIImage *)colorImage:(UIImage *)img withColor:(UIColor *)color;
+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color;
+ (UIImage *)imageLocalizedNamed:(NSString *)name withColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage *)cropImageInRect:(CGRect )rect;
- (UIImage *)resizeImageToWidth:(float )width;
- (UIImage *) rotateImage:(UIImage *)img angle:(int)angle;
- (UIImage *) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

@end
