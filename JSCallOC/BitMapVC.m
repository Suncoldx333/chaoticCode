//
//  BitMapVC.m
//  JSCallOC
//
//  Created by 11111 on 2017/7/28.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BitMapVC.h"
#import "BitMapView.h"

@interface BitMapVC ()

@property (nonatomic,strong) UIView *changeBtView;
@property (nonatomic,strong) BitMapView *mapView;

@end

@implementation BitMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mapView = [[BitMapView alloc] initWithFrame:CGRectMake(0, 0, 375, 667 / 2)];
    [self.view addSubview:self.mapView];
    
    [self.view addSubview:self.changeBtView];
}

-(UIView *)changeBtView{
    if (!_changeBtView) {
        _changeBtView = [[UIView alloc] initWithFrame:CGRectMake(0, 667 / 2, 50, 50)];
        _changeBtView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disPlayBitView)];
        [_changeBtView addGestureRecognizer:tap];
    }
    return _changeBtView;
}

-(void)disPlayBitView{
    [self.mapView setNeedsDisplayInRect:CGRectMake(0, 0, 100, 100)];
}

@end
