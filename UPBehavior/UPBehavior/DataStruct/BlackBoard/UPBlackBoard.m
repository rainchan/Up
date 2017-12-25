//
//  UPBlackBoard.m
//  UPBehavior
//
//  Created by Rainbow on 2017/12/14.
//  Copyright © 2017年 rain. All rights reserved.
//

#import "UPBlackBoard.h"

@implementation UPBlackBoard

+ (UPBlackBoard *)shareInstance
{
    static UPBlackBoard *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[UPBlackBoard alloc] init];
    });
    
    return sharedInstance;
}

@end
