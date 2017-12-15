//
//  UPBevTask.h
//  UPBehavior
//
//  Created by Rainbow on 2017/12/15.
//  Copyright © 2017年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UPBevTaskStatusReady,
    UPBevTaskStatusRunning
} UPBevTaskStatus;

typedef enum {
    UPBevTaskResultSuccess,
    UPBevTaskResultFailure,
    UPBevTaskResultPending
} UPBevTaskResult;

@interface UPBevTask : NSObject

@end
