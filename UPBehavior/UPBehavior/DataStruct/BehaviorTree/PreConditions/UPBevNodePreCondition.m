//
//  UPBevNodePreCondition.m
//  UPBehavior
//
//  Created by Rainbow on 2017/12/14.
//  Copyright © 2017年 rain. All rights reserved.
//

#import "UPBevNodePreCondition.h"
#import "UPBlackBoard.h"

@implementation UPBevNodePreCondition

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"inputValueDic" : [NSString class]};
}

-(BOOL)isTrue
{
    if (!self.inputValueDic) {
        return YES;
    }
    
    
    return NO;
}

@end
