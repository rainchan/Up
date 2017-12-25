//
//  RWTreeNode.m
//  
//
//  Created by deput on 10/17/15.
//  Copyright © 2015 rw. All rights reserved.
//

#import "RWTreeNode.h"

@implementation NSIndexPath(RWTreeNodeProtocol)
- (NSUInteger) lastIndex
{
    if (self.length == 0) {
        return 0;
    }
    return [self indexAtPosition:self.length - 1];
}
@end

@implementation RWTreeNodeObject
{
    NSMutableArray*         _children;
    __weak id<RWTreeNodeProtocol>   _parent;
}

@synthesize children;
@synthesize parent = _parent;
@synthesize value = _value;

+ (id<RWTreeNodeProtocol>) treeNode
{
    return [[[self class] alloc] init];
}

- (id) initWithValue:(id) value
{
    self = [super init];
    _value = value;
    return self;
}

- (NSMutableArray< id<RWTreeNodeProtocol> >*) children
{
    if (_children == nil) {
        _children = @[].mutableCopy;
    }
    return _children;
}

- (id<RWTreeNodeProtocol>) root
{
    id<RWTreeNodeProtocol> current = self;
    while(current.parent) current = current.parent;
    return current;
}

- (BOOL) isLeaf
{
    return (self.children == nil || self.children.count == 0);
}

- (BOOL) isRoot
{
    return self.parent == nil;
}

#pragma mark - Tree node operation and access methods

- (void) addChild:(id<RWTreeNodeProtocol>)child
{
    [[self children] addObject:child];
    child.parent = self;
}

- (void) removeChild:(id<RWTreeNodeProtocol>)child
{
    [self.children removeObject:child];
    child.parent = nil;
}

- (id<RWTreeNodeProtocol>) childAtIndex:(NSUInteger) index
{
    if (index < self.children.count)
        return self.children[index];
    return nil;
}

- (void) insertChild:(id<RWTreeNodeProtocol>)child atIndex:(NSUInteger) index
{
    if (index < self.children.count)
        [self.children insertObject:child atIndex:index];
    else
        [self addChild:child];
}

-(void) removeChildAtIndex:(NSUInteger) index
{
    [self.children removeObjectAtIndex:index];
}

-(id<RWTreeNodeProtocol>) childAtIndexPath:(NSIndexPath*) indexPath
{
    id<RWTreeNodeProtocol> current = self;
    for(NSUInteger i = 0; i < indexPath.length; i++){
        NSAssert(![current isLeaf], @"Not leaf");
        current = current.children[[indexPath indexAtPosition:i]];
    }
    return current;
}

-(void) insertChild:(id<RWTreeNodeProtocol>)child atIndexPath:(NSIndexPath*) indexPath
{
    id<RWTreeNodeProtocol> current = self;
    for(NSUInteger i = 0; i < indexPath.length - 1; i++){
        NSAssert(![current isLeaf], @"Not leaf");
        current = current.children[[indexPath indexAtPosition:i]];
    }
    [current insertChild:child atIndex:[indexPath lastIndex]];
}

-(void) removeChildAtIndexPath:(NSIndexPath*) indexPath
{
    id<RWTreeNodeProtocol> current = self;
    for(NSUInteger i = 0; i < indexPath.length - 1; i++){
        NSAssert(![current isLeaf], @"Not leaf");
        current = current.children[[indexPath indexAtPosition:i]];
    }
    [current removeChildAtIndex:[indexPath lastIndex]];
}

#pragma mark - Index

- (NSUInteger) index
{
    return [self.parent.children indexOfObject:self];
}

- (NSIndexPath*) indexPath
{
    return [self _indexPathBasedOn:self.root];
}

- (NSIndexPath*) indexPathBasedOn:(id<RWTreeNodeProtocol>)node
{
    __block id<RWTreeNodeProtocol> foundNode = nil;
    [self.children enumerateObjectsUsingBlock:^(id<RWTreeNodeProtocol>  _Nonnull theNode, NSUInteger idx, BOOL * _Nonnull stop) {
        if (node == theNode){
            foundNode = theNode;
            *stop = YES;
        }
    }];
    if (foundNode){
        return [self _indexPathBasedOn:foundNode];
    }else{
        return nil;
    }
    return nil;
}

