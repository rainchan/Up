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

@interface UPBevNode : NSObject

@property (nonatomic, copy) NSString *bevName;

@property (nonatomic, strong) UPBevTask *task;
@property (nonatomic, strong) UPBevNode *parentNode;
@property (nonatomic, strong) NSMutableArray *childrenNode;
@property (nonatomic, strong) UPBevNodePreCondition *preCondition;

//-(instancetype)initWithParent:(UPBevNode *)node;

-(void)addChild:(UPBevNode*)node;
@end
