//
//  DeployableTableViewController.m
//  JSCallOC
//
//  Created by 11111 on 2017/7/20.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "DeployableTableViewController.h"

#define hexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
///屏幕宽度
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
///屏幕高度
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

@interface DeployableTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *depTableView;
@property (nonatomic,strong) UIView *sectionBtView;

@property (nonatomic) NSInteger count;

@end

@implementation DeployableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    self.view.backgroundColor = hexColor(0xffffff);
    self.count = 0;
    
    [self.view addSubview:self.depTableView];
}

-(UITableView *)depTableView{
    if (!_depTableView) {
        _depTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 500) style:UITableViewStyleGrouped];
        _depTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _depTableView.delegate = self;
        _depTableView.dataSource = self;
        _depTableView.backgroundColor = hexColor(0xb2b2b2);
        [_depTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    }
    return _depTableView;
}

-(UIView *)sectionBtView{
    if (!_sectionBtView) {
        _sectionBtView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - 50)/2, ScreenHeight - 50, 50, 50)];
        _sectionBtView.backgroundColor = hexColor(0x404040);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionAction)];
        [_sectionBtView addGestureRecognizer:tap];
    }
    return _sectionBtView;
}

-(void)sectionAction{
    
    self.count ++;
    
    switch (self.count%2) {
        case 1:
            
            
            
            break;
            
        default:
            break;
    }
}

#pragma mark -UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.backgroundColor = [hexColor(0x00c18b) colorWithAlphaComponent:0.2];
    return cell;
}

@end
