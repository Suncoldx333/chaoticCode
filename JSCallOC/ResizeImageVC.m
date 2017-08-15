//
//  ResizeImageVC.m
//  JSCallOC
//
//  图片平铺效果
//
//  Created by 11111 on 2017/8/8.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "ResizeImageVC.h"

@interface ResizeImageVC ()

@end

@implementation ResizeImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    self.view.backgroundColor = hexColor(0xe6e6e6);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
//    imageView.contentMode = UIViewContentModeScaleToFill;
    UIImage *image = [UIImage imageNamed:@"oppositeContentBg"];
    imageView.image = [image stretchableImageWithLeftCapWidth:14 topCapHeight:24];
    [self.view addSubview:imageView];
    
}

@end
