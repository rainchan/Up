//
//  UPMacros.h
//  UPBehavior
//
//  Created by Rainbow on 2017/12/15.
//  Copyright © 2017年 rain. All rights reserved.
//

#ifndef UPMacros_h
#define UPMacros_h
//日志
#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"\n[File:%s]\n" "[Function:%s]\n" "[Line:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#endif /* UPMacros_h */
