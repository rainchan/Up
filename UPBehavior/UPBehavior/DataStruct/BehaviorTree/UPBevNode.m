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
        self.children = [NSMutableArray new];
    }
    
    return self;
}

+ (NSArray *)modelPropertyBlacklist {
    return @[@"parent"];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children" : [UPBevNode class]};

}
@end
