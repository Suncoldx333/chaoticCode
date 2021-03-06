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

#import "HelloOperation.h"
#import "UIImageView+WebCache.h"
#import <SBJson/SBJson5.h>
#import "testAnimationVC.h"

#import "CataTestView.h"
#import "CataTestView+BridgeTest.h"
#import "teView.h"
#import "teModel.h"
#import "teModel+UnitTest.h"

#import "MD5Encryption.h"

#import "KeyBoardVC.h"
#define KEYSTR_RUNRECORD @"&ODJw#h03b_0EaV"  //跑步记录
#define KEYSTR @"&wh2016_swcampus"  //其它

#import "CodeLabHeader.h"

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

@property (nonatomic,strong) UIView *oriView;

@property (nonatomic,strong) UITableView *list;

@end

@implementation ViewController{
    NSMutableArray<NSString *> *titles;
}

@synthesize testView;
@synthesize teStronStr;

@synthesize blovk,blovk2;

#pragma mark - View lifecircle
-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
    NSLog(@"here is originalMethod");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];

    [self initUI];
    
    self.navigationController.navigationBar.translucent = NO;

}

-(void)helloBoy{
    NSLog(@"main");
}

#pragma mark - Data initialize
-(void)initData{
    
    titles = [[NSMutableArray alloc] init];
    NSString *className = NSStringFromClass([SwiftyDiffVC class]);
    [titles addObject:className];

    NSString *resize = NSStringFromClass([ResizeImageVC class]);
    [titles addObject:resize];
    
    NSString *texture = NSStringFromClass([TextureVC class]);
    [titles addObject:texture];
    
    NSString *lldb = NSStringFromClass([LLDBLearn class]);
    [titles addObject:lldb];
    
    NSString *svc = NSStringFromClass([SVCPracticeTable class]);
    [titles addObject:svc];
    [titles addObject:NSStringFromClass([RxSwiftTable class])];
    [titles addObject:NSStringFromClass([BlueTooth class])];
    [titles addObject:NSStringFromClass([BDDiffVC class])];
    [titles addObject:NSStringFromClass([AsyncSafeVC class])];
    [titles addObject:NSStringFromClass([SwiftLab class])];
    [titles addObject:NSStringFromClass([WeexVC class])];
    
}

#pragma mark - UI initialize
-(void)initUI{
    
    self.view.backgroundColor = hexColor(0xe6e6e6);
    [self.view addSubview:self.list];

}

