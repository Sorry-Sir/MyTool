//
//  HXJBaseNavigationVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "HXJBaseNavigationVC.h"

@interface HXJBaseNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation HXJBaseNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureBaseNavigationController];
}

//配置导航栏的一些设置
-(void)configureBaseNavigationController{

    //修复navigationController侧滑关闭失效的问题，leftBarButtonItem自定义返回按钮后, 侧滑手势会失效
    self.interactivePopGestureRecognizer.delegate = (id)self;
}


#pragma mark - UIGestureRecognizerDelegate  leftBarButtonItem自定义返回按钮后, 侧滑手势会失效
//让手势生效
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.viewControllers.count > 1) {

        return YES;
    }else{

        return NO;
    }
}

// 允许同时响应多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer{
    
    return YES;
}

//禁止响应手势的是否ViewController中scrollView跟着滚动
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {
    
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}



#pragma mark - hidesBottomBarWhenPushed
/**

 1.配置整个app  在导航栏Navigation   push的时候   hidesBottomBarWhenPushed   隐藏tabbar
 
 2.系统原生的Tabbar在push的时候会上移
 在UINavigationController的基类重写pushViewController代理方法，在Push的时候修正一下TabBar的frame
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //push的时候隐藏tabBra
    if (self.viewControllers.count > 0) {
          
        // 当前导航栏, 只有第一个viewController push的时候设置隐藏
        if (self.viewControllers.count == 1) {
        
            viewController.hidesBottomBarWhenPushed = YES;
        }
    } else {
    
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
    
    [super pushViewController:viewController animated:animated];
    
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}



@end
