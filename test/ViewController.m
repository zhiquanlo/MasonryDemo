//
//  ViewController.m
//  test
//
//  Created by 李志权 on 2017/6/13.
//  Copyright © 2017年 李志权. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "View1.h"
#import "view2.h"
#import "view3.h"

@interface ViewController ()
@property (nonatomic,strong)UIScrollView *scrollView;
/**scrollView里面的滚动子视图*/
@property (nonnull,strong)UIView *rollingView;
/**显示更多按钮*/
@property (nonatomic,strong)UIButton *showMoreBtn;
/**优惠卷view*/
@property (nonatomic,strong)view2 *view_2;
/**总计金额*/
@property (nonatomic,strong)UILabel *sumLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view addSubview:self.scrollView];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(0);//设置顶部间距self.view顶部间距0
        
        make.left.equalTo(self.view.mas_left).with.offset(0);//设置左边间距self.view左边间距0
        
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);//设置在self.view底部间距50
        
        make.right.equalTo(self.view.mas_right).with.offset(0);//设置右边self.view右边边间距0
        
    }];
    
    self.rollingView = [UIView  new];
    self.rollingView .backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:self.rollingView];
    
    [self.rollingView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.scrollView).with.offset(0);//设置顶部间距、设置左边间距、设置底部约束、设置右边间距
        make.width.equalTo(self.scrollView);//设置宽度
    }];
    //第一条灰线
   UIView *line = [self setLine];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rollingView.mas_top).with.offset(20);//设置顶部间距
    }];
    
    //第一个view
    View1 *view1 = [View1 new];
    //这里直接赋值仙币数量
    view1.currency.text = @"100";
    
    [self.rollingView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rollingView.mas_left).with.offset(0);//设置左边间距
        make.top.equalTo(line.mas_bottom).with.offset(0);//设置顶部在第一条灰线line的底部间距0
        make.right.equalTo(self.rollingView.mas_right).with.offset(0);//设置右边间距
        
    }];
    //这是服务内容的数据
    NSArray *array = @[@{@"serviceType":@"服务类型",@"serviceContent":@"啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵啊呵"},@{@"serviceType":@"服务类型",@"serviceContent":@"服务内容"},@{@"serviceType":@"服务类型",@"serviceContent":@"服务内容服务内容服务内容服务内容服务内容服务内容服务内容服务内容服务内容服务内容服务内容"}];
    
    for (NSDictionary *dic in array) {
        //使用model接受
        CellModel *model = [[CellModel alloc]initWithDic:dic];
        [view1.arrayData addObject:model];
    }
    [view1.tableView reloadData];
    
    //刷新了数据计算view1的高度
    [view1.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(view1.tableView.contentSize.height);//设置高度
    }];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40+view1.tableView.contentSize.height);
    }];
    
    //第二条灰线
    UIView *line2 = [self setLine];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).with.offset(30);//设置顶部离view1底部30
    }];
    
    //优惠标题
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"使用优惠券";
    [self.rollingView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rollingView.mas_left).with.offset(10);//设置左边间距靠self.rollingView左边10
        make.top.equalTo(line2.mas_bottom).with.offset(0);//设置顶部离line2底部0
        make.height.mas_equalTo(40);//高度设置为40
    }];
    
    //优惠卷列表
    self.view_2 = [view2 new];
    [self.rollingView addSubview:self.view_2];
    [self.view_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(label.mas_bottom).with.offset(0);//设置顶部离label优惠券的底部0
        
        make.left.equalTo(self.rollingView.mas_left).with.offset(0);//设置左边间距
        
        make.right.equalTo(self.rollingView.mas_right).with.offset(0);//设置右边间距
        
    }];
    
    /**优惠券的数据*/
    
    NSArray *array1 = @[@{@"amount":@"10",@"date":[NSString stringWithFormat:@"%@",[NSDate date]],@"conditions":@"100",@"state":@"1"},@{@"amount":@"10",@"date":[NSString stringWithFormat:@"%@",[NSDate date]],@"conditions":@"100",@"state":@"0"},@{@"amount":@"10",@"date":[NSString stringWithFormat:@"%@",[NSDate date]],@"conditions":@"100",@"state":@"1"},@{@"amount":@"10",@"date":[NSString stringWithFormat:@"%@",[NSDate date]],@"conditions":@"100",@"state":@"1"}];
    
    
    
    for (NSDictionary *dic in array1) {
        /**使用model接受*/
        CellModel1 *model = [[CellModel1 alloc]initWithDic:dic];
        [self.view_2.arrayData addObject:model];
    }
    //初始化显示更多按钮
    self.showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.showMoreBtn setTitle:@"显示更多v" forState:UIControlStateNormal];
    [self.showMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.showMoreBtn setTitle:@"隐藏部分^" forState:UIControlStateSelected];
    self.showMoreBtn.backgroundColor = [UIColor greenColor];
    [self.showMoreBtn addTarget:self action:@selector(showMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rollingView addSubview:self.showMoreBtn];
    
    [self.showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view_2.mas_bottom).with.offset(0);//设置顶部距离self.view_2优惠券列表底部0
        
        make.left.equalTo(self.rollingView.mas_left).with.offset(10);//设置左边间距
        
        make.right.equalTo(self.rollingView.mas_right).with.offset(-10);//设置右边间距
    }];

    
    [self.view_2  mas_makeConstraints:^(MASConstraintMaker *make) {
        //优惠券列表数据超2个给显示更多按钮高度设置为30
        if (array1.count>2) {
            
            make.height.mas_equalTo(2*95-10);//给优惠券列表设置高度
            
            [self.showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(30);//给显示更多按钮高度设置为30
            }];
            
            }
        else
        {
            make.height.mas_equalTo(array1.count*95-10);//给优惠券列表设置高度
        }
    }];
    [self.view_2.tableView reloadData];
    
    //咨询费用父视图
    UIView *aView = [UIView new];
    aView.backgroundColor = [UIColor grayColor];
    aView.layer.cornerRadius = 5;
    aView.layer.masksToBounds  = YES;
    [self.rollingView addSubview:aView];
    
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.rollingView.mas_left).with.offset(10);//设置左边间距
        
        make.top.equalTo(self.showMoreBtn.mas_bottom).with.offset(20);//设置顶部距离self.showMoreBtn底部20
        
        make.right.equalTo(self.rollingView.mas_right).with.offset(-10);//右边间距
        
        make.height.mas_equalTo(40);//高度设置为40
    }];
    
    //咨询费用标题
    
    UILabel *label1 = [UILabel new];
    label1.text = @"咨询费用";
    label.font = [UIFont systemFontOfSize:15];
    [aView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(aView.mas_left).with.offset(10);//设置左边
        
        make.top.equalTo(aView.mas_top).with.offset(0);//设置顶部
        
        make.centerY.mas_equalTo(aView);//设置中心Y轴跟aView咨询费用父视图的中心Y轴一样
    }];
    
    //金额
    UILabel *amount = [UILabel new];
    //这里直接设置金额
    amount.text = @"￥128";
    
    amount.font = [UIFont systemFontOfSize:15];
    amount.textColor = [UIColor redColor];
    [aView addSubview:amount];
    [amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(aView.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(aView);
    }];
    
    //选择支付方式标题
    UILabel *label2 = [UILabel new];
    label2.font = [UIFont systemFontOfSize:16];
    label2.text = @"支付方式";
    label2.textColor = [UIColor blueColor];
    [self.rollingView addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.rollingView.mas_left).with.offset(10);//设置左边
        
        make.top.equalTo(aView.mas_bottom).with.offset(0);//设置顶部在aView咨询费用父视图的底部距离0
        
        make.height.mas_equalTo(40);//设置高度为40
    }];
    //选择支付方
    view3 *view_3 = [view3 new];
    [self.rollingView addSubview:view_3];
    [view_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.rollingView.mas_left).with.offset(10);//设置左边
        
        make.right.equalTo(self.rollingView.mas_right).with.offset(-10);//设置右边
        
        make.top.equalTo(label2.mas_bottom).with.offset(0);//设置顶部距离label2选择支付方式标题底部0
        
        make.height.mas_equalTo(view_3.arrayData.count*50);//设置高度
    }];
    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）
    [self.rollingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view_3.mas_bottom);//滚动范围
    }];
    
   /**总计费用*/
    self.sumLabel = [UILabel new];
    self.sumLabel.font = [UIFont systemFontOfSize:16];
    self.sumLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.sumLabel];
    
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.equalTo(self.view).with.offset(0);//设置左边
        
        make.top.equalTo(self.scrollView.mas_bottom).with.offset(0);//设置顶部距离self.scrollView底部0
        
        make.width.equalTo(self.view).multipliedBy(0.6);//设置宽度为self.view的宽度%60
    }];
    
    NSString *str  =  @"总计：" ;
    /**这里设置金额*/
    NSString *sumStr = @"100";
    NSMutableParagraphStyle *sumParaStyle = [[NSMutableParagraphStyle alloc] init];
    
    CGFloat sumEmptylen = self.sumLabel.font.pointSize/2;//这里设置开头空格
    
    sumParaStyle.firstLineHeadIndent = sumEmptylen;//首行缩进
    
    NSMutableAttributedString *sumAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str,sumStr] attributes:@{NSParagraphStyleAttributeName:sumParaStyle}];
    //这里设置颜色
    [sumAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str.length, sumStr.length)];
    
    self.sumLabel.attributedText = sumAttr;
    
    /**去支付按钮*/
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchUpInside];
    payBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:payBtn];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.sumLabel);//设置顶部和self.sumLabel顶部一样
        
        make.left.equalTo(self.sumLabel.mas_right).with.offset(0);//设置左边靠self.sumLabel右边距离0
        
        make.right.equalTo(self.view.mas_right).with.offset(0);//设置右边
        
        make.bottom.equalTo(self.sumLabel);//设置顶部和self.sumLabel底部一样
    }];
    
    
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return _scrollView;
}
/**设置线条*/
-(UIView *)setLine
{
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor grayColor];
    [self.rollingView  addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rollingView.mas_left).with.offset(0);//设置左边间距
        make.right.equalTo(self.rollingView.mas_right).with.offset(0);//设置右边间距
        make.height.mas_equalTo(1);//设置高度
    }];
    return line;
}
/**显示更多*/
-(void)showMoreBtnClick
{
    self.showMoreBtn.selected = self.showMoreBtn.selected ? NO:YES;
    self.view_2.autoresizingMask = UIViewAutoresizingNone;
    if (self.showMoreBtn.selected) {
        /**更新约束*/
        [self.view_2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.view_2.arrayData.count*95-10);//更新优惠券列表高度
        }];
        
    
    }
    else
    {
        /**更新约束*/
        [self.view_2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2*95-10);//更新优惠券列表高度
        }];
    }
    
}
/**去支付点击*/
- (void)payBtnClick
{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