#pragma mark -Private method
#pragma mark - ----Lazy loading
-(UITableView *)list{
    if (!_list) {
        _list = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _list.delegate = self;
        _list.dataSource = self;
        _list.estimatedSectionFooterHeight = 0;
        _list.estimatedSectionHeaderHeight = 0;
        _list.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_list registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _list;
}

#pragma mark - UITableView(Delegate,Datasource)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.5;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CALayer *underLine = [[CALayer alloc] init];
    underLine.frame = CGRectMake(0, 45, ScreenWidth, 0.5);
    underLine.backgroundColor = hexColor(0xe6e6e6).CGColor;
    
    [cell.contentView.layer addSublayer:underLine];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = [titles objectAtIndex:indexPath.row];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = [titles objectAtIndex:indexPath.row];
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(NSString *)incomingDictionaryReturnsTheEncryptedStringForDic:(NSMutableDictionary*)dic aboutScore:(BOOL)didAbout{
    if (didAbout) {
        if ([dic[@"getPrize"] boolValue]) {
            [dic setObject:@"true" forKey:@"getPrize"];
        }else{
            [dic setObject:@"false" forKey:@"getPrize"];
        }
        
        if ([dic[@"complete"] boolValue]) {
            [dic setObject:@"true" forKey:@"complete"];
        }else{
            [dic setObject:@"false" forKey:@"complete"];
        }
    }
    
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray<NSString *> *resultArray = [[dic allKeys] sortedArrayUsingComparator:sort];
    
    NSMutableString * str = [NSMutableString string];
    
    for (int i = 0; i<resultArray.count; i++) {
        
        if ([[resultArray objectAtIndex:i] isEqualToString:@"fivePointJson"] || [[resultArray objectAtIndex:i] isEqualToString:@"allLocJson"]) {
            
        }else{
            if (i == 0 || str.length == 0) {
                str = [NSMutableString stringWithFormat:@"%@=%@",resultArray[i],dic[resultArray[i]]];
            }else{
                str = [NSMutableString stringWithFormat:@"%@&%@=%@",str,resultArray[i],dic[resultArray[i]]];
            }
        }
        
    }
    
    if (didAbout) {
        str = [NSMutableString stringWithFormat:@"%@%@",str,KEYSTR_RUNRECORD];
    }else{
        str = [NSMutableString stringWithFormat:@"%@%@",str,KEYSTR];
    }
    
    NSString * string = [MD5Encryption getMd5String:str];
    return string;
}

-(void)initHelloData{
    
    NSInteger avgStepFreq = 0;
    NSInteger total = 47;
    NSUInteger count = 50;
    double frepDouble = total * 1.000 / (count * 1.000 / 6.000);
    avgStepFreq = [NSNumber numberWithDouble:frepDouble].integerValue;
    
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
    
    teModel *model = [[teModel alloc] init];
    [model arrInsertFunc];
    
    UIImageView *teImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    teImage.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    teImage.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    teImage.userInteractionEnabled = YES;
    [self.view addSubview:teImage];
    
//    [teImage setImageWithImageUrl:[NSURL URLWithString:@"https://raw.githubent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg"]
//                 placeholderImage:[UIImage imageNamed:@"topicGuide"]
//                    progressBlock:^(int64_t receivedSize, int64_t totalSize) {
//                        NSLog(@"received = %lld,total = %lld",receivedSize,totalSize);
//                    }
//                    completeBlock:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finish) {
//                        NSLog(@"%@",error);
//                    }];
    
    
    UIButton *clearMem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [clearMem setTitle:@"clearMem" forState:UIControlStateNormal];
    [clearMem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clearMem.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:clearMem];
    [clearMem addTarget:self
                 action:@selector(clearMenMethod)
       forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *clearDsik = [[UIButton alloc] initWithFrame:CGRectMake(275, 0, 100, 50)];
    [clearDsik setTitle:@"clearDsik" forState:UIControlStateNormal];
    [clearDsik setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clearDsik.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:clearDsik];
    [clearDsik addTarget:self
                 action:@selector(clearDiskMethod)
       forControlEvents:UIControlEventTouchUpInside];
}

-(void)clearMenMethod{
    
    
}

-(void)clearDiskMethod{
    
    BitMapVC *map = [[BitMapVC alloc] init];
    [self.navigationController pushViewController:map animated:YES];
//
    
}

-(void)initAniUI{
    
    CataTestView *cata = [[CataTestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    cata.sign = @"mmmma";
    
    
    
    NSLog(@"sign = %@,make = %@",cata.sign,[cata makeSign]);
    
    [self.view addSubview:self.aniView];
    [self.view addSubview:self.aniGreenView];
    self.tapCount = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAniTap)];
    [self.view addGestureRecognizer:tap];
}

-(void)testAniTap{
    NSLog(@"hello test");
    
    self.tapCount ++;
    
    if (self.tapCount % 2 == 1) {
        [self turnAndScaleInZ:self.aniView];
        [self turnDataUnClockwiseAndScaleInZ:self.aniGreenView];
    }else{
        [self turnUnClockwiseAndScaleInZ:self.aniView];
        [self turnDataClockwiseAndScaleInZ:self.aniGreenView];
    }
    
}



-(void)jumpToAni{
    testAnimationVC *aniVC = [[testAnimationVC alloc] init];
    [self.navigationController pushViewController:aniVC animated:YES];
}

-(UIView *)aniView{
    if (!_aniView) {
        _aniView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
        _aniView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        _aniView.center = self.view.center;
        _aniView.layer.transform = [self getTransForm3DWith:0.f * M_PI];
        _aniView.layer.doubleSided = NO;
//        [_aniView addSubview:self.countLabel];
//        _aniView.alpha = 1;
//        _aniView.userInteractionEnabled = YES;
//        UIView *testLocView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//        testLocView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
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
        _aniGreenView.alpha = 1;
        _aniGreenView.userInteractionEnabled = NO;
        _aniGreenView.layer.doubleSided = NO;
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
    
    self.oriView.backgroundColor = [UIColor greenColor];
    
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
    
    
//    AniViewCon *aniCon = [[AniViewCon alloc] init];
//    [self.navigationController pushViewController:aniCon animated:YES];
    
//    ImagePickWidgetSwift *widget = [[ImagePickWidgetSwift alloc] init];
//    [self.navigationController pushViewController:widget animated:YES];
    
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

#pragma mark -动画效果
-(void)turnAndScaleInZ:(UIView *)teView{
    CABasicAnimation *ani1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = 4.5 / -2000;
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform1, 0 * M_PI, 0, 1, 0)];
    ani1.fromValue = value1;
    
    value1 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform1, -0.5 * M_PI, 0, 1, 0)];
    ani1.toValue = value1;
    
    ani1.duration = 0.5;
    ani1.fillMode = kCAFillModeForwards;
    ani1.removedOnCompletion = NO;
    ani1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = 4.5 / -2000;
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform2, -0.5 * M_PI, 0, 1, 0)];
    ani2.fromValue = value2;
    
    value2 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform2, -1 * M_PI, 0, 1, 0)];
    ani2.toValue = value2;
    ani2.beginTime = 0.5;
    ani2.duration = 0.5;
    ani2.fillMode = kCAFillModeForwards;
    ani2.removedOnCompletion = NO;
    ani2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *ani3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    ani3.fromValue = [NSNumber numberWithFloat:1.0];
    ani3.toValue = [NSNumber numberWithFloat:0.7];
    
    ani3.duration = 0.5;
    ani3.fillMode = kCAFillModeForwards;
    ani3.removedOnCompletion = NO;
    ani3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *ani4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    ani4.fromValue = [NSNumber numberWithFloat:0.7];
    ani4.toValue = [NSNumber numberWithFloat:1.0];
    ani4.beginTime = 0.5;
    ani4.duration = 0.5;
    ani4.fillMode = kCAFillModeForwards;
    ani4.removedOnCompletion = NO;
    ani4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.autoreverses = NO;
    group.animations = @[ani1,ani2,ani3,ani4];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [teView.layer addAnimation:group forKey:nil];
}

