//
//  AppDelegate+AllowRotation.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "AppDelegate+AllowRotation.h"



@implementation AppDelegate (AllowRotation)

-(UIInterfaceOrientationMask)allowRotation_canRotation{
    
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}


@end
