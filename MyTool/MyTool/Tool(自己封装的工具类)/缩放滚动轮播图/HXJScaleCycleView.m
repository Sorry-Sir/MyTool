//
//  HXJScaleCycleView.m
//  OO1
//
//  Created by admin on 2020/10/23.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import "HXJScaleCycleView.h"


#import "UIImageView+WebCache.h"


#define Space (10.0)


@interface HXJScaleCycleView ()<UIScrollViewDelegate>

//滚动视图
@property(nonatomic,strong)UIScrollView *bgScrollView;

@end


@implementation HXJScaleCycleView

#pragma mark - set数据
-(void)setImageDataArr:(NSArray *)imageDataArr{
    
    _imageDataArr=imageDataArr;
    
    for (UIView *subView in self.subviews) {
        
        [subView removeFromSuperview];
    }
    
    [self configureUI];
    
}

#pragma mark - 创建UI
-(void)configureUI{
    
    //===========数据计算
    CGFloat imageViewWidth=self.imageSize.width?self.imageSize.width:self.bounds.size.width;
    CGFloat imageViewHeight=self.imageSize.height?self.imageSize.height:self.bounds.size.height;
    NSInteger phototCount=_imageDataArr.count;
    
    
    
    //==========bgScrollView搭建
    self.bgScrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:self.bgScrollView];
    //打开分页管理
//    self.bgScrollView.pagingEnabled=YES;
    //关掉滑动条
    self.bgScrollView.showsHorizontalScrollIndicator=NO;
    //代理回调
    self.bgScrollView.delegate=self;
    
    //图片对象
    UIImageView *imageView;
    CGFloat topSpace=(self.bounds.size.width-imageViewWidth)/2;
    
    //==========创建里面的ImageView
    for (int i=0; i<phototCount; i++) {
        
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(topSpace+((imageViewWidth*self.scaleNum-imageViewWidth)/2+Space+imageViewWidth)*i, (self.bounds.size.height-imageViewHeight)/2, imageViewWidth, imageViewHeight)];
        [self.bgScrollView addSubview:imageView];
        
        //设置图片
        [self theImageView:imageView addTheView:_imageDataArr[i]];
        
        
        //是否显示二维码
        if (self.isShowQRCode) {
            
            UIImageView *codeImageView=[[UIImageView alloc]initWithFrame:CGRectMake((imageView.bounds.size.width-50)/2, imageView.bounds.size.height-60, 50, 50)];
            [imageView addSubview:codeImageView];
            codeImageView.image =[self QRCode_createQRCodeImageWithString:self.QRCodeStr withSize:200];
        }
        
        
        //=========存储图片对象
        [self.cycleSeeImageViewArr addObject:imageView];
        
        
        //=========设置默认值
        if (i==0) {
            //设置划到默认第一张
            [self.bgScrollView setContentOffset:CGPointMake(imageView.center.x-self.bounds.size.width/2, 0) animated:NO];
            
            //设置第一张的缩放
            [self Action_scaleImagevWithCurrentCenterX:(imageView.center.x)];
        }
    }
    
    
    
    //内容大小,最后加上尾部和头部一样的大小
    self.bgScrollView.contentSize=CGSizeMake(CGRectGetMaxX(imageView.frame)+topSpace, self.bounds.size.height);
    
    
}


-(void)theImageView:(UIImageView *)imageView addTheView:(id)theView{
    
    if([theView isMemberOfClass:[UIImage class]]){
        
        //是图片对象
        imageView.image=theView;
        
    }else if([theView isKindOfClass:[UIView class]]){
        
        UIView *tempView=theView;
        tempView.frame=CGRectMake(0, 0, tempView.bounds.size.width, tempView.bounds.size.height);
        
        //是View对象
        [imageView addSubview:tempView];
        
    }else if([self isWebUrlStr:theView]) {
        //是网址
        [imageView sd_setImageWithURL:theView];
        
    }else{
        //是本地图片名称
        imageView.image=[UIImage imageNamed:theView];
    }
    
}


- (BOOL)isWebUrlStr:(NSString *)urlStr{
    
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:urlStr];
}



