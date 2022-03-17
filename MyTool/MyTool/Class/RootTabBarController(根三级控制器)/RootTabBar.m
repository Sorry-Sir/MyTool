//
//  RootTabBar.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "RootTabBar.h"

@interface RootTabBar ()

@property(nonatomic,strong)UIButton *cusetomCenterBtn;

@end

@implementation RootTabBar

- (instancetype)init{
    if (self = [super init]){
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    _cusetomCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //  设定button大小为适应图片
    UIImage *normalImage = [UIImage imageNamed:@"_3TabbarNormal"];
    //根据图片调整button的位置(图片中心在tabbar的中间最上部，这个时候由于按钮是有一部分超出tabbar的，所以点击无效，要进行处理)
    _cusetomCenterBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - normalImage.size.width)/2.0, - normalImage.size.height/2.0, normalImage.size.width, normalImage.size.height);
    [_cusetomCenterBtn setImage:normalImage forState:UIControlStateNormal];
    //去除选择时高亮
    _cusetomCenterBtn.adjustsImageWhenHighlighted = NO;
    [_cusetomCenterBtn addTarget:self action:@selector(cusetomCenterBtnAcrtion:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_cusetomCenterBtn];
    
}

-(void)cusetomCenterBtnAcrtion:(UIButton *)sender{
    
    if (self.centerBtnBlock) {
        
        self.centerBtnBlock();
    }
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.hidden){
        return [super hitTest:point withEvent:event];
    }else {
        //转换坐标
        CGPoint tempPoint = [self.cusetomCenterBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.cusetomCenterBtn.bounds, tempPoint)){
            //返回按钮
            return _cusetomCenterBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}


@end
