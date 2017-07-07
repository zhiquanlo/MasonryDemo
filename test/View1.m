//
//  View1.m
//  test
//
//  Created by 李志权 on 2017/6/14.
//  Copyright © 2017年 李志权. All rights reserved.
//

#import "View1.h"
#import "Masonry.h"
/**字体大小*/
#define Font [UIFont systemFontOfSize:16]
/**当前屏幕尺寸*/
#define screenFrame [UIScreen mainScreen].bounds
@implementation View1
- (instancetype)init
{
    if (self = [super init]) {
        //您拥有的标题
        UILabel *label = [UILabel new];
        label.text = @"您用有：";
        label.font = Font;
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).with.offset(10);//设置左边
            
            make.top.equalTo(self.mas_top).with.offset(0);//设置顶部
            
            make.height.mas_equalTo(40);//设置高度
        }];
        //仙币数量，外界直接赋值text数量就好了
        self.currency = [UILabel new];
        self.currency.font = Font;
        self.currency.textColor = [UIColor redColor];
        [self addSubview:self.currency];
        
        [self.currency mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(label.mas_right).with.offset(0);//设置左边
            
            make.centerY.equalTo(label.mas_centerY).with.offset(0);//设置中心Y就不用设置左边约束
            
            make.height.mas_equalTo(label);//设置高度和label一样
        }];
        /**仙币标题*/
        UILabel *label1 = [UILabel new];
        label1.text = @"仙币";
        label1.font = Font;
        [self addSubview:label1];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.currency.mas_right).with.offset(0);//设置左边靠self.currency仙币数量右边
            
            make.centerY.mas_equalTo(self.currency);//设置中心Y轴和self.currency中心Y轴一样
            
            make.height.mas_equalTo(self.currency);//设置高度和self.currency高度一样
        }];
        
        self.arrayData = [NSMutableArray array];
        self.tableView = [UITableView new];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = NO;
        self.tableView.layer.masksToBounds = YES;
        self.tableView.layer.cornerRadius = 5;
        self.tableView.layer.borderColor = [UIColor grayColor].CGColor;
        self.tableView.layer.borderWidth = 1;
        self.tableView.userInteractionEnabled = NO;
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.currency.mas_bottom).with.offset(0);//设置顶部靠self.currency底部
            
            make.left.equalTo(self.mas_left).with.offset(10);//设置左边
            
            make.right.equalTo(self.mas_right).with.offset(-10);//设置右边
        }];
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellModel *model = self.arrayData[indexPath.row];

    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    
    CGSize size=[model.serviceType sizeWithAttributes:attrs];

    CGFloat width = screenFrame.size.width-60-size.width;

    
    return [self getSpaceLabelHeight:model.serviceContent withFont:[UIFont systemFontOfSize:14] withWidth:width];
    
    
}


//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 10;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, screenFrame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [cell setInfo:self.arrayData[indexPath.row]];
    return cell;
}
@end

#pragma mark CellModel

@implementation CellModel
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

@implementation TableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.serviceType = [UILabel new];
        self.serviceType.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.serviceType];
        
        [self.serviceType mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).with.offset(20);//设置左边间距
            
            make.top.equalTo(self.contentView.mas_top).with.offset(0);//设置顶部间距
            
            make.height.mas_equalTo(15);//设置高度15
        }];
        
        self.serviceContent = [UILabel new];
        self.serviceContent.numberOfLines = 0 ;
        self.serviceContent.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.serviceContent];
        
        [self.serviceContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.serviceType.mas_right).with.offset(20);//设置左边
            
            make.top.equalTo(self.contentView.mas_top).with.offset(0);//设置顶部
            
            make.right.equalTo(self.contentView.mas_right).with.offset(-20);//设置右边
        }];
    }
    return self;
}
- (void)setInfo:(CellModel *)info
{
    
    self.serviceType.text = info.serviceType;
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize size=[info.serviceType sizeWithAttributes:attrs];
    [self.serviceType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width+1);
    }];
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:info.serviceContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [info.serviceContent length])];
    self.serviceContent.attributedText = attributedString;
}
@end
