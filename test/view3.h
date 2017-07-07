//
//  view3.h
//  test
//
//  Created by 李志权 on 2017/6/15.
//  Copyright © 2017年 李志权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface view3 : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arrayData;
@end

@interface cellModel2 : NSObject
/**图片名称*/
@property (nonatomic,strong)NSString *logo;
/**标题*/
@property (nonatomic,strong)NSString *titleStr;
/**内容*/
@property (nonatomic,strong)NSString *content;
/**是否选中1是选中0为不选中*/
@property (nonatomic,strong)NSNumber *isSelected;
@end

@interface TableViewCell2 : UITableViewCell
/**图片名称*/
@property (nonatomic,strong)UIImageView *logo;
/**标题*/
@property (nonatomic,strong)UILabel *titleLabel;
/**内容*/
@property (nonatomic,strong)UILabel *content;
/**勾选图片*/
@property (nonatomic,strong)UIImageView *tagImage;
- (void)setInfo:(cellModel2 *)info;
@end
