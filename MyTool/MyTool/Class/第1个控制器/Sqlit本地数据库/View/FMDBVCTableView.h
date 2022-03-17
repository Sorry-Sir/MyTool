//
//  FMDBVCTableView.h
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import <UIKit/UIKit.h>


typedef void (^FMDBVCTableViewCellSelectBlock)(NSIndexPath *indexPath);


#pragma mark - TableView
@interface FMDBVCTableView : UITableView

@property(nonatomic,strong)NSArray *dataArr;

@property(nonatomic,copy)FMDBVCTableViewCellSelectBlock cellSelectBlock;

@end




#pragma mark - Cell
@interface FMDBVCTableViewCell : UITableViewCell

@property(nonatomic,strong)NSDictionary *dataDic;

@end

