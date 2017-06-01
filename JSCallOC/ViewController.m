//
//  ViewController.m
//  JSCallOC
//
//  Created by wangdan on 15/11/17.
//  Copyright © 2015年 wangdan. All rights reserved.
//

#import "ViewController.h"
#import "JKWebView.h"
#import <Photos/Photos.h>
#import "MayIHelpYou-Swift.h"
#import "testChild.h"

#import "ImageReader.h"

#import "AniViewCon.h"
#import "HelloOperation.h"
#import "UIImageView+WebCache.h"
#import "SBJSON.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger tetimerCount;
}

@property (nonatomic,strong) UIView *testShadowView;
@property (nonatomic,strong) NSString *teStr;
@property (nonatomic,strong) NSTimer *teTimer;

@property (nonatomic,strong) UIView *aniView;
@property (nonatomic,strong) UIView *aniGreenView;

@property (nonatomic,assign) int tapCount;

@property (nonatomic,strong) NSTimer *labelCountTimer;
@property (nonatomic,assign) int timerCount;
@property (nonatomic,strong) UILabel *countLabel;

@end

@implementation ViewController

@synthesize testView;
@synthesize teStronStr;
@synthesize teOpera;

@synthesize blovk,blovk2;

-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
    NSLog(@"here is originalMethod");
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initData];
//    [self initNewData];
//    [self initHelloData];
//    [self initUI];
    [self initNewUI];
    self.navigationController.navigationBar.translucent = NO;

}

-(void)initData{
    baseModel *model = [[baseModel alloc] initWithTeDouble:1.23];
    
}



-(void)initHelloData{
    NSInteger avgStepFreq = 0;
    NSInteger total = 47;
    NSUInteger count = 50;
    double frepDouble = total * 1.000 / (count * 1.000 / 6.000);
    avgStepFreq = [NSNumber numberWithDouble:frepDouble].integerValue;
    
    teOpera = [[teOperation alloc] init];
    
    blovk = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1在第%@个线程",[NSThread currentThread]);
    }];
    [blovk addExecutionBlock:^{
        NSLog(@"2在第%@个线程",[NSThread currentThread]);
    }];
    [blovk addExecutionBlock:^{
        NSLog(@"3在第%@个线程",[NSThread currentThread]);
    }];
    [blovk addExecutionBlock:^{
        NSLog(@"4在第%@个线程",[NSThread currentThread]);
    }];
    [blovk addExecutionBlock:^{
        NSLog(@"5在第%@个线程",[NSThread currentThread]);
    }];
    [blovk addExecutionBlock:^{
        NSLog(@"6在第%@个线程",[NSThread currentThread]);
    }];
    blovk2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"9999在第%@个线程",[NSThread currentThread]);
    }];
}

-(void)initNewData{
    
    baseModel *model = [[baseModel alloc] initWithTeDouble:1.23];
    NSLog(@"%@",model.mayStr);
    
    tetimerCount = 0;
    
    NSString *tehaha = nil;
    NSString *mayd = [NSString stringWithFormat:@"adada%@",tehaha];
    
    testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:testView];
    
    NSMutableDictionary *teDic = [[NSMutableDictionary alloc] init];
    
    NSString *url1 = @"url1";
    NSString *url2 = @"url2";
    NSString *url3 = nil;
    BOOL tot = nil; //后台协定
    NSNumber * totalDis = [NSNumber numberWithBool:tot];
    NSString *url4 = @"url3";
    NSString *url5 = @"url4";
    NSString *url6 = @"url5";
    
    NSMutableDictionary *urlDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:url1,@"te1",url2,@"te2",totalDis,@"te3",url4,@"te4",url5,@"te5",url6,@"te6", nil];
    
    [teDic setObject:@"testValue1" forKey:@"testKey1"];
    [teDic setObject:@"testValue2" forKey:@"testKey2"];
    [teDic setObject:@"testValue3" forKey:@"testKey3"];
    [teDic setObject:@"testValue4" forKey:@"testKey4"];
    [teDic setObject:@"testValue5" forKey:@"testKey5"];
    [teDic setObject:@"testValue6" forKey:@"testKey6"];
    [teDic setObject:@"testValue7" forKey:@"testKey7"];

    NSString *hello = @"dada";
    
    objc_setAssociatedObject(testView, @"link", teDic, OBJC_ASSOCIATION_COPY);
    
    unsigned int outCout = 0;
    objc_property_t *propeList = class_copyPropertyList([testView class], &outCout);
    
    NSMutableArray *arrM = [[NSMutableArray alloc] initWithCapacity:outCout];
    
    for (NSInteger i = 0; i < outCout; i++) {
        objc_property_t pro = propeList[i];
        const char *name = property_getName(pro);
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [arrM addObject:nameStr];
    }
    
    free(propeList);
    
    NSURL *url = [[NSURL alloc] initWithString:@"ashdlahda"];
    CFURLRef ref = (__bridge CFURLRef)url;
    
    
}

