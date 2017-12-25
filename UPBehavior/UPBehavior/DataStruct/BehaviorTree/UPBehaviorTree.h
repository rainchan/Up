//
//  UPBehaviorTree.h
//  UPBehavior
//
//  Created by Rainbow on 2017/12/15.
//  Copyright © 2017年 rain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPBevNode.h"

@protocol UPBehaviorTreeProtocol<NSObject>

@required

/**
 搜索树节点，并传入树形节点执行任务所需要的值对象 value

 @param name  节点名称
 @param value 任务入参值
 @return 行为树节点
 */
-(UPBevNode*)searchNodeName:(NSString *)name taskValue:(id)value;

@end

@interface UPBehaviorTree : NSObject

/**
 root node
 */
@property (nonatomic,strong, readonly) UPBevNode *root;


/**
 根据 json 文件生成行为树

 @param json  json 字符串
 @return 行为树
 */
-(instancetype)initWithJson:(NSString*)json;


@end
