//
//  UIButton+AddTarget.h
//  OO1
//
//  Created by admin on 2020/3/4.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (AddTarget)

@property (copy,nonatomic) void(^actionBlock)(UIButton *btn);

- (void)addTargetActionBlock:(void(^)(UIButton *btn))block;

@end
