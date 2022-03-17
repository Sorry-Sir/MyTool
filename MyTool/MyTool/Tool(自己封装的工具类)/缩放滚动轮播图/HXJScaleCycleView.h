//
//  HXJScaleCycleView.h
//  OO1
//
//  Created by admin on 2020/10/23.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 滚动缩放轮播图
 */
@interface HXJScaleCycleView : UIView

//===========传入的数据
/**
 可以是本地图片名称，也可以是链接,也可以是image对象
 当图片自定义的时候，也可以传View对象
 */
@property(nonatomic,strong)NSArray *imageDataArr;
/**
 缩放的倍率
 */
@property(nonatomic,assign)CGFloat scaleNum;
//图片的宽高，不传默认和父视图一样的宽高
@property(nonatomic,assign)CGSize imageSize;
//是否显示二维码
@property(nonatomic,assign)BOOL isShowQRCode;
//二维码地址
@property(nonatomic,copy)NSString *QRCodeStr;



//===========给外面的数据
//轮播图片对象imageView,这个是View不是image，真个显示的View传出来，怕你们要用到，自己可以截图
@property(nonatomic,strong)NSMutableArray *cycleSeeImageViewArr;
/**
 选中的中心图片回调
 内部使用截图方法，返回的是image，不是imageView
 */
@property(nonatomic,copy)void (^selectedCenterImageBlock)(NSInteger index,UIImage *seeImage);



//============方法
//获得某个范围内的屏幕图像
- (UIImage *)clipImageFromView:(UIView *)theView;


@end