- (NSIndexPath*) _indexPathBasedOn:(id<RWTreeNodeProtocol>)node
{
    NSMutableArray<id<RWTreeNodeProtocol>>* treeNodes = [@[] mutableCopy];
    NSIndexPath* indexPath = [NSIndexPath new];
    [self backTraceToRootWithBlock:^(id<RWTreeNodeProtocol> currentNode, BOOL *stop) {
        if (node == currentNode){
            *stop = YES;
        }else{
            [treeNodes insertObject:currentNode atIndex:0];
        }
    }];

    for(NSInteger i = 0 ;i < treeNodes.count; i++){
        indexPath = [indexPath indexPathByAddingIndex:[treeNodes[i] index]];
    }
    return indexPath;
}

#pragma mark - Traverse utils

- (void) dfsWithBlock:(RWTreeNodeProtocolTraverseBlock) block
{
    [self _dfsWithBlock:block indexPath:[NSIndexPath new]];
}

- (void) bfsWithBlock:(RWTreeNodeProtocolTraverseBlock) block
{
    [[self flatten] enumerateObjectsUsingBlock:^(id<RWTreeNodeProtocol>  node, NSUInteger idx, BOOL *  stop) {
        if (block) {
            block(node,[node indexPath],stop);
        }
    }];
}

- (void) backTraceToRootWithBlock:(RWTreeNodeProtocolBackTraceBlock) block
{
    BOOL stop = NO;
    id<RWTreeNodeProtocol> current = self;
    //NSIndexPath* indexPath = [current indexPath];
    while(current && !stop) {
        if (block)
            block(current,&stop);
        //indexPath = [indexPath indexPathByRemovingLastIndex];
        current = current.parent;
    }
}

- (NSArray<id<RWTreeNodeProtocol>>*) flatten
{
    NSMutableArray* array = @[].mutableCopy;
    NSMutableArray* queue = @[].mutableCopy;
    [queue addObject:self];
    [array addObject:self];
    while (queue.count) {
        id<RWTreeNodeProtocol> node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        [array addObjectsFromArray:[node children]];
        [queue addObjectsFromArray:[node children]];
    }
    return array.copy;
}

- (NSArray<id<RWTreeNodeProtocol>>*) brothers
{
    NSMutableArray* brothers = [[[self parent] children] mutableCopy];
    [brothers removeObjectIdenticalTo:self];
    return brothers;
}



#pragma mark - Internal methods
- (BOOL) _dfsWithBlock:(RWTreeNodeProtocolTraverseBlock) block indexPath:(NSIndexPath*)indexPath
{
    __block BOOL retStop = NO;
    block(self, indexPath, &retStop);
    if (retStop) return YES;
    
    [self.children enumerateObjectsUsingBlock:^(id<RWTreeNodeProtocol>  _Nonnull node, NSUInteger idx, BOOL * _Nonnull stop) {
        *stop = [(RWTreeNodeObject*)node _dfsWithBlock:block indexPath:[indexPath indexPathByAddingIndex:idx]];
        if(*stop) retStop = YES;
    }];
    return retStop;
}

#pragma mark - Debug helpers

- (NSString* ) description
{
    return [NSString stringWithFormat:@"<%@:%p - value:%@>\n",NSStringFromClass(self.class),self,[_value description]];
}

- (NSString* ) dump
{
    NSMutableString* returnString = [NSMutableString string];
    [self dfsWithBlock:^(id<RWTreeNodeProtocol> currentNode, NSIndexPath *indexPath, BOOL *stop) {
        for (int i = 0; i < indexPath.length; i++) {
            [returnString appendString:@"    "];
        }
        [returnString appendString:[currentNode description]];
    }];
    return returnString;
}
@end
