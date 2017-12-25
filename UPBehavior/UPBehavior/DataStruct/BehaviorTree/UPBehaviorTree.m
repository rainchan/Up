//
//  UPBehaviorTree.m
//  UPBehavior
//
//  Created by Rainbow on 2017/12/15.
//  Copyright © 2017年 rain. All rights reserved.
//

#import "UPBehaviorTree.h"
#import "YYModel.h"

@implementation UPBehaviorTree

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(instancetype)initWithJson:(NSString*)json;
{
    self = [super init];
    
    if (self) {
        _root = [self rootNodeWithJson:json];
    }
    
    return self;
}

-(UPBevNode*)rootNodeWithJson:(NSString *)json
{
    if (!json || json.length == 0) {
        return [UPBevNode new];
    }
    
    //to do
    UPBevNode *rootNode = [UPBevNode yy_modelWithJSON:json];
    return rootNode;
}

@end