-(void)teHello{
    tetimerCount++;
    NSLog(@"count=%ld",(long)tetimerCount);
}

-(void)testParent{
    NSLog(@"here is parent");
}

-(void)initNewUI{

    NSOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1");
        NSOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"op2");
        }];
        [op2 start];
    }];
    [op1 start];
    
//    tesWebImageView *teView = [[tesWebImageView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:teView];
    
}

-(void)initUI{
    
    
    self.navigationItem.title = @"TEST";
    self.tapCount = 0;
    self.timerCount = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.aniView];
    [self.view addSubview:self.aniGreenView];
    
    UIImageView *teImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    teImage.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    teImage.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    teImage.userInteractionEnabled = YES;
    [self.view addSubview:teImage];
//
    [teImage sd_setImageWithURL:[NSURL URLWithString:@"http://gxapp-images.oss-cn-hangzhou.aliyuncs.com/news-images/20170510/5387f9a7c2af45eda6a70ceea78d8bac.jpg"]
               placeholderImage:[UIImage imageNamed:@"topicGuide"]
                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          
                      }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testTap)];
    [self.view addGestureRecognizer:tap];
}

-(UIView *)aniView{
    if (!_aniView) {
        _aniView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
        _aniView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        _aniView.center = self.view.center;
        _aniView.layer.transform = [self getTransForm3DWith:0.f * M_PI];
        [_aniView addSubview:self.countLabel];
        _aniView.alpha = 1;
        _aniView.userInteractionEnabled = YES;
        UIView *testLocView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        testLocView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
//        [_aniView addSubview:testLocView];
        
    }
    return _aniView;
    
}

-(UIView *)aniGreenView{
    if (!_aniGreenView) {
        _aniGreenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
        _aniGreenView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
        _aniGreenView.center = self.view.center;
        _aniGreenView.layer.transform = [self getTransForm3DWith:-1.f * M_PI];
//        _aniGreenView.alpha = 0;
        _aniGreenView.userInteractionEnabled = NO;
        
        UIView *testLocView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        testLocView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [_aniGreenView addSubview:testLocView];
    }
    return _aniGreenView;
}

-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _countLabel.backgroundColor = [UIColor grayColor];
        _countLabel.textColor = [UIColor blackColor];
        [self.aniView addSubview:_countLabel];
    }
    return _countLabel;
}

-(CABasicAnimation *)makeLayerHideAni{
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotaAni.fromValue = @0;
    rotaAni.toValue = @M_PI;
    rotaAni.duration = 2.0;
    rotaAni.delegate = self;
    rotaAni.removedOnCompletion = NO;
    rotaAni.fillMode = kCAFillModeForwards;
    rotaAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return rotaAni;
}

-(CABasicAnimation *)makeLayerShowAni{
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotaAni.fromValue = @M_PI;
    rotaAni.toValue = @0;
    rotaAni.duration = 2.0;
    rotaAni.delegate = self;
    rotaAni.removedOnCompletion = NO;
    rotaAni.fillMode = kCAFillModeForwards;
    rotaAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return rotaAni;
}

-(CABasicAnimation *)makeLayer3DAni{
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 4.5 / -2000;
    transform = CATransform3DRotate(transform, 0.f * M_PI, 0, 1, 0);
    NSValue *value = [NSValue valueWithCATransform3D:transform];
    rotaAni.fromValue = value;
    
    transform = CATransform3DRotate(transform, 1.f * M_PI, 0, 1, 0);
    value = [NSValue valueWithCATransform3D:transform];
    rotaAni.toValue = value;
    
    rotaAni.duration = 2.0;
    rotaAni.delegate = self;
    rotaAni.removedOnCompletion = NO;
    rotaAni.fillMode = kCAFillModeForwards;
    rotaAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return rotaAni;
}

-(CABasicAnimation *)makeLayer3DHideAni{
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 4.5 / -2000;
    transform = CATransform3DRotate(transform, 0.f * M_PI, 0, 1, 0);
    NSValue *value = [NSValue valueWithCATransform3D:transform];
    rotaAni.toValue = value;
    
    transform = CATransform3DRotate(transform, 1.f * M_PI, 0, 1, 0);
    value = [NSValue valueWithCATransform3D:transform];
    rotaAni.fromValue = value;
    
    rotaAni.duration = 2.0;
    rotaAni.delegate = self;
    rotaAni.removedOnCompletion = NO;
    rotaAni.fillMode = kCAFillModeForwards;
    rotaAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return rotaAni;
}

