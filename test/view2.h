//
//  view2.h
//  test
//
//  Created by 李志权 on 2017/6/14.
//  Copyright © 2017年 李志权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface view2 : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *arrayData;
@property (nonatomic,strong)UITableView *tableView;
@end
/**cell模型*/
@interface CellModel1 : NSObject
- (instancetype)initWithDic:(NSDictionary *)dic;
/**金额*/
@property (nonatomic,strong)NSString *amount;
/**有效时间*/
@property (nonatomic,strong)NSString *date;
/**消费条件*/
@property (nonatomic,strong)NSString *conditions;
/**使用状态1未使用*/
@property (nonatomic,strong)NSString *state;
@end

@interface TableViewCell1 : UITableViewCell
/**金额*/
@property (nonatomic,strong)UILabel *amount;
/**有效时间*/
@property (nonatomic,strong)UILabel *date;
/**消费条件*/
@property (nonatomic,strong)UILabel *conditions;
/**使用状态1未使用*/
@property (nonatomic,strong)UIImageView *state;
/**背景图片*/
@property (nonatomic,strong)UIImageView *backgroundImage;
- (void)setInfo:(CellModel1 *)info;
@end
