//
//  UIView+FindController.m
//  MyToolDemo
//
//  Created by sorry.sir on 2017/8/3.
//  Copyright © 2017年 hongxujia. All rights reserved.
//

#import "UIView+FindController.h"

@implementation UIView (FindController)


-(UIViewController *)findViewController{
    
    UIResponder *responser = [self nextResponder];
    do {
        if ([responser isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responser;
        }
        responser = [responser nextResponder];
    } while (responser != nil);
    return nil;
    
}

-(UINavigationController *)findNavigationController{
    
    UIResponder *responser = [self nextResponder];
    do {
        if ([responser isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)responser;
        }
        responser = [responser nextResponder];
    } while (responser != nil);
    return nil;
    
}

@end