-(CABasicAnimation *)makeLayer3DGreenAni{
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 4.5 / -2000;
    transform = CATransform3DRotate(transform, -1.f * M_PI, 0, 1, 0);
    NSValue *value = [NSValue valueWithCATransform3D:transform];
    rotaAni.fromValue = value;
    
    transform = CATransform3DRotate(transform, -0.9999 * M_PI, 0, 1, 0);
    value = [NSValue valueWithCATransform3D:transform];
    rotaAni.toValue = value;
    
    rotaAni.duration = 2.0;
    rotaAni.delegate = self;
    rotaAni.removedOnCompletion = NO;
    rotaAni.fillMode = kCAFillModeForwards;
    rotaAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return rotaAni;
}

-(CABasicAnimation *)makeLayer3DHideGreenAni{
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 4.5 / -2000;
    transform = CATransform3DRotate(transform, 0.0001 * M_PI, 0, 1, 0);
    NSValue *value = [NSValue valueWithCATransform3D:transform];
    rotaAni.fromValue = value;
    
    transform = CATransform3DRotate(transform, 0.9999 * M_PI, 0, 1, 0);
    value = [NSValue valueWithCATransform3D:transform];
    rotaAni.toValue = value;
    
    rotaAni.duration = 2.0;
    rotaAni.delegate = self;
    rotaAni.removedOnCompletion = NO;
    rotaAni.fillMode = kCAFillModeForwards;
    rotaAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return rotaAni;
}

-(void)labelCountMore{
    NSLog(@"count=%d",self.timerCount);
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.timerCount];
    self.timerCount ++;
}

-(void)animationDidStart:(CAAnimation *)anim{
    
//    if (self.tapCount % 2 == 1) {
//        [UIView animateWithDuration:anim.duration/2
//                         animations:^{
//                             self.aniView.alpha = 0;
//                             self.aniGreenView.alpha = 1;
//                         }
//                         completion:^(BOOL finished) {
//                             
//                         }];
//    }else{
//        [UIView animateWithDuration:anim.duration/2
//                         animations:^{
//                             self.aniView.alpha = 1;
//                             self.aniGreenView.alpha = 0;
//                         }
//                         completion:^(BOOL finished) {
//                             
//                         }];
//    }
    
}

-(CATransform3D)getTransForm3DWith:(CGFloat)angle{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 4.5 / -2000;
    transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    
    return transform;
}

-(void)testTap{
    
//    [self.aniView.layer addAnimation:[self makeLayer3DAni] forKey:nil];
    
    if (self.tapCount == 0) {
//        if (!self.labelCountTimer) {
//            self.labelCountTimer = [NSTimer scheduledTimerWithTimeInterval:1.f
//                                                                    target:self
//                                                                  selector:@selector(labelCountMore)
//                                                                  userInfo:nil
//                                                                   repeats:YES];
//            [[NSRunLoop currentRunLoop] addTimer:self.labelCountTimer forMode:NSRunLoopCommonModes];
//        }
    }
    
//    self.tapCount ++;
//    if (self.tapCount % 2 == 1) {
//        
//        [self.aniView.layer addAnimation:[self makeLayer3DAni] forKey:nil];
//        [self.aniGreenView.layer addAnimation:[self makeLayer3DGreenAni] forKey:nil];
//    }else{
//
//        [self.aniView.layer addAnimation:[self makeLayer3DHideAni] forKey:nil];
//        [self.aniGreenView.layer addAnimation:[self makeLayer3DHideGreenAni] forKey:nil];
//    }
    
    
    AniViewCon *aniCon = [[AniViewCon alloc] init];
    [self.navigationController pushViewController:aniCon animated:YES];
    
//    NSString *urlStr = @"balabala://topicDetail?id=xxx";
//    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]
//                                           options:nil
//                                 completionHandler:^(BOOL success) {
//                                     
//                                 }];
//    }else{
//        NSLog(@"can not");
//    }
    
//    NSMutableDictionary *rtHello = objc_getAssociatedObject(testView, @"link");
//    NSLog(@"%@",rtHello);
    
//    testChild *child = [[testChild alloc] init];
//    [self presentViewController:child animated:YES completion:^{
//        
//    }];
    
//    NSOperationQueue *queque = [[NSOperationQueue alloc] init];
//    [queque addOperation:teOpera];
    
//    [blovk2 addDependency:blovk];
//    [queque addOperation:blovk2];
//    [queque addOperation:blovk];

//    [blovk start];
    
//    BaseCoreData *dataModel = [BaseCoreData]
}

-(void)panTest{
    NSLog(@"pan");
}

-(void)removeGes{
    
    if (_teTimer == nil) {
        _teTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(teHello)
                                                  userInfo:nil
                                                   repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_teTimer forMode:NSRunLoopCommonModes];
    }else{
        [_teTimer invalidate];
        _teTimer = nil;
        _teTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                    target:self
                                                  selector:@selector(teHello)
                                                  userInfo:nil
                                                   repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_teTimer forMode:NSRunLoopCommonModes];
    }
}

//-(void)showWhereFuncIs{
//    NSLog(@"hereIsMain");
//}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    }
    cell.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
