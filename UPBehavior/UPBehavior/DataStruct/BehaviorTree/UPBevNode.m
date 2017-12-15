//
//  UPBevNode.m
//  UPBehavior
//
//  Created by Rainbow on 2017/12/14.
//  Copyright © 2017年 rain. All rights reserved.
//

#import "UPBevNode.h"

@implementation UPBevNode

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.childrenNode = [NSMutableArray new];
    }
    
    return self;
}

-(void)addChild:(UPBevNode*)node
{
    node.parentNode = self;
    [self.childrenNode addObject:node];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"childrenNode" : [UPBevNode class]};

}
@end
