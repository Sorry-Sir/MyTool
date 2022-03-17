//
//  RootTabBar.h
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import <UIKit/UIKit.h>

typedef void (^CusetomCenterBtnDidClickBlock)(void);

@interface RootTabBar : UITabBar

@property(nonatomic,copy)CusetomCenterBtnDidClickBlock centerBtnBlock;

@end


