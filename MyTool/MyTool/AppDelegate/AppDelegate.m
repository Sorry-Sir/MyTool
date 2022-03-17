//
//  AppDelegate.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "AppDelegate.h"


//类目分层
#import "AppDelegate+AllowRotation.h"
#import "AppDelegate+Login.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //加载界面增长时间
    [NSThread sleepForTimeInterval:1.0];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //设置窗口等级，比状态栏等级高，盖在状态栏上面
    //self.window.windowLevel=UIWindowLevelStatusBar;
    
    //不允许旋转屏幕
    self.allowRotation=NO;
    
    //设置项目的一些默认值，比如主题色，实名认证方式等
    [self configureSetDefaultValue];
    
    //去登入页面
    [self login_gotoLoginVC];

    
    return YES;
}


//是否可以旋转屏幕
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{

    return [self allowRotation_canRotation];
}


#pragma mark - 设置项目的一些默认值，比如主题色，实名认证方式等
//设置项目的一些默认值，比如主题色，实名认证方式等
-(void)configureSetDefaultValue{
    
    //============主题色
    NSString *appMainColorStr = n_UserDefaultsGet(n_ThemeColor_appMainColor);
    
    if (appMainColorStr.length==0 || [appMainColorStr containsString:@"null"] || [appMainColorStr containsString:@"NULL"]) {
        
        //没有设置 设置默认主题色,有没有#号都没事
        n_UserDefaultsSet(@"#F45D2A", n_ThemeColor_appMainColor);
        
    }
    
    //============导航栏颜色
    NSString *appNaviBarColorStr = n_UserDefaultsGet(n_ThemeColor_appNaviBarColor);
    
    if (appNaviBarColorStr.length==0 || [appNaviBarColorStr containsString:@"null"] || [appNaviBarColorStr containsString:@"NULL"]) {
        
        //没有设置 设置默认导航栏颜色,有没有#号都没事
        n_UserDefaultsSet(@"F45D2A", n_ThemeColor_appNaviBarColor);
        
    }
    
    //保存
    n_UserDefaultsSynchronize;
}





@end
