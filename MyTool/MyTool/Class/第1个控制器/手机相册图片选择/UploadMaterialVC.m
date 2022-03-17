//
//  UploadMaterialVC.m
//  OO1
//
//  Created by admin on 2021/4/22.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import "UploadMaterialVC.h"


#import "Tool_SelectPhoto.h"
#import "UploadMaterialCollectionView.h"
#import <SVProgressHUD.h>


@interface UploadMaterialVC ()<UploadMaterialCollectionViewActionDelegate,UITextViewDelegate>

//==========UI
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UITextView *tipsText;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UploadMaterialCollectionView *collectionView;


//==========数据
@property(nonatomic,strong)NSMutableArray *photoArrM;
@property(nonatomic,strong)NSMutableArray *assetsArrM;

@end

@implementation UploadMaterialVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title=@"手机相册图片选择";
    
    [self configureVCUI];
}

#pragma mark - 创建UI
-(void)configureVCUI{
    
    __HXJWeakSelf;
    
    //==================
    UIScrollView *bgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, HXJkScreenHeight-HXJkTopHeight)];
    [self.view addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator=NO;
    bgScrollView.showsHorizontalScrollIndicator=NO;
    
    
    //==============
    UIView *typeTipsBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, 40*HXJkWScale)];
    [bgScrollView addSubview:typeTipsBgView];
    typeTipsBgView.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *typeTipsLabel=[[UILabel alloc]initWithFrame:CGRectMake(10*HXJkWScale, 10*HXJkWScale, 200*HXJkWScale, 20*HXJkWScale)];
    [typeTipsBgView addSubview:typeTipsLabel];
    typeTipsLabel.font=[UIFont systemFontOfSize:14.0];
    typeTipsLabel.text=@"请选择类别";
    
    
    self.typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(HXJkScreenWidth-220*HXJkWScale, 10*HXJkWScale, 200*HXJkWScale, 20*HXJkWScale)];
    [typeTipsBgView addSubview:self.typeLabel];
    self.typeLabel.font=[UIFont systemFontOfSize:14.0];
    self.typeLabel.textAlignment=NSTextAlignmentRight;
    self.typeLabel.text=@"图文";
    
    
    UIImageView *rightIV=[[UIImageView alloc]initWithFrame:CGRectMake(HXJkScreenWidth-20*HXJkWScale, 10*HXJkWScale, 10*HXJkWScale, 20*HXJkWScale)];
    [typeTipsBgView addSubview:rightIV];
    rightIV.image=[UIImage imageNamed:@"箭头-右-灰"];
    rightIV.contentMode=UIViewContentModeCenter;
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 40*HXJkWScale-1, HXJkScreenWidth, 1)];
    [typeTipsBgView addSubview:lineView];
    lineView.backgroundColor=HXJRGB(230, 230, 230);
    
    
    UIButton *typeBgViewBtn=[[UIButton alloc]initWithFrame:typeTipsBgView.bounds];
    [typeTipsBgView addSubview:typeBgViewBtn];
    [typeBgViewBtn addTargetActionBlock:^(UIButton *btn) {
       
        [weakSelf Action_typeBgViewBtn];
    }];
    
    
    //==============
    UIView *photoTipsBgView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(typeTipsBgView.frame), HXJkScreenWidth, 120*HXJkWScale)];
    [bgScrollView addSubview:photoTipsBgView];
    photoTipsBgView.backgroundColor=[UIColor whiteColor];
    
    
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(10*HXJkWScale, 10*HXJkWScale, HXJkScreenWidth-20*HXJkWScale, 100*HXJkWScale)];
    [photoTipsBgView addSubview:self.textView];
    self.textView.font=[UIFont systemFontOfSize:15.0];
    self.textView.delegate=self;
    
    
    self.tipsText=[[UITextView alloc]initWithFrame:CGRectMake(10*HXJkWScale, 10*HXJkWScale, 100*HXJkWScale, 40*HXJkWScale)];
    [photoTipsBgView addSubview:self.tipsText];
    self.tipsText.font=[UIFont systemFontOfSize:15.0];
    self.tipsText.text=@"请输入";
    self.tipsText.userInteractionEnabled=NO;
    self.tipsText.textColor=[UIColor lightGrayColor];
    
    
    
    //==============
    self.collectionView=[[UploadMaterialCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(photoTipsBgView.frame), HXJkScreenWidth, 350*HXJkWScale)];
    [bgScrollView addSubview:self.collectionView];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.actionDelegate=self;
    
    
    
    //================
    UIButton *uploadBtn=[[UIButton alloc]initWithFrame:CGRectMake(20*HXJkWScale, CGRectGetMaxY(self.collectionView.frame)+30*HXJkWScale, HXJkScreenWidth-40*HXJkWScale, 50*HXJkWScale)];
    [bgScrollView addSubview:uploadBtn];
    [uploadBtn setTitle:@"发 布" forState:(UIControlStateNormal)];
    [uploadBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    uploadBtn.backgroundColor=app_MainColor;
    uploadBtn.titleLabel.font=[UIFont systemFontOfSize:17.0];
    uploadBtn.layer.cornerRadius=5.0;
    uploadBtn.layer.masksToBounds=YES;
    [uploadBtn addTargetActionBlock:^(UIButton *btn) {
        
        [weakSelf Action_uploadBtn];
    }];
    
    
    
    //=================
    CGFloat maxHeight=CGRectGetMaxY(uploadBtn.frame)+30*HXJkWScale;
    maxHeight=(maxHeight>bgScrollView.bounds.size.height)?maxHeight:bgScrollView.bounds.size.height+1;
    bgScrollView.contentSize=CGSizeMake(HXJkScreenWidth, maxHeight);
  
    
}

