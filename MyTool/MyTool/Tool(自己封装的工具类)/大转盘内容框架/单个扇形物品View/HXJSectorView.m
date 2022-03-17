//
//  HXJSectorView.m
//  OO1
//
//  Created by admin on 2020/10/27.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import "HXJSectorView.h"

#import <SDWebImage.h>

@interface HXJSectorView ()

@end


@implementation HXJSectorView

-(instancetype)initWithFrame:(CGRect)frame
                    titleStr:(NSString *)titleStr
                    imageStr:(NSString *)imageStr
                   backColor1:(UIColor *)backColor1
                  backColor2:(UIColor *)backColor2
                       angle:(CGFloat)angle{
    
    self = [super initWithFrame:frame];

    if (self) {
    
        self.backgroundColor=[UIColor clearColor];
        
        [self configureWithSuperFrame:frame titleStr:titleStr imageStr:imageStr backColor1:backColor1 backColor2:backColor2 angle:angle];
    }

    return self;

}

-(void)configureWithSuperFrame:(CGRect)frame
                      titleStr:(NSString *)titleStr
                      imageStr:(NSString *)imageStr
                    backColor1:(UIColor *)backColor1
                    backColor2:(UIColor *)backColor2
                         angle:(CGFloat)angle{
    
    //创建背景layer
    CAShapeLayer *layer1 = [self creatCAShapeLayerWithSuperFrame:frame radius:frame.size.height backColor:backColor1 angle:angle];
    [self.layer addSublayer:layer1];
    
    
    //标题
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0,10,frame.size.width,15)];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment =NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:12.0];
    title.textColor = [UIColor redColor];
    title.text=titleStr;
    [self addSubview:title];
    
    
    //图片
    UIImageView *iconIV=[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-20)/2, 30, 20, 20)];
    [self addSubview:iconIV];
    iconIV.backgroundColor = [UIColor whiteColor];
    iconIV.layer.cornerRadius=20/2.0;
    iconIV.layer.masksToBounds=YES;
    if ([imageStr containsString:@"http"]) {
        
        [iconIV sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    }else{
        
        iconIV.image=[UIImage imageNamed:imageStr];
    }
    
    
    //创建背景layer
    CAShapeLayer *layer2 = [self creatCAShapeLayerWithSuperFrame:frame radius:frame.size.height/2 backColor:backColor2 angle:angle];
    [self.layer addSublayer:layer2];
    
    
    //创建背景layer
    CAShapeLayer *layer3 = [self creatCAShapeLayerWithSuperFrame:frame radius:frame.size.height/3 backColor:[UIColor whiteColor] angle:angle];
    [self.layer addSublayer:layer3];
}



-(CAShapeLayer *)creatCAShapeLayerWithSuperFrame:(CGRect)frame
                                          radius:(CGFloat)radius
                                       backColor:(UIColor *)backColor
                                           angle:(CGFloat)angle{
    /**
    绘制圆弧
    Center: 中心点坐标
    radius:弧所在的半径
    startAngle:开始的角度 ; 0度是圆的最右侧，向上的度数为负的，向下的度数为正的
    endAngle:结束的角度
    clockwise:是顺时针还是逆时针  默认:顺时针
    */
    
    CGFloat startAngle=(M_PI-angle)/2;
    
    // 1. 创建一个UIBezierPath对象
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height) radius:radius startAngle:-startAngle endAngle:-(startAngle+angle) clockwise:NO] ;
    //添加一根线到圆心，然后关闭路径就成了扇形
    [path addLineToPoint:CGPointMake(frame.size.width/2, frame.size.height)];
    //关闭路径
//    [path closePath];
    //绘制贝塞尔曲线边框
//    [path stroke] ;
    //填充贝塞尔曲线内部
//    [path fill] ;
    
    
    
    //画扇形
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = path.CGPath;
    [maskLayer setFillColor:backColor.CGColor];
    
    
    return maskLayer;
}



@end
