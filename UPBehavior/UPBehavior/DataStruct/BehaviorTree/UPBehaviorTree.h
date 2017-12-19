//
//  UPBehaviorTree.h
//  UPBehavior
//
//  Created by Rainbow on 2017/12/15.
//  Copyright © 2017年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPBevNode.h"

@interface UPBehaviorTree : NSObject

/**
 root node
 */
@property (nonatomic,strong, readonly) UPBevNode *root;

/**
 init Behavior Tree

 @param node root node
 @return Behavior tree
 */
-(instancetype)initWithRootNode:(UPBevNode*) node;

@end
