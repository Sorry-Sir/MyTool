//
//  RootTabBarVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "RootTabBarVC.h"


#import "RootTabBar.h"
#import "OneVC.h"
#import "TwoVC.h"
#import "ThreeVC.h"
#import "FourVC.h"
#import "FiveVC.h"


@interface RootTabBarVC ()

@end

@implementation RootTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.barTintColor=[UIColor whiteColor];
    
    // 配置子控制器
    [self configureTabBarViewControllers];
    
    //创建tabbar中间的tabbarItem
    [self UI_addCenterBtn];
    
    //添加未读消息label
    [self UI_configureMessagesNumberLabel];
}

#pragma mark - 配置子控制器
-(void)configureTabBarViewControllers{
    
    //控制器数组
    NSArray *vcsArr=@[[OneVC new],
                      [TwoVC new],
                      [ThreeVC new],
                      [FourVC new],
                      [FiveVC new]];
    
    //图片数组
    NSArray *normalImagesArr = @[@"_1TabbarNormal",
                                  @"_2TabbarNormal",
                                  @"",
                                  @"_4TabbarNormal",
                                  @"_5TabbarNormal"];

    //选中图片的数组
    NSArray *selectedImagesArr = @[@"_1TabbarSelect",
                                   @"_2TabbarSelect",
                                   @"",
                                   @"_4TabbarSelect",
                                   @"_5TabbarSelect"];

    //标题数组
    NSArray *titlesArr = @[@"首页",@"消息",@"合作加盟",@"分享",@"我的"];

    NSInteger vcsCount = vcsArr.count;
    
    for (int i=0; i<vcsCount; i++) {

        [self setTabBarItemAndInitVC:vcsArr[i] nomarlImageNameStr:normalImagesArr[i] selectedImageNameStr:selectedImagesArr[i] titleStr:titlesArr[i]];

    }
    
    self.tabBar.tintColor = app_MainColor;
    self.tabBar.translucent=NO;
    
}

#pragma mark - 创建tabbar中间的tabbarItem
- (void)UI_addCenterBtn{
    
    RootTabBar *rootTabBar = [[RootTabBar alloc]init];
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:rootTabBar forKeyPath:@"tabBar"];
    
    __weak typeof(self) weakSelf = self;
    rootTabBar.centerBtnBlock = ^{
        
        weakSelf.selectedIndex = 2;
    };
    
}


-(void)UI_configureMessagesNumberLabel{
    
    // (第几个+0.6)/总个数
    float percentX = (1+0.6)/5;
    CGFloat x = ceilf(percentX*HXJkScreenWidth);
    CGFloat y = ceilf(0.1*HXJkTabBarHeight);
    
    self.messagesNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 20, 10)];
    [self.tabBar addSubview:self.messagesNumberLabel];
    self.messagesNumberLabel.font=[UIFont systemFontOfSize:8.0];
    self.messagesNumberLabel.layer.cornerRadius=10/2.0;
    self.messagesNumberLabel.layer.masksToBounds=YES;
    self.messagesNumberLabel.backgroundColor=[UIColor redColor];
    self.messagesNumberLabel.textColor=[UIColor whiteColor];
    self.messagesNumberLabel.textAlignment=NSTextAlignmentCenter;
    self.messagesNumberLabel.text=@"9";
}





- (void)setTabBarItemAndInitVC:(UIViewController *)vc nomarlImageNameStr:(NSString *)nomarlImageNameStr selectedImageNameStr:(NSString *)selectedImageNameStr titleStr:(NSString *)titleStr{

    HXJBaseNavigationVC *naviVC=[[HXJBaseNavigationVC alloc]initWithRootViewController:vc];

    naviVC.tabBarItem.image=[[UIImage imageNamed:nomarlImageNameStr]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    naviVC.tabBarItem.selectedImage=[[[UIImage imageNamed:selectedImageNameStr] imageChangeColor:app_MainColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    naviVC.tabBarItem.title=titleStr;

    //文本属性字典
    NSDictionary * attributes = @{
//        NSFontAttributeName : [UIFont systemFontOfSize:10.f],
        NSForegroundColorAttributeName : HXJRGB(150, 150, 150)
    };

    //被选中状态的文本属性字典
    NSDictionary * attributesSelected = @{
//        NSFontAttributeName : [UIFont systemFontOfSize:10.f],
        NSForegroundColorAttributeName : app_MainColor
    };
    
    //设置title的文本属性
    [naviVC.tabBarItem setTitleTextAttributes:attributes forState:UIControlStateNormal];

    [naviVC.tabBarItem setTitleTextAttributes:attributesSelected forState:UIControlStateSelected];
    
    [self addChildViewController:naviVC];

}

@end


