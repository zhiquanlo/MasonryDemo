//
//  BeisaieRcurve.m
//  test
//
//  Created by 李志权 on 2017/7/3.
//  Copyright © 2017年 李志权. All rights reserved.
//

#import "BeisaieRcurve.h"

@interface BeisaieRcurve ()
{
    UIDynamicAnimator *_animator;
    UIPushBehavior *_userDragBehavior;
}
@end

@implementation BeisaieRcurve

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    在介绍iOS7中苹果已经说得很清楚了，他们致力于设备和现实生活的交互行为。一个被介绍的新的API是UIKit Dynamics -- 一个在UIkit框架下的二维物理现象发动机。
//    
//    为了模拟现实生活中的物理现象我们使用UIDynamicBehavior子类，这些子类适用接受UIDynamicItem协议对象的不同行为。很多行为的了例子包括：gravity（重力）, collisions（碰撞） and springs（弹簧）。虽然你可以自己子类化接受UIDynamicItem协议的对象，但是很显然UIView已经自己做了。UIDynamicBehavior 对象们可以复合在一起形成一个特定的行为对象，这个行为对象有着这些对象的各种行为。
//    
//    一旦我们指定给我们的dynamic 对象一些特定的行为，我们可以为它创造一个UIDynamicAnimator实例--物理引擎。这玩意计算决定着不同的对象应该如何展现他们的行为。下面的这图宏观的概述了UIKit Dynamics原理世界：
    

    
    
    self.title = @"UIKit Dynamic";
    
//    建立一个钟摆实验
    
//    让我们回顾一下高中的学科---在牛顿物理学中，一个最简单的项目就是钟摆实验了。现在就让我们利用视图来呈现球的摇摆吧。
    
    UIView *ballBearing = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    ballBearing.backgroundColor = [UIColor lightGrayColor];
    ballBearing.layer.cornerRadius = 10;
    ballBearing.layer.borderColor = [UIColor grayColor].CGColor;
    ballBearing.layer.borderWidth=2;
    ballBearing.center = CGPointMake(200, 300);
    [self.view addSubview:ballBearing];
//    现在我们能给找这球加上些有趣的行为了.我们能够创造一个对象来复合多种行为：
    UIDynamicBehavior *behavior = [[UIDynamicBehavior alloc]init];
//    接下来我们将添加一系列我们想要模拟的行为 --首先就是地球引力了:
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[ballBearing]];
    gravity.magnitude = 10;
    [behavior addChildBehavior:gravity];
//    UIGravityBehavior 呈现出一个物体和地球之间的万有引力。这个类有很多属性让你能够描述万有引力手里的矢量（包括大小和方向）。现在我们加大这个力的大小并保持在y的方向增长。另一个行为我们需要加小球上的是一个附属行为 -- 用一根线把它给挂住:
    CGPoint anchor = ballBearing.center;
    anchor.y -= 200;
    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]initWithItem:ballBearing attachedToAnchor:anchor];
    [behavior addChildBehavior:attachment];
    
//    UIAttachmentBehavior实例对象依附一个锚点或者另外一个物体。他有属性可以控制附加线的行为--（可以指定）频率,阻尼,线长。默认值保证了一个完整且严格的附加行为，这正是我们钟摆实验所希望的。
//    
//    现在小球所有的行为都被指定了我们可以创造一个物理引擎UIDynamicAnimator的对象_animator:
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [_animator addBehavior:behavior];
//    UIDynamicAnimator提供了模拟这个实验的物理引擎。这里我们创造它并指定相关联的视图(比如空间宇宙)然后添加我们刚刚创造的复合型行为。
//    
//    刚刚做的这些我们就建立了我们第一个UIKit Dynamics系统。然而，你现在去跑这个工程，啥都不会发生。这是因为这个系统开始在一个平衡的状态下--我们应该去打扰这个平衡状态,让它动起来。
//    
//    手势驱动行为
//    
//    我们需要为小球添加一个手势这样用户就可以做这个实验了。
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hanbleBallBearingPan:)];
    [ballBearing addGestureRecognizer:gesture];
    
    
    // Do any additional setup after loading the view.
}
- (void)hanbleBallBearingPan:(UIPanGestureRecognizer *)gesture
{
//    在这个手势响应方法里面我们施加一个恒力行为在小球上
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (_userDragBehavior) {
            [_animator removeBehavior:_userDragBehavior];
        }
        _userDragBehavior = [[UIPushBehavior alloc]initWithItems:@[gesture.view] mode:UIPushBehaviorModeContinuous];
        [_animator addBehavior:_userDragBehavior];
    }
    
    _userDragBehavior.pushDirection = CGVectorMake([gesture translationInView:self.view].x/10.f, 0);
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [_animator removeBehavior:_userDragBehavior];
        _userDragBehavior = nil;
    }
//    UIPushBehavior 对物体施加一个线性的力。当我们手势响应开始，我们创造UIPushBehavior的对象_userDragBehavior，记住把它加在_animator上。为了水平方向速度的转移，我们需要设置合适力的大小。为了使这个摆钟摇摆，在手势结束的时候我们移除_userDragBehavior对象。
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
@implementation myView

- (void)drawRect:(CGRect)rect
{
    [self rectangular];
    
    UIColor *color = [UIColor greenColor];
    [color set];
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 2.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    [aPath moveToPoint:CGPointMake(0, 0)];
        [aPath addQuadCurveToPoint:CGPointMake(200, 120) controlPoint:CGPointMake(100, 200)];
//    [aPath addCurveToPoint:CGPointMake(200, 80) controlPoint1:CGPointMake(60, 150) controlPoint2:CGPointMake(120, 30)];
    [aPath stroke];
    
}
- (void)rectangular
{
    // 设置颜色
    UIColor *color = [UIColor redColor];
    [color set];
    // 初始化
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    // 设置线宽
    aPath.lineWidth = 2.0;
    // 线条处理
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineJoinRound; //终点处理
    // 起始点
    [aPath moveToPoint:CGPointMake(0.0, 0.0)];
    // 画线
    [aPath addLineToPoint:CGPointMake(200.0, 0.0)]; // 第一点
    [aPath addLineToPoint:CGPointMake(200.0, 200.0)]; // 第二点
    [aPath addLineToPoint:CGPointMake(0.0, 200.0)]; // 第三点
    //通过调用closePath方法得到的
    [aPath closePath];
    // 根据坐标点连线
    [aPath stroke];
    
}
@end