-(void)turnUnClockwiseAndScaleInZ:(UIView *)teView{
    CABasicAnimation *ani1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = 4.5 / -2000;
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform1, -1 * M_PI, 0, 1, 0)];
    ani1.fromValue = value1;
    
    value1 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform1, -0.5 * M_PI, 0, 1, 0)];
    ani1.toValue = value1;
    
    ani1.duration = 0.5;
    ani1.fillMode = kCAFillModeForwards;
    ani1.removedOnCompletion = NO;
    ani1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = 4.5 / -2000;
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform2, -0.5 * M_PI, 0, 1, 0)];
    ani2.fromValue = value2;
    
    value2 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform2, 0 * M_PI, 0, 1, 0)];
    ani2.toValue = value2;
    ani2.beginTime = 0.5;
    ani2.duration = 0.5;
    ani2.fillMode = kCAFillModeForwards;
    ani2.removedOnCompletion = NO;
    ani2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *ani3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    ani3.fromValue = [NSNumber numberWithFloat:1.0];
    ani3.toValue = [NSNumber numberWithFloat:0.7];
    
    ani3.duration = 0.5;
    ani3.fillMode = kCAFillModeForwards;
    ani3.removedOnCompletion = NO;
    ani3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *ani4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    ani4.fromValue = [NSNumber numberWithFloat:0.7];
    ani4.toValue = [NSNumber numberWithFloat:1.0];
    ani4.beginTime = 0.5;
    ani4.duration = 0.5;
    ani4.fillMode = kCAFillModeForwards;
    ani4.removedOnCompletion = NO;
    ani4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.autoreverses = NO;
    group.animations = @[ani1,ani2,ani3,ani4];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    //    group.repeatCount =
    
    [teView.layer addAnimation:group forKey:nil];
}

