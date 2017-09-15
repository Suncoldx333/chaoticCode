//
//  AsyncSafeVC.m
//  JSCallOC
//
//  Created by 11111 on 2017/8/25.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "AsyncSafeVC.h"
#import "MayIHelpYou-Swift.h"
#import "AsyncSafeOCManage.h"

@interface AsyncSafeVC ()

@property (nonatomic,strong) AsyncSafeSwiftyManage *manage;
@property (nonatomic,strong) AsyncSafeOCManage *ocManage;
@property (nonatomic,copy) NSString *asyncStr;

@end

@implementation AsyncSafeVC{

    UIView *removeActView;
    NSBlockOperation *testOpe;
    NSBlockOperation *swiftyConflictOpe;
    UIButton *checkBt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    
    NSMutableDictionary *dic = nil;
    NSNumber *selDis = [NSNumber numberWithInt:[[dic objectForKey:@"sporttype"] intValue]];

    
    self.manage = [AsyncSafeSwiftyManage share];
    self.ocManage = [[AsyncSafeOCManage alloc] init];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 100000; i++) {
        [arr addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    self.manage.swiftyDataArr = arr;
    self.ocManage.dataArr = arr;
    [self configureOperation];
}

-(void)initUI{
    self.view.backgroundColor = hexColor(0xffffff);
    
    removeActView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    removeActView.backgroundColor = hexColor(0xe6e6e6);
    [self.view addSubview:removeActView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removementDelay:)];
    [removeActView addGestureRecognizer:tap];
    
    checkBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, 100, 50)];
    [checkBt setTitle:@"check" forState:UIControlStateNormal];
    [checkBt setBackgroundColor:hexColor(0xe6e6e6)];
    [checkBt addTarget:self
                action:@selector(checkFinalState)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBt];
}

-(void)asyncStrChange{
    
    dispatch_queue_t queue = dispatch_queue_create("parallel", DISPATCH_QUEUE_CONCURRENT);
    
    for (NSInteger i = 0; i < 10000; i++) {
        dispatch_async(queue, ^{
            self.asyncStr = [NSString stringWithFormat:@"now is %ld",(long)i];
            NSLog(@"asyncStr = %@",self.asyncStr);
        });
    }
    
}

-(void)checkFinalState{
    [self.manage checkCurArr];
}

-(void)configureOperation{
    
    __weak typeof(self) weakSelf = self;
    
    testOpe = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf.ocManage traverseArr];
        
    }];
    
    [testOpe addExecutionBlock:^{
        [weakSelf.ocManage deleteArr];
        
    }];
    
    swiftyConflictOpe = [NSBlockOperation blockOperationWithBlock:^{
        
        [weakSelf.manage traverseArrWithType:1];
    }];

    
    [swiftyConflictOpe addExecutionBlock:^{
        [weakSelf.manage swiftyDeleteAll];
    }];
}

-(void)removementDelay:(UITapGestureRecognizer *)sender{
    
//    [self asyncStrChange];
    
    CGFloat x = [sender locationInView:removeActView].x;
    if (x < ScreenWidth / 2) {
        
        [testOpe start];//由于NSArray及其子类为引用类型，多线程操作时如果发生越界之类的行为就会导致Crash
    }else{
        
        [swiftyConflictOpe start];//Array为值类型，多线程操作时仅发生复制，对原有对象不操作
    }
}

@end
