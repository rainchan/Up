//
//  UPBehaviorTree.m
//  UPBehavior
//
//  Created by Rainbow on 2017/12/15.
//  Copyright © 2017年 rain. All rights reserved.
//

#import "UPBehaviorTree.h"

@implementation UPBehaviorTree

-(instancetype)initWithRootNode:(UPBevNode*) node
{
    self = [super init];
    
    if (self) {
        _root = node;
    }
    
    return self;
}

@end
