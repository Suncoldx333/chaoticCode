//
//  BDDiffVC.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "BDDiffVC.h"
#import "BDDiffView.h"

typedef enum : NSUInteger {
    holo = 1,
    sorry = 2,
    shit = 3,
} Clause;

@interface BDDiffVC ()<BDDiffViewDelegate>

@end

@implementation BDDiffVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    NSInteger hello = 12;
    
    switch (hello) {
        case 23:
            NSLog(@"now switch 12");
            break;
            
        case 12:
            NSLog(@"now switch 23");
            break;
            
        default:
            NSLog(@"break");
            break;
    }
    
    if (hello == 12) {
        NSLog(@"now if 12");
    }else if (hello == 23){
        NSLog(@"now if 23");
    }else{
        NSLog(@"now if default");
    }
}

-(void)initUI{
    
    self.view.backgroundColor = hexColor(0xffffff);
    
    BDDiffView *view = [[BDDiffView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    view.delegate = self;
    __weak typeof(self) weakSelf = self;
    view.testBlock = ^{
        [weakSelf tapEventFunc];
    };
    [self.view addSubview:view];
    
    UIImage *image1 = [UIImage imageNamed:@"switchToData"];
    UIImage *image2 = [UIImage imageNamed:@"switchToData"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.image = image1;
    [self.view addSubview:imageView];
    
}

-(void)tapEventFunc{
    NSLog(@"delegate");
}

@end
