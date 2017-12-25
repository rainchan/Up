//
//  RWTreeNodeProtocolProtocol.h
//  UPBehavior
//
//  Created by Rainbow on 2017/12/25.
//  Copyright © 2017年 rain. All rights reserved.
//

@protocol RWTreeNodeProtocol;

typedef void (^RWTreeNodeProtocolTraverseBlock)(id<RWTreeNodeProtocol> currentNode, NSIndexPath* indexPath, BOOL* stop);

typedef void (^RWTreeNodeProtocolBackTraceBlock)(id<RWTreeNodeProtocol> currentNode, BOOL* stop);

@protocol RWTreeNodeProtocol<NSObject>

@required

@property (weak,nonatomic) id<RWTreeNodeProtocol> parent;
@property (nonatomic) NSMutableArray< id<RWTreeNodeProtocol> >* children;

- (id<RWTreeNodeProtocol>) root;

- (BOOL) isLeaf;
- (BOOL) isRoot;

+ (id<RWTreeNodeProtocol>) treeNode;

#pragma mark - Tree node operation and access methods

- (void) addChild:(id<RWTreeNodeProtocol>)child;
- (void) removeChild:(id<RWTreeNodeProtocol>)child;

- (id<RWTreeNodeProtocol>) childAtIndex:(NSUInteger) index;
- (void) removeChildAtIndex:(NSUInteger) index;
- (void) insertChild:(id<RWTreeNodeProtocol>)child atIndex:(NSUInteger) index;

- (id<RWTreeNodeProtocol>) childAtIndexPath:(NSIndexPath*) indexPath;
- (void) removeChildAtIndexPath:(NSIndexPath*) indexPath;
- (void) insertChild:(id<RWTreeNodeProtocol>)child atIndexPath:(NSIndexPath*) indexPath;

- (NSArray<id<RWTreeNodeProtocol>>*) flatten;
- (NSArray<id<RWTreeNodeProtocol>>*) brothers;

#pragma mark - Index

- (NSUInteger) index;
- (NSIndexPath*) indexPath;
- (NSIndexPath*) indexPathBasedOn:(id<RWTreeNodeProtocol>)node;

#pragma mark - Traverse utils

- (void) dfsWithBlock:(RWTreeNodeProtocolTraverseBlock) block;
- (void) bfsWithBlock:(RWTreeNodeProtocolTraverseBlock) block;
- (void) backTraceToRootWithBlock:(RWTreeNodeProtocolBackTraceBlock) block;

@end

