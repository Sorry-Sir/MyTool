//
//  UIImage+ChangeColor.m
//  OO1
//
//  Created by admin on 2020/5/11.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import "UIImage+ChangeColor.h"

@implementation UIImage (ChangeColor)

/**
图片修改颜色
*/
-(UIImage*)imageChangeColor:(UIColor*)color{
    
    
    UIImage *newImage = nil;
    CGRect imageRect = (CGRect){CGPointZero,self.size};
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -(imageRect.size.height));
    CGContextClipToMask(context, imageRect, self.CGImage);//选中选区 获取不透明区域路径
    CGContextSetFillColorWithColor(context, color.CGColor);//设置颜色
    CGContextFillRect(context, imageRect);//绘制
    newImage = UIGraphicsGetImageFromCurrentImageContext();//提取图片
    UIGraphicsEndImageContext();
    return newImage;
    
    
//    //获取画布
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
//    //画笔沾取颜色
//    [color setFill];
//
//    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
//    UIRectFill(bounds);
//    //绘制一次
//    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:0.8f];
//    //再绘制一次
//    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:0.8f];
//    //获取图片
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
    
}




@end
