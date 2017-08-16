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

@interface TextureVC ()<ASTableDelegate,ASTableDataSource>{
    NSMutableArray *dataArr;
    NSURL *imageUrl;
}

@property (nonatomic,strong) ASTableNode *tableNode;
@property (nonatomic,strong) LayoutLearnNode *nodeOne;
@property (nonatomic,strong) UIImageView *tradImageView;
@property (nonatomic,strong) ImageNode *textureImageView;

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
    
}

-(void)initUI{
    
    self.view.backgroundColor = hexColor(0xffffff);
    [self.view addSubnode:self.nodeOne];
    [self.view addSubview:self.tradImageView];
    [self.view addSubnode:self.textureImageView];

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
//        _tableNode.delegate = self;
//        _tableNode.dataSource = self;
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
