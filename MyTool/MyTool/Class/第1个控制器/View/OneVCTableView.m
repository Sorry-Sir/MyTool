//
//  OneVCTableView.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "OneVCTableView.h"


#define OneVCTableViewCellID @"OneVCTableViewCellID"
#define CellHeight (40*HXJkWScale)


@interface OneVCTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OneVCTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self=[super initWithFrame:frame style:style];
    
    if (self) {
        
        [self configureUI];
    }
    
    return self;
}

-(void)configureUI{
    
    self.backgroundColor=[UIColor clearColor];
    
    self.showsVerticalScrollIndicator=NO;
    self.showsHorizontalScrollIndicator=NO;
    
    self.dataSource=self;
    self.delegate=self;
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self registerClass:[OneVCTableViewCell class] forCellReuseIdentifier:OneVCTableViewCellID];
    
}

#pragma mark - 代理相关
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OneVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OneVCTableViewCellID forIndexPath:indexPath];
    
    cell.titleStr=self.dataArr[indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.cellSelectBlock) {
        
        self.cellSelectBlock(indexPath);
    }
}

#pragma mark - set
-(void)setDataArr:(NSArray *)dataArr{
    
    _dataArr=dataArr;
    
    [self reloadData];
}

@end






#pragma mark - Cell类
@interface OneVCTableViewCell ()

//标题
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation OneVCTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor=[UIColor whiteColor];
        
        [self UI_configureCellUI];
    }
    
    return self;
}

#pragma mark - CellUI创建
-(void)UI_configureCellUI{
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(30*HXJkWScale, 0, HXJkScreenWidth-60*HXJkWScale, CellHeight)];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.font=[UIFont systemFontOfSize:14];
    self.titleLabel.textColor=[UIColor blackColor];
    
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, CellHeight-1, HXJkScreenWidth, 1)];
    [self.contentView addSubview:lineView];
    lineView.backgroundColor=HXJRGB(230, 230, 230);
    
}


-(void)setTitleStr:(NSString *)titleStr{
    
    _titleStr=titleStr;
    
    self.titleLabel.text=[NSString stringWithFormat:@"%@",titleStr];
}


@end