-(void)turnDataUnClockwiseAndScaleInZ:(UIView *)teView{
    CABasicAnimation *ani1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = 4.5 / -2000;
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform1, -1 * M_PI, 0, 1, 0)];
    ani1.fromValue = value1;
    
    value1 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform1, -1.5 * M_PI, 0, 1, 0)];
    ani1.toValue = value1;
    
    ani1.duration = 0.5;
    ani1.fillMode = kCAFillModeForwards;
    ani1.removedOnCompletion = NO;
    ani1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = 4.5 / -2000;
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform2, -1.5 * M_PI, 0, 1, 0)];
    ani2.fromValue = value2;
    
    value2 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform2, -2 * M_PI, 0, 1, 0)];
    ani2.toValue = value2;
    ani2.beginTime = 0.5;
    ani2.duration = 0.5;
    ani2.fillMode = kCAFillModeForwards;
    ani2.removedOnCompletion = NO;
    ani2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *ani3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    ani3.fromValue = [NSNumber numberWithFloat:1.0];
    ani3.toValue = [NSNumber numberWithFloat:0.7];
    
    ani3.duration = 0.5;
    ani3.fillMode = kCAFillModeForwards;
    ani3.removedOnCompletion = NO;
    ani3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *ani4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    ani4.fromValue = [NSNumber numberWithFloat:0.7];
    ani4.toValue = [NSNumber numberWithFloat:1.0];
    ani4.beginTime = 0.5;
    ani4.duration = 0.5;
    ani4.fillMode = kCAFillModeForwards;
    ani4.removedOnCompletion = NO;
    ani4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.autoreverses = NO;
    group.animations = @[ani1,ani2,ani3,ani4];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    //    group.repeatCount =
    
    [teView.layer addAnimation:group forKey:nil];
}

-(void)turnDataClockwiseAndScaleInZ:(UIView *)teView{
    CABasicAnimation *ani1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = 4.5 / -2000;
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform1, 0 * M_PI, 0, 1, 0)];
    ani1.fromValue = value1;
    
    value1 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform1, 0.5 * M_PI, 0, 1, 0)];
    ani1.toValue = value1;
    
    ani1.duration = 0.5;
    ani1.fillMode = kCAFillModeForwards;
    ani1.removedOnCompletion = NO;
    ani1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *ani2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = 4.5 / -2000;
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform2, 0.5 * M_PI, 0, 1, 0)];
    ani2.fromValue = value2;
    
    value2 = [NSValue valueWithCATransform3D:CATransform3DRotate(transform2, 1 * M_PI, 0, 1, 0)];
    ani2.toValue = value2;
    ani2.beginTime = 0.5;
    ani2.duration = 0.5;
    ani2.fillMode = kCAFillModeForwards;
    ani2.removedOnCompletion = NO;
    ani2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *ani3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    ani3.fromValue = [NSNumber numberWithFloat:1.0];
    ani3.toValue = [NSNumber numberWithFloat:0.7];
    
    ani3.duration = 0.5;
    ani3.fillMode = kCAFillModeForwards;
    ani3.removedOnCompletion = NO;
    ani3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *ani4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    ani4.fromValue = [NSNumber numberWithFloat:0.7];
    ani4.toValue = [NSNumber numberWithFloat:1.0];
    ani4.beginTime = 0.5;
    ani4.duration = 0.5;
    ani4.fillMode = kCAFillModeForwards;
    ani4.removedOnCompletion = NO;
    ani4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1;
    group.autoreverses = NO;
    group.animations = @[ani1,ani2,ani3,ani4];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    //    group.repeatCount =
    
    [teView.layer addAnimation:group forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
