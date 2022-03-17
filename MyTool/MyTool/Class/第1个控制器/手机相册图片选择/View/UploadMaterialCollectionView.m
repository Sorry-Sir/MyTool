//
//  UploadMaterialCollectionView.m
//  OO1
//
//  Created by admin on 2021/4/22.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import "UploadMaterialCollectionView.h"


#define UploadMaterialCollectionViewCellID @"UploadMaterialCollectionViewCellID"

#define ItemSizeWidth (100*HXJkWScale)
#define ItemSizeHeight (100*HXJkWScale)

#pragma mark - UploadMaterialCollectionView类
@interface UploadMaterialCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation UploadMaterialCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    
    //创建一个layout布局类
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    CGFloat space=(HXJkScreenWidth-100*HXJkWScale*3)/4;
    
    flowLayout.itemSize = CGSizeMake(ItemSizeWidth, ItemSizeHeight);
    flowLayout.sectionInset=UIEdgeInsetsMake(10*HXJkWScale, space-5, 10*HXJkWScale, space-5);
    
    self=[super initWithFrame:frame collectionViewLayout:flowLayout];
    
    if (self) {
        
        [self configureCollectionViewUI];
    }
    
    return self;
}

#pragma mark - 创建UI
-(void)configureCollectionViewUI{
    
    self.backgroundColor=[UIColor clearColor];
    
    self.showsVerticalScrollIndicator=NO;
    self.showsHorizontalScrollIndicator=NO;
    
    self.delegate=self;
    self.dataSource=self;
    //注册item类型 这里使用系统的类型
    [self registerClass:[UploadMaterialCollectionViewCell class] forCellWithReuseIdentifier:UploadMaterialCollectionViewCellID];
}


#pragma mark - 代理相关
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.photoArr.count<9) {
        
        return self.photoArr.count+1;
    }else{
        
        return self.photoArr.count;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UploadMaterialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UploadMaterialCollectionViewCellID forIndexPath:indexPath];
    
    if (indexPath.row==self.photoArr.count && self.photoArr.count<9) {

        cell.imageIV.image=[UIImage imageNamed:@"优享E家朋友圈_添加"];
        cell.deleteBtn.hidden=YES;
    }else{
        
        cell.imageIV.image=self.photoArr[indexPath.row];
        cell.deleteBtn.hidden=NO;
        
        __HXJWeakSelf;
        [cell.deleteBtn addTargetActionBlock:^(UIButton *btn) {
                    
            if (weakSelf.actionDelegate) {
                
                [weakSelf.actionDelegate collectionView_deleteBtnSelectAtIndexPath:indexPath];
            }
        }];
        
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.actionDelegate) {
        
        [self.actionDelegate collectionView_cellSelectAtIndexPath:indexPath];
    }
    
}


#pragma mark - set
-(void)setPhotoArr:(NSArray *)photoArr{
    
    _photoArr=photoArr;
    
    [self reloadData];
}


@end









#pragma mark - UploadMaterialCollectionViewCell类
@interface UploadMaterialCollectionViewCell ()


@end

@implementation UploadMaterialCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self configureUI];
    }
    
    return self;
}

-(void)configureUI{
    
    self.imageIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ItemSizeWidth, ItemSizeHeight)];
    [self.contentView addSubview:self.imageIV];
    self.imageIV.layer.cornerRadius=5.0;
    self.imageIV.layer.masksToBounds=YES;
    
    
    self.deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(ItemSizeWidth-30*HXJkWScale, 0, 30*HXJkWScale, 30*HXJkWScale)];
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn setImage:[UIImage imageNamed:@"优享E家朋友圈_删除"] forState:(UIControlStateNormal)];
    
    
}



@end






