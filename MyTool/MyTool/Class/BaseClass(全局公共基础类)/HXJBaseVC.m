//
//  HXJBaseVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "HXJBaseVC.h"

@interface HXJBaseVC ()

//导航栏左边返回按钮，有些主题色切还要用到
@property(nonatomic,strong)UIButton *naviLeftBackBtn;

@end

@implementation HXJBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=app_bgViewLightGrayColor;
    
    //配置导航栏
    [self configureBaseVCNaviBar];
    
    //取消导航栏对滑动视图的偏移64
    [self configureScrollViewDeviation];
    
}

//配置导航栏
-(void)configureBaseVCNaviBar{
    
    /**
     导航栏的透明效果，NO:视图会往下移64，在导航栏下面开始，YES:视图在导航栏后面开始。
     如果和下面关联起来，下面的最主要
     */
    self.navigationController.navigationBar.translucent=NO;
    
    /**
     extendedLayoutIncludesOpaqueBars:扩展布局包括不透明条
     YES：包括不透明条，在导航栏后面开始，
     NO：不包括透明条，在导航栏下面开始
     去掉毛玻璃或者导航栏设置背景图片导致searchviewcontroller错位后，一定要加上这两句
     
     ！！！！！！！
     导航栏不透明条，VC的视图在导航栏下面开始，不是在导航栏后面，也就是自动偏移了导航栏64或者88的高度，统一都是在导航栏下面开始。

     目的是：以后其他程序员xib可视化开发的时候，不用在考虑距离顶部的坐标是64还是88，不用引用头部距离在vc.m文件里修改高度了。
     
     ！！！！！！！
     不过建议还是纯代码开发，前期开发比较慢，但后期这样代码比xib好维护，和界面好复用和修改。比如其他项目差不多界面，直接可以复制出界面代码，界面修改会比xib好和快捷很多！！！
     */
    if ([self respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)]) {
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    /**
     这个设置会有问题，用下面的
     https://blog.csdn.net/sun_cui_hua/article/details/82350268
     状态栏白色:UIBarStyleBlack
     状态栏黑色:UIBarStyleDefault
     某个界面需要单独控制，自己控制器将要出现的时候重新赋值一次，消失的时候，在重新写会回来的颜色
     
     
     这个设置没有问题
     https://blog.csdn.net/ProgrammerWorking/article/details/78932928
     将status bar 文本颜色设置为白色
     self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
     将status bar 文本颜色设置为黑色 ,默认就是黑色
     self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
     */
    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    /**
    导航栏颜色设置
    */
    self.navigationController.navigationBar.barTintColor=app_NaviBarColor;
    
    /**
    导航栏字体设置
    */
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    
    
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    // 隐藏导航栏下的黑线
    navBarHairlineImageView.hidden = YES;
    
    /**
    导航栏返回按钮设置
    */
    if (self.navigationController.viewControllers.count > 1) {
        
        self.naviLeftBackBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.naviLeftBackBtn setImage:[UIImage imageNamed:@"箭头-左-白"] forState:(UIControlStateNormal)];
        [self.naviLeftBackBtn addTarget:self action:@selector(Action_BaseVCNaviLeftBtnGoBack) forControlEvents:(UIControlEventTouchUpInside)];
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.naviLeftBackBtn];
        
    }
    
}
//取消导航栏对滑动视图的偏移64
-(void)configureScrollViewDeviation{
    
    //取消导航栏对滑动视图的偏移64
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else{
       self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

//导航栏返回
- (void)Action_BaseVCNaviLeftBtnGoBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 导航栏下面的一根横线
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - 系统相关
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
    
}



@end
