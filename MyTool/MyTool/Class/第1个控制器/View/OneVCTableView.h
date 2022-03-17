//
//  OneVCTableView.h
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import <UIKit/UIKit.h>


typedef void (^OneVCTableViewCellSelectBlock)(NSIndexPath *indexPath);


#pragma mark - TableView
@interface OneVCTableView : UITableView

@property(nonatomic,strong)NSArray *dataArr;

@property(nonatomic,copy)OneVCTableViewCellSelectBlock cellSelectBlock;

@end





#pragma mark - Cell
@interface OneVCTableViewCell : UITableViewCell

@property(nonatomic,copy)NSString *titleStr;

@end

