//
//  ViewController.m
//  UPBehavior
//
//  Created by Rainbow on 2017/12/14.
//  Copyright © 2017年 rain. All rights reserved.
//

#import "ViewController.h"
#import "UPBehavior.h"
#import "UPBevDeviceTree.h"

#import "YYModel.h"
#import "UPMacros.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *inputTxt;
@property (nonatomic, strong) UITextView *resultView;
@property (nonatomic, strong) UPBevNode *resultNode;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 45)];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setTintColor:[UIColor blackColor]];
    [self.view addSubview:btn];
    [btn setTitle:@"创建行为树" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(createTree) forControlEvents:UIControlEventTouchUpInside];
    
    _inputTxt = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 100, 45)];
    _inputTxt.font = [UIFont systemFontOfSize:16];
    _inputTxt.borderStyle = UITextBorderStyleRoundedRect;
    _inputTxt.keyboardType = UIKeyboardTypeDefault;
    _inputTxt.secureTextEntry = NO;
//    _inputTxt.attributedPlaceholder = @"blackboard";
    [self.view addSubview:_inputTxt];
    
    
    _resultView = [[UITextView alloc] initWithFrame:CGRectMake(10, 200, self.view.bounds.size.width -40, 300)];
    _resultView.layer.cornerRadius = 6;
    _resultView.layer.masksToBounds = YES;
    _resultView.layer.borderWidth = 1.0;
    _resultView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:_resultView];
}

-(void)createTree
{
    NSString *logStr = @"beginging.......";
    self.resultView.text = logStr;
    NSString *inputTxt = self.inputTxt.text;
    
    UPBevNode *rootNode = [[UPBevNode alloc] init];
    rootNode.bevName = @"washingTree";
    rootNode.preCondition = [[UPBevNodePreCondition alloc] init];
    rootNode.task = [[UPBevTask alloc] init];
    
    NSDictionary *rootDic = [rootNode yy_modelToJSONObject];
    DLog(@"------------根节点字典：--------------%@",  rootDic);
    
    UPBevNode *child_1 = [[UPBevNode alloc] init];
    child_1.bevName = @"OperUPStart";
    child_1.preCondition = [[UPBevNodePreCondition alloc] init];
    child_1.task = [[UPBevTask alloc] init];
    [rootNode addChild:child_1];
    
    UPBevNode *child_1_1 = [[UPBevNode alloc] init];
    child_1_1.bevName = @"blackboard";
    child_1_1.preCondition = [[UPBevNodePreCondition alloc] init];
    child_1_1.preCondition.inputValueDic = [NSMutableDictionary new];
    child_1_1.task = [[UPBevTask alloc] init];
    [child_1 addChild:child_1_1];
    
    UPBevNode *child_2 = [[UPBevNode alloc] init];
    child_2.bevName = @"OperUPContinue";
    child_2.preCondition = [[UPBevNodePreCondition alloc] init];
    child_2.task = [[UPBevTask alloc] init];
    [rootNode addChild:child_2];
    
    UPBevNode *child_2_1 = [[UPBevNode alloc] init];
    child_2_1.bevName = @"usdkAction";
    child_2_1.preCondition = [[UPBevNodePreCondition alloc] init];
    child_2_1.preCondition.inputValueDic = [NSMutableDictionary new];
    child_2_1.task = [[UPBevTask alloc] init];
    [child_2 addChild:child_2_1];

    __weak typeof(self)weakSelf = self;
    [rootNode dfsWithBlock:^(id<RWTreeNodeProtocol> currentNode, NSIndexPath *indexPath, BOOL *stop) {
        
        UPBevNode * bevNode = currentNode;
        NSString *logStr = [weakSelf.resultView.text stringByAppendingString:[NSString stringWithFormat:@"\n------>DFS Current %@ IndexPath %@",bevNode.bevName, indexPath]];
        
        weakSelf.resultView.text = logStr;
        
        if ([bevNode.bevName isEqualToString:inputTxt]) {
            *stop = YES;
            weakSelf.resultNode = bevNode;
            logStr = [weakSelf.resultView.text stringByAppendingString:[NSString stringWithFormat:@"\n------->DFS Find result %@", bevNode.bevName]];
            
            weakSelf.resultView.text = logStr;
        }
        
    }];
    
    if (self.resultNode) {
        BOOL isCondition = [self checkPreCondition:self.resultNode condition:YES];
        logStr = [self.resultView.text stringByAppendingString:[NSString stringWithFormat:@" \npreCondition is %d",isCondition]];
        self.resultView.text = logStr;
    }
    
    [self createBlackBoard];
}

- (id)objectInArray:(id)array atIndexPath:(NSIndexPath *)path {
    
    // the end of recursion
    if (![array isKindOfClass:[NSArray self]] || !path.length) return array;
    
    NSUInteger nextIndex = [path indexAtPosition:0];
    
    // this will (purposely) raise an exception if the nextIndex is out of bounds
    id nextArray = [array objectAtIndex:nextIndex];
    
    NSUInteger indexes[27]; // maximum number of dimensions per string theory :)
    [path getIndexes:indexes];
    NSIndexPath *nextPath = [NSIndexPath indexPathWithIndexes:indexes+1 length:path.length-1];
    
    return [self objectInArray:nextArray atIndexPath:nextPath];
}

-(BOOL)checkPreCondition:(UPBevNode*)node condition:(BOOL)isTrue
{
    isTrue = isTrue && [node.preCondition isTrue];
    
    if (node.parent == nil) {
        return isTrue;
    }
    
    return [self checkPreCondition:node.parent condition:isTrue];
}

-(void)createBlackBoard
{
    NSString *dicJsontr = @"{\"functionData\":{\"unit01\":{\"programme\":{\"current\":\"current Programme\",\"list\":[]}}}}";

    NSDictionary *blackboard = [self dictionaryWithJsonString:dicJsontr];
    
//    NSMutableDictionary *blackboard = [NSMutableDictionary new];
//    NSMutableDictionary *functionData = [NSMutableDictionary new];
//    NSMutableDictionary *unit01 = [NSMutableDictionary new];
//    NSMutableDictionary *programme = [NSMutableDictionary new];
//    NSMutableArray *programmeList = [NSMutableArray new];
//
//    [blackboard setObject:functionData forKey:@"functionData"];
//    [functionData setObject:unit01 forKey:@"unit01"];
//    [unit01 setObject:programme forKey:@"programme"];
//    [programme setObject:programmeList forKey:@"list"];
//    [unit01 setValue:@"current Programme" forKeyPath:@"programme.current"];
//
//    NSString *jsonStr = [blackboard yy_modelToJSONString];
    
    NSString *current = [blackboard valueForKeyPath:@"functionData.unit01.programme.current"];
    NSLog(@"current is %@", current);
}

-(void)deviceTreeSearch
{
    UPBevDeviceTree *tree = [UPBevDeviceTree new];
    [tree searchNodeName:@"washing" taskValue:@"true"];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}
@end
