//
//  view3.m
//  test
//
//  Created by 李志权 on 2017/6/15.
//  Copyright © 2017年 李志权. All rights reserved.
//

#import "view3.h"
#import "Masonry.h"
@implementation view3

- (instancetype)init
{
    if (self = [super init]) {
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1;
        
        /**支付方式的数据*/
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@{@"logo":@"",@"titleStr":@"支付宝",@"content":@"快捷支付,推荐支付宝注册用户使用",@"isSelected":@1}];
        [array addObject:@{@"logo":@"",@"titleStr":@"微信支付",@"content":@"快捷支付,推荐微信注册用户使用",@"isSelected":@0}];
        [array addObject:@{@"logo":@"",@"titleStr":@"仙币支付",@"content":@"推荐使用,仙币充值送豪礼",@"isSelected":@0}];
        
        self.arrayData = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            //转换成model模型
            cellModel2 *model = [[cellModel2 alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.arrayData addObject:model];
        }
        
        self.tableView = [UITableView new];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 50;
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(0);//设置顶部
            
            make.left.equalTo(self.mas_left).with.offset(0);//设置左边
            
            make.right.equalTo(self.mas_right).with.offset(0);//设置右边
            
            make.bottom.equalTo(self.mas_bottom).with.offset(0);//设置底部
        }];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    TableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setInfo:self.arrayData[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (cellModel2 *model in self.arrayData) {
        if (model==self.arrayData[indexPath.row]) {
            model.isSelected = @1;
        }
        else
        {
            model.isSelected = @0;
        }
    }
    [tableView reloadData];
}
@end

#pragma mark CellModel

@implementation cellModel2
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    
}
@end

@implementation TableViewCell2
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //logo图片
        self.logo = [UIImageView new];
        self.logo.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.logo];
        
        [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).with.offset(10);//设置左边
            
            make.centerY.mas_equalTo(self.contentView);//设置中心Y
            
            make.width.mas_equalTo(30);//设置宽度
            
            make.height.mas_equalTo(30);//设置高度
        }];
        //标题
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.logo.mas_right).with.offset(10);//设置左边
            
            make.top.equalTo(self.contentView.mas_top).with.offset(8);//设置顶部
            //因为label会根据内容计算，所有不需要设置宽高
        }];
        
        //内容
        self.content = [UILabel new];
        self.content.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.content];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.logo.mas_right).with.offset(10);//设置左边
            
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-8);//设置底部
        }];
        //设置选中图片
        self.tagImage = [UIImageView new];
        self.tagImage.backgroundColor = [UIColor purpleColor];
        self.tagImage.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:self.tagImage];
        
        [self.tagImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);//设置右边
            
            make.centerY.mas_equalTo(self.contentView);//设置中心Y
            
            make.width.mas_equalTo(25);//设置宽度
            
            make.height.mas_equalTo(25);//设置高度
        }];
    }
    return self;
}
- (void)setInfo:(cellModel2 *)info
{
    self.logo.image = [UIImage imageNamed:info.logo];
    self.titleLabel.text = info.titleStr;
    self.content.text = info.content;
    
    if (info.isSelected.intValue==1) {
        self.tagImage.hidden = NO;
    }
    else
    {
        self.tagImage.hidden = YES;
    }
}

@end
