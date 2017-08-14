//
//  TextureVC.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/12.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "TextureVC.h"
#import "LayoutLearnNode.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface TextureVC ()<ASTableDelegate,ASTableDataSource>{
    NSMutableArray *dataArr;
}

@property (nonatomic,strong) ASTableNode *tableNode;
@property (nonatomic,strong) LayoutLearnNode *nodeOne;

@end

@implementation TextureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.tableNode.delegate = nil;
    self.tableNode.dataSource = nil;
    
}

-(void)initData{
    
    for (NSInteger i = 0; i < 10; i++) {
        [dataArr addObject:[NSString stringWithFormat:@"Line_%ld",(long)i]];
    }
    
    NSUInteger count = 99;
    NSString *object = @"red balloons";
    NSLog(@"%@",object);
}

-(void)initUI{
    
    self.view.backgroundColor = hexColor(0xffffff);
//    [self.view addSubnode:self.tableNode];
    
    [self.view addSubnode:self.nodeOne];
    
}

-(LayoutLearnNode *)nodeOne{
    if (!_nodeOne) {
        _nodeOne = [[LayoutLearnNode alloc] init];
        _nodeOne.frame = CGRectMake(0, 0, ScreenWidth, 100);
        _nodeOne.layerBacked = YES;
        _nodeOne.backgroundColor = [hexColor(0x00c18b) colorWithAlphaComponent:0.2];
    }
    return _nodeOne;
}

-(ASTableNode *)tableNode{
    if (!_tableNode) {
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStyleGrouped];
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableNode;
}

#pragma mark -UITableNode(Delegate,Datasource)
-(NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    return 1;
}

-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

//-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ASCellNode *()
//}

@end
