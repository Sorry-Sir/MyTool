//
//  AppDelegate+Login.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "AppDelegate+Login.h"


#import "RootTabBarVC.h"

@implementation AppDelegate (Login)

-(void)login_gotoLoginVC{
    
    
    RootTabBarVC *rootTabBarVC=[[RootTabBarVC alloc]init];
    [[UIApplication sharedApplication] keyWindow].rootViewController=rootTabBarVC;
    
}


@end
