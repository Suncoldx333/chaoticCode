//
//  TextureVC.m
//  JSCallOC
//
//  AsyncDisplayKit 使用
//
//  Created by 11111 on 2017/8/12.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "TextureVC.h"
#import "LayoutLearnNode.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ImageNode.h"
#import "SizeNode.h"
#import "CellNodeModel.h"
#import "ListCellNodel.h"

#import "TextStyles.h"
//#import "TextStyles+WhichFirst.h"

@interface TextureVC ()<ASTableDelegate,ASTableDataSource>{
    NSMutableArray *dataArr;
    NSURL *imageUrl;
    NSMutableArray<CellNodeModel *> *tableNodeDataArr;
    CGFloat lastHeight;
}

@property (nonatomic,strong) ASTableNode *tableNode;
@property (nonatomic,strong) LayoutLearnNode *nodeOne;
@property (nonatomic,strong) UIImageView *tradImageView;
@property (nonatomic,strong) ImageNode *textureImageView;
@property (nonatomic,strong) SizeNode *sizenode;

@end

@implementation TextureVC{
    NSTimer *timer;
    NSInteger count;
}

#pragma mark - View lifecircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    [self timeBegin];
    [self configureBlock];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
//        
//    }];
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
    imageUrl = [NSURL URLWithString:@"http://gxapp-images.oss-cn-hangzhou.aliyuncs.com/news-images/20170510/5387f9a7c2af45eda6a70ceea78d8bac.jpg"];
    count = 0;
    for (NSInteger i = 0; i < 10; i++) {
        [dataArr addObject:[NSString stringWithFormat:@"Line_%ld",(long)i]];
    }
    
    tableNodeDataArr = [[NSMutableArray alloc] init];
    CellNodeModel *model = [[CellNodeModel alloc] init];
    model.author = @"余华";
    model.speechName = @"许三观卖血记";
    [tableNodeDataArr addObject:model];
    
    model = [[CellNodeModel alloc] init];
    model.author = @"老舍";
    model.year = @"1990";
    model.speechName = @"茶馆";
    [tableNodeDataArr addObject:model];
    
    model = [[CellNodeModel alloc] init];
    model.author = @"王小波";
    model.speechName = @"沉默的大多数";
    [tableNodeDataArr addObject:model];
    
    model = [[CellNodeModel alloc] init];
    model.author = @"围城";
    model.year = @"1009";
    model.speechName = @"钱钟书";
    [tableNodeDataArr addObject:model];
    
    TextStyles *style = [[TextStyles alloc] init];
    [style whichWillBeFirst];
    
}

-(void)initUI{
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
//    [self.view addGestureRecognizer:tap];
    
    self.view.backgroundColor = hexColor(0xffffff);
    
//    [self.view addSubnode:self.tableNode];
    
//    [self.view addSubnode:self.nodeOne];
//    [self.view addSubview:self.tradImageView];
//    [self.view addSubnode:self.textureImageView];
    [self.view addSubnode:self.sizenode];
    lastHeight = self.sizenode.frame.size.height;
}

-(void)tapEvent{
    [self.sizenode transitionLayoutWithAnimation:YES shouldMeasureAsync:NO measurementCompletion:nil];
}

-(void)timeBegin{
    timer = [NSTimer scheduledTimerWithTimeInterval:5
                                             target:self
                                           selector:@selector(change)
                                           userInfo:nil
                                            repeats:NO];
}

-(void)change{
    count++;
    NSString *ori = @"a~";
    NSMutableString *changed = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i < count; i++) {
        [changed appendString:ori];
    }
    [self.nodeOne changdText:changed];
}

#pragma mark - Lazy loading
-(ImageNode *)textureImageView{
    if (!_textureImageView) {
        _textureImageView = [[ImageNode alloc] init];
        _textureImageView.frame = CGRectMake(ScreenWidth / 2, 150, ScreenWidth / 2, ScreenWidth /2);

    }
    return _textureImageView;
}

-(UIImageView *)tradImageView{
    if (!_tradImageView) {
        _tradImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth / 2, ScreenWidth / 2)];
        [_tradImageView sd_setImageWithURL:imageUrl
                          placeholderImage:[UIImage imageNamed:@"topicGuide"]];
    }
    return _tradImageView;
}

-(SizeNode *)sizenode{
    if (!_sizenode) {
        _sizenode = [[SizeNode alloc] init];
        _sizenode.frame = CGRectMake(0, 150, ScreenWidth, ScreenWidth / 2);
        _sizenode.backgroundColor = [hexColor(0x00c18b) colorWithAlphaComponent:0.2];
    }
    return _sizenode;
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
        _tableNode.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    return _tableNode;
}

#pragma mark - Configure block
-(void)configureBlock{
    
    __weak typeof(self) weakSelf = self;
    
    self.sizenode.heightCalBlock = ^(CGFloat height) {
        [weakSelf changeBgView:height];
    };
    
}

#pragma mark - UI change
-(void)changeBgView:(CGFloat)height{
    
    if (lastHeight != height) {
        lastHeight = height;
        NSLog(@"height = %f",height);
        
        CGFloat oriX = self.sizenode.frame.origin.x;
        CGFloat oriY = self.sizenode.frame.origin.y;
        CGFloat oriWidth = self.sizenode.frame.size.width;
        
        self.sizenode.frame = CGRectMake(oriX, oriY, oriWidth, height);
        
    }
    
}

#pragma mark -ASTableNode(Delegate,Datasource)
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellNodeModel *model = [tableNodeDataArr objectAtIndex:indexPath.row];
    return ^{
        return [[ListCellNodel alloc] initWithModel:model];
    };
}

-(NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    return 1;
}

-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return tableNodeDataArr.count;
}

@end
