//
//  UPBevNode.h
//  UPBehavior
//
//  Created by Rainbow on 2017/12/14.
//  Copyright © 2017年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPBevNodePreCondition.h"
#import "UPBevTask.h"
#import "RWTreeNode.h"

@interface UPBevNode : RWTreeNodeObject

@property (nonatomic, copy) NSString *bevName;

@property (nonatomic, strong) UPBevTask *task;
@property (nonatomic, strong) UPBevNodePreCondition *preCondition;

@end
