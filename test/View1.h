//
//  View1.h
//  test
//
//  Created by 李志权 on 2017/6/14.
//  Copyright © 2017年 李志权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View1 : UIView<UITableViewDelegate,UITableViewDataSource>
/**仙币*/
@property (nonatomic,strong)UILabel *currency;
/**服务类型*/
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arrayData;
@end

/**cell模型*/
@interface CellModel : NSObject
- (instancetype)initWithDic:(NSDictionary *)dic;
@property (nonatomic,strong)NSString *serviceType;
@property (nonatomic,strong)NSString *serviceContent;
@end
@interface TableViewCell : UITableViewCell
/**服务类型*/
@property (nonatomic,strong)UILabel *serviceType;
/**服务内容*/
@property (nonatomic,strong)UILabel *serviceContent;
- (void)setInfo:(CellModel *)info;
@end
