//
//  OneVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "OneVC.h"


#import "OneVCTableView.h"
#import "FMDBVC.h"
#import "CommodityCategoryViewVC.h"
#import "ScaleCycleViewVC.h"
#import "DatePickerViewVC.h"
#import "UploadMaterialVC.h"
#import "LuckyWheelVC.h"
#import "CalendarViewVC.h"




@interface OneVC ()

@property(nonatomic,strong)OneVCTableView *tableView;
@property(nonatomic,strong)NSArray *titleArr;

@end

@implementation OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"首页";
    
    [self UI_configureVCUI];
}

#pragma mark - UI创建
-(void)UI_configureVCUI{
    
    __HXJWeakSelf;
    
    //===========
    self.tableView=[[OneVCTableView alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, HXJkScreenHeight-HXJkTopHeight-HXJkBottomHeight) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    
    self.titleArr=@[
        @"Sqlit使用",
        @"商品类目横排滑动",
        @"缩放滚动轮播图",
        @"时间组件自定义选择",
        @"手机相册图片选择",
        @"幸运大转盘",
        @"日历日期选择"
    ];
    self.tableView.dataArr=self.titleArr;
    
    //数据回调
    self.tableView.cellSelectBlock = ^(NSIndexPath *indexPath) {
        
        [weakSelf Action_cellSelectWithIndexPath:indexPath];
    };
    
    
}


#pragma mark - 按钮事件
-(void)Action_cellSelectWithIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            FMDBVC *vc=[FMDBVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            CommodityCategoryViewVC *vc=[CommodityCategoryViewVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            ScaleCycleViewVC *vc=[ScaleCycleViewVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            DatePickerViewVC *vc=[DatePickerViewVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{
            UploadMaterialVC *vc=[UploadMaterialVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{
            LuckyWheelVC *vc=[LuckyWheelVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:{
            CalendarViewVC *vc=[CalendarViewVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}



@end
