//
//  UITapGestureRecognizer+AddTarget.h
//  OO1
//
//  Created by admin on 2020/3/6.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITapGestureRecognizer (AddTarget)

@property (copy,nonatomic) void(^tapActionBlock)(void);

- (instancetype)initWithTargetActionBlock:(void(^)(void))block;


@end

