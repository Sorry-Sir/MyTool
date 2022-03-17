//
//  UploadMaterialCollectionView.h
//  OO1
//
//  Created by admin on 2021/4/22.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import <UIKit/UIKit.h>



#pragma mark - 代理
@protocol UploadMaterialCollectionViewActionDelegate <NSObject>

-(void)collectionView_cellSelectAtIndexPath:(NSIndexPath *)indexPath;

-(void)collectionView_deleteBtnSelectAtIndexPath:(NSIndexPath *)indexPath;

@end







#pragma mark - collectionView类
@interface UploadMaterialCollectionView : UICollectionView

@property(nonatomic,strong)NSArray *photoArr;

@property(nonatomic,weak)id<UploadMaterialCollectionViewActionDelegate> actionDelegate;

@end










#pragma mark - cell类
@interface UploadMaterialCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imageIV;
@property(nonatomic,strong)UIButton *deleteBtn;

@end

