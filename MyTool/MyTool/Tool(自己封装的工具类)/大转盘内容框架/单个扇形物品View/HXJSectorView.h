//
//  HXJSectorView.h
//  OO1
//
//  Created by admin on 2020/10/27.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 大转盘单个视图创建
 */
@interface HXJSectorView : UIView

-(instancetype)initWithFrame:(CGRect)frame
                    titleStr:(NSString *)titleStr
                    imageStr:(NSString *)imageStr
                  backColor1:(UIColor *)backColor1
                  backColor2:(UIColor *)backColor2
                       angle:(CGFloat)angle;


@end


