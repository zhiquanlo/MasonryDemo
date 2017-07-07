//
//  view2.m
//  test
//
//  Created by 李志权 on 2017/6/14.
//  Copyright © 2017年 李志权. All rights reserved.
//

#import "view2.h"
#import "Masonry.h"
@implementation view2
- (instancetype)init
{
    if (self = [super init]) {
        
        self.arrayData = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = NO;
        self.tableView.rowHeight = 85;
        self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(0);//设置顶部
            
            make.left.equalTo(self.mas_left).with.offset(10);//设置左边
            
            make.right.equalTo(self.mas_right).with.offset(-10);//设置右边
            
            make.bottom.equalTo(self.mas_bottom).with.offset(0);//设置底部
        }];
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.arrayData.count-1 > section) {
        return 9.9;
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    TableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell setInfo:self.arrayData[indexPath.section]];
    return cell;
}

@end

#pragma mark CellModel

@implementation CellModel1
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self=[super init])
    {
        //忘了介绍了 字典转模型的常用语句
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    
}
@end

@implementation TableViewCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //背景图片
        self.backgroundImage = [UIImageView new];
        self.backgroundImage.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.backgroundImage];
        
        
        [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.contentView);//设置宽度和self.contentView一样大
            
            make.height.mas_equalTo(self.contentView);//设置高度和self.contentView一样大

        }];
        
        //优惠金额
        self.amount = [UILabel new];
        self.amount.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.amount];
        
        [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).with.offset(25);//设置左边间距25
            
            make.top.equalTo(self.contentView.mas_top).with.offset(12);//设置距离顶部12
            
            make.height.mas_equalTo(18);//设置高度18
        }];
        //有效时间
        self.date = [UILabel new];
        self.date.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.date];
        
        [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.amount);//设置左边和self.amount左边一样
            
            make.top.equalTo(self.amount.mas_bottom).with.offset(5);//设置顶部距离self.amount底部5
            
            make.height.mas_equalTo(16);//设置高度16
        }];
        //使用条件
        self.conditions = [UILabel new];
        self.conditions.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.conditions];
        
        [self.conditions mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.amount);//设置左边和self.amount左边一样
            
            make.top.equalTo(self.date.mas_bottom).with.offset(5);//设置顶部距离self.date底部5
            
            make.height.mas_equalTo(17);//高度设置17
        }];
        //使用状态
        self.state = [UIImageView new];
        [self.contentView addSubview:self.state];
        
        [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).with.offset(-20);//设置右边
            
            make.centerY.mas_equalTo(self.contentView);//设置左边
            
            make.height.mas_equalTo(55);//设置高度
            
            make.width.mas_equalTo(55);//设置宽度
            
        }];
    }
    return self;
}
- (void)setInfo:(CellModel1 *)info
{
    
    self.amount.text = [NSString stringWithFormat:@"%@元优惠卷  %@元",info.amount,info.amount];
    self.date.text = [NSString stringWithFormat:@"失效时间:%@",info.date];
    self.conditions.text = [NSString stringWithFormat:@"消费满%@元可用",info.conditions];
    
    if ([info.state isEqualToString:@"1"]) {
        self.backgroundImage.backgroundColor = [UIColor grayColor];
        self.state.backgroundColor = [UIColor redColor];
    }
    else
    {
        self.backgroundImage.backgroundColor = [UIColor redColor];
        self.state.backgroundColor = [UIColor grayColor];
    }
    
}
@end
