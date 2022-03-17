//
//  FMDBVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "FMDBVC.h"


#import "FMDBVCTableView.h"
#import "FMDBTool.h"


@interface FMDBVC ()

@property(nonatomic,strong)FMDBVCTableView *tableView;
@property(nonatomic,strong)UITextField *nameTF;
@property(nonatomic,strong)UITextField *ageTF;

@property(nonatomic,strong)NSMutableArray *dataArrM;

@end

@implementation FMDBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"Sqlit使用";
    
    [self UI_configureVCUI];
}

#pragma mark - UI创建
-(void)UI_configureVCUI{
    
    __HXJWeakSelf;
    
    //==========
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20*HXJkWScale, 30*HXJkWScale, 60*HXJkWScale, 40*HXJkWScale)];
    [self.view addSubview:nameLabel];
    nameLabel.font=[UIFont systemFontOfSize:14.0];
    nameLabel.text=@"姓名:";
    nameLabel.textColor=[UIColor blackColor];
    
    
    self.nameTF=[[UITextField alloc]initWithFrame:CGRectMake(80*HXJkWScale, 30*HXJkWScale, HXJkScreenWidth-100*HXJkWScale, 40*HXJkWScale)];
    [self.view addSubview:self.nameTF];
    self.nameTF.font=[UIFont systemFontOfSize:14.0];
    self.nameTF.placeholder=@"请输入姓名";
    self.nameTF.textColor=[UIColor blackColor];
    self.nameTF.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *ageLabel=[[UILabel alloc]initWithFrame:CGRectMake(20*HXJkWScale, 80*HXJkWScale, 60*HXJkWScale, 40*HXJkWScale)];
    [self.view addSubview:ageLabel];
    ageLabel.font=[UIFont systemFontOfSize:14.0];
    ageLabel.text=@"年龄:";
    ageLabel.textColor=[UIColor blackColor];
    
    
    self.ageTF=[[UITextField alloc]initWithFrame:CGRectMake(80*HXJkWScale, 80*HXJkWScale, HXJkScreenWidth-100*HXJkWScale, 40*HXJkWScale)];
    [self.view addSubview:self.ageTF];
    self.ageTF.font=[UIFont systemFontOfSize:14.0];
    self.ageTF.placeholder=@"请输入年龄";
    self.ageTF.textColor=[UIColor blackColor];
    self.ageTF.backgroundColor=[UIColor whiteColor];
    self.ageTF.keyboardType=UIKeyboardTypeNumberPad;
    
    
    //=============
    NSArray *btnTitleArr=@[@"增加",@"查询",@"删除",@"全部删除"];
    CGFloat btnWidth=HXJkScreenWidth/btnTitleArr.count;
    
    for (int i=0; i<4; i++) {
        
        UIButton *temBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnWidth*i, 140*HXJkWScale, btnWidth, 30*HXJkWScale)];
        [self.view addSubview:temBtn];
        [temBtn setTitle:btnTitleArr[i] forState:(UIControlStateNormal)];
        [temBtn setTitleColor:app_MainColor forState:(UIControlStateNormal)];
        temBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
        temBtn.tag=i;
        [temBtn addTargetActionBlock:^(UIButton *btn) {
            
            [weakSelf Action_eventBtnSelect:btn];
        }];
        
    }
    
    
    //===========
    self.tableView=[[FMDBVCTableView alloc]initWithFrame:CGRectMake(0, 190*HXJkWScale, HXJkScreenWidth, HXJkScreenHeight-HXJkTopHeight-190*HXJkWScale) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    
    
    //数据回调
    self.tableView.cellSelectBlock = ^(NSIndexPath *indexPath) {
        
        [weakSelf Action_cellSelectWithIndexPath:indexPath];
    };
    
    
}


#pragma mark - 按钮事件
-(void)Action_eventBtnSelect:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:{
            //增加
            if (self.nameTF.text.length==0) {
                return;
            }
            
            [FMDBTool addName:self.nameTF.text Password:self.ageTF.text];
            
            self.dataArrM = [FMDBTool selectAll];
            self.tableView.dataArr=self.dataArrM;
        }
            break;
        case 1:{
            //查询
            if (self.nameTF.text.length==0) {
                self.dataArrM = [FMDBTool selectAll];
                
            }else{
                
                self.dataArrM=[FMDBTool selectName:self.nameTF.text];
            }
            
            self.tableView.dataArr=self.dataArrM;
        }
            break;
        case 2:{
            //删除
            if (self.nameTF.text.length==0) {
                return;
            }
            [FMDBTool removeName:self.nameTF.text Password:nil];
            
            self.dataArrM = [FMDBTool selectAll];
            self.tableView.dataArr=self.dataArrM;
        }
            break;
        case 3:{
            //全部删除
            [FMDBTool removeAll];
            
            self.dataArrM = [FMDBTool selectAll];
            self.tableView.dataArr=self.dataArrM;
        }
            break;
            
        default:
            break;
    }
    
}


-(void)Action_cellSelectWithIndexPath:(NSIndexPath *)indexPath{
    
    
}




@end
