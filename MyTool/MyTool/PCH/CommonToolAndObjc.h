//
//  CommonToolAndObjc.h
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#ifndef CommonToolAndObjc_h
#define CommonToolAndObjc_h



//=========================常用的类目
//中文输出
#import "Foundation+Log.h"
//寻找视图当前控制器
#import "UIView+FindController.h"
//Btn通过block事件调用，方便事件在旁边，阅读代码逻辑
#import "UIButton+AddTarget.h"
//tap手势通过block事件调用，方便事件在旁边，阅读代码逻辑
#import "UITapGestureRecognizer+AddTarget.h"
//白色图片，可以修改颜色。这样主题色修改，一张图片就够
#import "UIImage+ChangeColor.h"



//========================一些定义基础公共的类和单例类
#import "HXJBaseVC.h"
#import "HXJBaseNavigationVC.h"
//App颜色的设置，工具等，全在这个类，方便调用，不用每个类去找
#import "HXJAppTool.h"



#endif /* CommonToolAndObjc_h */
