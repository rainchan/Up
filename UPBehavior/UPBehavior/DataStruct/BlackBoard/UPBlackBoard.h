//
//  UPBlackBoard.h
//  UPBehavior
//
//  Created by Rainbow on 2017/12/14.
//  Copyright © 2017年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPBlackBoard : NSObject

+ (UPBlackBoard *)shareInstance;

-(id)objectForKey:(NSString *)keyPath;

@end
