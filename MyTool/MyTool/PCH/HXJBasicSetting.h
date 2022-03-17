//
//  HXJBasicSetting.h
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#ifndef HXJBasicSetting_h
#define HXJBasicSetting_h



//适配========================
//屏幕宽高
#define HXJkScreenBounds         ([UIScreen mainScreen].bounds)
#define HXJkScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define HXJkScreenHeight         ([UIScreen mainScreen].bounds.size.height)
//适配比例系数，一般宽高都乘以kWScale，不用kHScale，kHScale变化系数太大，界面显示不友好
#define HXJkWScale               (HXJkScreenWidth/375.0)
#define HXJkHScale               (HXJkScreenHeight/667.0)

//导航栏相关高度
#define HXJkStatusBarHeight      ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define HXJkNaviBarHeight        (44.0)
#define HXJkTopHeight            (HXJkStatusBarHeight+HXJkNaviBarHeight)
//tabbar相关高度
#define HXJkBottomSafetyHeight   (HXJkStatusBarHeight>20?34.0:0.0)
#define HXJkTabBarHeight         (49.0)
#define HXJkBottomHeight         (HXJkBottomSafetyHeight+HXJkTabBarHeight)




//弱引用=========================
#define __HXJWeakSelf            __weak typeof(self) weakSelf = self;




//RGB===========================
#define HXJRGB(r, g, b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define HXJRGBAlpha(r, g, b,a)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HXJRGBHexValue(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]




#endif /* HXJBasicSetting_h */
