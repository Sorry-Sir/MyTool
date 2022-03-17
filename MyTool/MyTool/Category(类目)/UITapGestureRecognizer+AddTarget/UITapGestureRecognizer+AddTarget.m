//
//  UITapGestureRecognizer+AddTarget.m
//  OO1
//
//  Created by admin on 2020/3/6.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import "UITapGestureRecognizer+AddTarget.h"

#import "objc/runtime.h"



@implementation UITapGestureRecognizer (AddTarget)


- (instancetype)initWithTargetActionBlock:(void(^)(void))block{
    
    self.tapActionBlock=block;
    
    
    return [self initWithTarget:self action:@selector(__tapAction)];
}


- (void)__tapAction{
    
    if (self.tapActionBlock){
        
        self.tapActionBlock();
    }
    
}


/*
 https://www.cnblogs.com/n1ckyxu/p/6198594.html
 在Category下无法直接添加Property，这里又需要通过Runtime来做相应的设置了：
 在.m中，引入
 objc/runtime.h
 并实现set和get方法
 然后实现刚声明的addActionBlock方法
 这就完成了一个事件的响应
 后面就可以直接通过,来添加这个响应事件了
 但是 请注意
 由于property中的block 只有1个！！！在设置多个event的时候，原来设置的block会被覆盖
 那么这种情况该如何解决呢？
 傻瓜一点的方法：
 不同event分别添加不同的action和block，对应响应即可
 */

-(void)setTapActionBlock:(void (^)(void))tapActionBlock{
    
    objc_setAssociatedObject(self, @selector(tapActionBlock), tapActionBlock, OBJC_ASSOCIATION_COPY);
}

-(void (^)(void))tapActionBlock{
    
    return objc_getAssociatedObject(self, _cmd);
}




@end
