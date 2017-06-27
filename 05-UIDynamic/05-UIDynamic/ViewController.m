//
//  ViewController.m
//  05-UIDynamic
//
//  Created by wpzyc on 2017/6/27.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

/** 物理仿真器 */
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (UIDynamicAnimator *)animator
{
    if (!_animator) {//创建物理仿真器（ReferenceView：参照视图，即仿真范围）
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //旋转角度
    self.blueView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获得触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];

    //1.创建 吸附/捕捉行为
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.blueView snapToPoint:point];
    //防抖系数（值越小越抖）
    snap.damping = 0.2;
    //2.添加行为
    [self.animator removeAllBehaviors];//因为一个控件一次性只能吸附一个点
    [self.animator addBehavior:snap];
}

- (void)testCollision
{
    //1.创建 碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]init];
    //添加边界
    
    //    CGFloat startY = self.view.frame.size.height*0.5;
    //    CGFloat endX = self.view.frame.size.width;
    //    CGFloat endY = self.view.frame.size.height;
    //    [collision addBoundaryWithIdentifier:@"line" fromPoint:CGPointMake(0, startY) toPoint:CGPointMake(endX, endY)];
    //    [collision addBoundaryWithIdentifier:@"line2" fromPoint:CGPointMake(endX, 0) toPoint:CGPointMake(endX, endY)];
    
    CGFloat width = self.view.frame.size.width;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)];
    [collision addBoundaryWithIdentifier:@"circle" forPath:path];
    
    //让参照视图的bounds变为碰撞检测的边框
    //    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    [collision addItem:self.blueView];
    //    [collision addItem:self.segment];
    //2.创建 重力行为
    UIGravityBehavior * gravity = [[UIGravityBehavior alloc]init];
    //    gravity.gravityDirection = CGVectorMake(50, 50);
    gravity.magnitude = 100;
    [gravity addItem:self.blueView];
    //3.添加行为
    [self.animator addBehavior:collision];
    [self.animator addBehavior:gravity];
    
}
- (void)testGravity
{
    //1.创建物理仿真行为 - 重力行为
    UIGravityBehavior * gravity = [[UIGravityBehavior alloc]init];
    [gravity addItem:self.blueView];
    gravity.gravityDirection = CGVectorMake(50, 50);
    gravity.magnitude = 50;//100point/s² 移动距离 = 1/2 *manitude*时间²
    
    //2.添加物理仿真行为到物理仿真器中，开始物理仿真
    [self.animator addBehavior:gravity];
    
}

@end
