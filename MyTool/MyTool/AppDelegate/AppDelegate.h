//
//  AppDelegate.h
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//屏幕窗口
@property(nonatomic,strong)UIWindow *window;
//屏幕是否可旋转
@property(nonatomic,assign)BOOL allowRotation;

@end

