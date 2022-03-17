//
//  Tool_SelectPhoto.h
//  OO1
//
//  Created by admin on 2021/4/22.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import <Foundation/Foundation.h>


//选择后的回调
typedef void(^Tool_SelectPhotoSelectBlock)(NSArray *photos,NSArray *assets);


/**
 手机相册选择图片工具
 */
@interface Tool_SelectPhoto : NSObject

//单例
+(instancetype)shareSelectPhotoManager;

//去相册选择照片
- (void)goToSelcetPhotoWithMaxImagesCount:(NSInteger)imagesCount
                           selectedAssets:(NSMutableArray *)selectedAssets
                                  superVC:(UIViewController *)superVC
                              selectBlock:(Tool_SelectPhotoSelectBlock)selectBlock;
//去拍摄照片
- (void)goToTakePictureWithSuperVC:(UIViewController *)superVC
                      selectBlock:(Tool_SelectPhotoSelectBlock)selectBlock;

//去预览选择好的照片
-(void)lookSelectPhotoWithSuperVC:(UIViewController *)superVC
                   selectedPhotos:(NSMutableArray *)selectedPhotos
                   selectedAssets:(NSMutableArray *)selectedAssets
                      selectIndex:(NSInteger)index;

@end


