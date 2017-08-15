//
//  LLDBLearn.m
//  JSCallOC
//
//  LLDB 验证想法
//
//  Created by 11111 on 2017/8/14.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "LLDBLearn.h"
#import "LLDBLearnObject+NewVar.h"

@interface LLDBLearn (){
    NSString *targetStr;
}

@property (nonatomic,copy) NSString *outer;
@property (nonatomic,strong) NSBlockOperation *teOpe;
@property (nonatomic,strong) LLDBLearnObject *object;

@end

@implementation LLDBLearn

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    
    NSString *look = @"First";
    [self printString:look];
    look = @"Second";
    [self printString:look];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    
    self.object = [[LLDBLearnObject alloc] init];
    self.object.varByPro = @"property";
    self.object.varByCata = @"catagory";
    
    __block NSString *dataName = @"data";
    self.teOpe = [NSBlockOperation blockOperationWithBlock:^{
        dataName = @"inner data";
        NSLog(@"%@",dataName);
    }];
}

-(void)initUI{
    self.view.backgroundColor = hexColor(0xffffff);
    
    UIView *btView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btView.backgroundColor = [hexColor(0x00c18b) colorWithAlphaComponent:0.2];
    [self.view addSubview:btView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(helloBreak)];
    [btView addGestureRecognizer:tap];
    
}

-(void)printString:(NSString *)str{
    NSLog(@"%@",str);
}

-(void)helloBreak{
    
//    NSArray *array = @[@1,@2];
//    NSLog(@"item 3 :%@",array[2]);
    
    NSString *name = @"2";
    NSInteger count = 99;
    self.outer = [NSString stringWithFormat:@"%@%ld",name,(long)count];
    targetStr = [NSString stringWithFormat:@"%@%ld",name,(long)count + 1];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"now data is inner");
    });
    
    NSLog(@"helloBreak");
}

@end