#pragma mark - textView代理回调
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    self.tipsText.hidden=YES;
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if (self.textView.text.length) {
        
        self.tipsText.hidden=YES;
    }else{
        
        self.tipsText.hidden=NO;
    }
    
    return YES;
}


#pragma mark - collectionView按钮事件代理回调
-(void)collectionView_cellSelectAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==self.photoArrM.count&&self.photoArrM.count<9) {
        
        //最后一个点击，添加图片
        [self Even_addPhoto];
        
    }else{
        //查看图片
        [[Tool_SelectPhoto shareSelectPhotoManager]lookSelectPhotoWithSuperVC:self selectedPhotos:self.photoArrM selectedAssets:self.assetsArrM selectIndex:indexPath.row];
    }
    
}

-(void)Even_addPhoto{
    
    UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"" message:@"请选择" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"使用相机现拍" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [[Tool_SelectPhoto shareSelectPhotoManager] goToTakePictureWithSuperVC:self selectBlock:^(NSArray *photos, NSArray *assets) {
            
            [self.photoArrM addObjectsFromArray:photos];
            [self.assetsArrM addObjectsFromArray:assets];
            
            self.collectionView.photoArr=self.photoArrM;
        }];
        
    }];
    
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"从相册中选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [[Tool_SelectPhoto shareSelectPhotoManager]goToSelcetPhotoWithMaxImagesCount:9 selectedAssets:self.assetsArrM superVC:self selectBlock:^(NSArray *photos, NSArray *assets) {
            
            self.photoArrM=[photos mutableCopy];
            self.assetsArrM=[assets mutableCopy];
            
            self.collectionView.photoArr=self.photoArrM;
        }];
        
    }];
    
    UIAlertAction *action3=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    
    [self presentViewController:alertC animated:YES completion:nil];
}




-(void)collectionView_deleteBtnSelectAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.photoArrM removeObjectAtIndex:indexPath.row];
    [self.assetsArrM removeObjectAtIndex:indexPath.row];
    
    self.collectionView.photoArr=self.photoArrM;
    
}


#pragma mark -  按钮事件
-(void)Action_typeBgViewBtn{
    
    UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"" message:@"请选择类别" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"图文" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"视频" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [SVProgressHUD showInfoWithStatus:@"暂未开放"];
    }];
    
    UIAlertAction *action3=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:action1];
    [alertC addAction:action2];
    [alertC addAction:action3];
    
    [self presentViewController:alertC animated:YES completion:nil];
}


-(void)Action_uploadBtn{
    
    if (self.textView.text.length < 1 && self.photoArrM.count == 0) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入内容"];
        return;
    }
    
    
}




#pragma mark - 懒加载

-(NSMutableArray *)photoArrM{
    
    if (_photoArrM==nil) {
        
        _photoArrM=[[NSMutableArray alloc]init];
    }
    
    return _photoArrM;
}

-(NSMutableArray *)assetsArrM{
    
    if (_assetsArrM==nil) {
        
        _assetsArrM=[[NSMutableArray alloc]init];
    }
    
    return _assetsArrM;
}



@end
