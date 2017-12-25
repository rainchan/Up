//
//  RWTreeNode.h
//  
//
//  Created by deput on 10/17/15.
//  Copyright © 2015 rw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTreeNodeProtocol.h"

#pragma mark - RWTreeNodeObject

@interface RWTreeNodeObject<RWTreeNodeValueType> : NSObject<RWTreeNodeProtocol>
{
    RWTreeNodeValueType _value;
}

@property (nonatomic) RWTreeNodeValueType value;
- (id) initWithValue:(RWTreeNodeValueType) value;
- (NSString* ) dump;
@end
