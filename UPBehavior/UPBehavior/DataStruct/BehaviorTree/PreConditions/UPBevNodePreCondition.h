//
//  UPBevNodePreCondition.h
//  UPBehavior
//
//  Created by Rainbow on 2017/12/14.
//  Copyright © 2017年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPBevNodePreCondition : NSObject
@property (nonatomic, strong) NSMutableDictionary *inputValueDic;

-(BOOL)isTrue;
@end