#pragma mark - 缩放
//对图片进行缩放的方法
-(void)Action_scaleImagevWithCurrentCenterX:(CGFloat)currentCenterX{
    
    for (UIImageView *imageView in self.cycleSeeImageViewArr) {
        
        //计算当前控件与显示区中心点的相对距离
        CGFloat distanceX = ABS(imageView.center.x - currentCenterX);
        
        CGFloat imageViewWidth = self.imageSize.width ? self.imageSize.width : self.bounds.size.width;
        CGFloat twoPicturesCenterDistance = imageViewWidth*self.scaleNum/2.0+Space+imageViewWidth/2.0;
        
        //当前距离只要小于缩放距离，就进入缩放
        if (distanceX < twoPicturesCenterDistance) {
            //设置缩放系数
            CGFloat factor=1.0 - (distanceX/twoPicturesCenterDistance);
            CGFloat zoomDifference = ABS(1 - self.scaleNum);
            
            if (self.scaleNum>=1.0) {
                //进行缩放（放大的）
                imageView.transform=CGAffineTransformMakeScale(1.0+zoomDifference*factor, 1.0+zoomDifference*factor);
            }else{
                //进行缩放（缩小的）
                imageView.transform=CGAffineTransformMakeScale(1.0-zoomDifference*factor, 1.0-zoomDifference*factor);
            }
            
        }else{
            //不缩放
            imageView.transform=CGAffineTransformIdentity;
        }

    }
    
}


#pragma mark - UIScrollViewDelegate
//当滑动到特定图片，切换位置，达到无限滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //=======数据
    CGPoint point = self.bgScrollView.contentOffset;
    CGFloat currentCenterX = (point.x+self.bounds.size.width/2.0);
    
    
    //=======设置缩放
    [self Action_scaleImagevWithCurrentCenterX:currentCenterX];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //=========监听停止滚动
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    
    if (scrollToScrollStop) {
        
        [self Action_adjustmentBgScrollView_imageToCenter_andBackBlock];
    }
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //=========监听停止滚动
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        
        if (dragToDragStop) {
            
            [self Action_adjustmentBgScrollView_imageToCenter_andBackBlock];
            
        }
    }
    
}



//调整bgScrollView坐标,让图片居中，并回调block
-(void)Action_adjustmentBgScrollView_imageToCenter_andBackBlock{
    
    //目标偏移量
    CGPoint point = self.bgScrollView.contentOffset;
    
    //单元格宽度
    CGFloat imageViewWidth = self.imageSize.width ? self.imageSize.width : self.bounds.size.width;
    
    //第一张图片的前面距离
    CGFloat topSpace=(self.bounds.size.width-imageViewWidth)/2;
    
    //最终要停留的页数
    NSInteger index = ((point.x + self.bounds.size.width/2.0)-topSpace)/((imageViewWidth*self.scaleNum-imageViewWidth)/2+Space+imageViewWidth);
    
    UIImageView *imageView=self.cycleSeeImageViewArr[index];
    
    [self.bgScrollView setContentOffset:CGPointMake(imageView.center.x-self.bounds.size.width/2.0, 0) animated:YES];
    
    UIImage *seeImage=[self clipImageFromView:imageView];
    
    if (self.selectedCenterImageBlock) {
        
        self.selectedCenterImageBlock(index, seeImage);
    }
    
}

#pragma mark - 截图
//获得某个范围内的屏幕图像
- (UIImage *)clipImageFromView:(UIView *)theView{
    /*
    1.开启图片上下文
    *UIGraphicsBeginImageContextWithOptions有三个参数
    *size    bitmap上下文的大小，就是生成图片的size
    *opaque  是否不透明，当指定为YES的时候图片的质量会比较好
    *scale   缩放比例，指定为0.0表示使用手机主屏幕的缩放比例
    */
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, [UIScreen mainScreen].scale);
    //2.获取当前的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    //UIView之所以能够显示，是因为它内部有一个层layer，通过渲染的形式绘制上下文
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0){

        [theView drawViewHierarchyInRect:theView.bounds afterScreenUpdates:YES];

    } else { // IOS7之前的版本

        [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    //生成一张图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
      
    return  theImage;
}


#pragma mark - 二维码生成
-(UIImage *)QRCode_createQRCodeImageWithString:(NSString *)string withSize:(CGFloat)size{
    // 实例化二维码滤镜
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性（因为滤镜可能保存上一次的属性）
    [filter setDefaults];
    // 讲字符串转换为NSData
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 通过了滤镜输出的图像
    CIImage * outputImage = [filter outputImage];
    // 来获得高清的二维码图片
    UIImage * image = [self getQRCodeImageFormCIImage:outputImage withSize:size];
    return image;
}

-(UIImage *)getQRCodeImageFormCIImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}



#pragma mark - 懒加载
-(NSMutableArray *)cycleSeeImageViewArr{
    
    if (_cycleSeeImageViewArr==nil) {
        
        _cycleSeeImageViewArr=[[NSMutableArray alloc]init];
    }
    
    return _cycleSeeImageViewArr;
}


@end
