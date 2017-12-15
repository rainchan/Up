//
//  ViewController.m
//  UPBehavior
//
//  Created by Rainbow on 2017/12/14.
//  Copyright © 2017年 rain. All rights reserved.
//

#import "ViewController.h"
#import "UPBehavior.h"

#import "YYModel.h"
#import "UPMacros.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTree];
    
}

-(void)createTree
{
    UPBevNode *rootNode = [[UPBevNode alloc] init];
    rootNode.bevName = @"washingTree";
    rootNode.preCondition = [[UPBevNodePreCondition alloc] init];
    rootNode.task = [[UPBevTask alloc] init];
    
    UPBevNode *child_1 = [[UPBevNode alloc] init];
    child_1.bevName = @"OperUPStart";
    child_1.preCondition = [[UPBevNodePreCondition alloc] init];
    child_1.task = [[UPBevTask alloc] init];
    
    [rootNode addChild:child_1];
    
    UPBevNode *child_2 = [[UPBevNode alloc] init];
    child_2.bevName = @"OperUPContinue";
    child_2.preCondition = [[UPBevNodePreCondition alloc] init];
    child_2.task = [[UPBevTask alloc] init];
    
    [rootNode addChild:child_2];
    
    
    UPBehaviorTree *tree = [[UPBehaviorTree alloc]initWithRootNode:rootNode];
    NSString *result = [tree yy_modelToJSONString];
    DLog(@"------------行为树结果：--------------%@", result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
