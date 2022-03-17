//
//  OtherProjectRelated.h
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#ifndef OtherProjectRelated_h
#define OtherProjectRelated_h


//调试输出===================
#ifdef DEBUG
#define NSLog(format, ...) printf("\n=======================\n**********************\n[%s] %s [第%d行]\n%s\n**********************\n====================\n\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define NSLog(format, ...)
#endif




//查看当前线程======================
#define NSLogCurrentThread(message)   NSLog(@"标记:%@\n当前线程:%@",message,[NSThread currentThread]);




//处理nil，为空字符串@""======================
#define Nil_To_Null_Sring(x)    if(x == nil || [x isKindOfClass:[NSNull class]]){x = @"";}
#define Nil_To_Null_Arry(x)     if(x == nil || [x isKindOfClass:[NSNull class]]){x = @[];}
#define Nil_To_Null_Dict(x)     if(x == nil || [x isKindOfClass:[NSNull class]]){x = @{};}



//NSUserDefaults===========================
// 取
#define n_UserDefaultsGet(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
// 写
#define n_UserDefaultsSet(object,key) [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",object] forKey:key]
// 存
#define n_UserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize]
// 删
#define n_UserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]



//主题颜色==============
/**
 导航栏颜色
 */
#define app_NaviBarColor    [HXJAppTool shareTool].appNaviBarColor
/**
App主题色
*/
#define app_MainColor       [HXJAppTool shareTool].appMainColor
/**
 App self.view等背景亮灰色
 */
#define app_bgViewLightGrayColor     HXJRGB(245, 245, 245)




//NSUserDefaults写入本地的key=============
//主题色,有没有#号都没事
#define n_ThemeColor_appMainColor     @"ThemeColor_appMainColor"
//导航栏颜色,有没有#号都没事
#define n_ThemeColor_appNaviBarColor     @"ThemeColor_appNaviBarColor"





#endif /* OtherProjectRelated_h */
