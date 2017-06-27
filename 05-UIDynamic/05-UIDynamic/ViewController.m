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
/** 物理仿真器 */
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (UIDynamicAnimator *)animator
{
    if (!_animator) {//1.创建物理仿真器（ReferenceView：参照视图，即仿真范围）
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    //2.创建物理仿真行为 - 重力行为
    UIGravityBehavior * gravity = [[UIGravityBehavior alloc]init];
    [gravity addItem:self.blueView];
    gravity.gravityDirection = CGVectorMake(50, 50);
    gravity.magnitude = 50;//100point/s² 移动距离 = 1/2 *manitude*时间²
    
    //3.添加物理仿真行为到物理仿真器中，开始物理仿真
    [self.animator addBehavior:gravity];
}


@end
