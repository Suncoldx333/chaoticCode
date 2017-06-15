//
//  testAniVC.m
//  JSCallOC
//
//  Created by 11111 on 2017/6/12.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "testAniVC.h"

@interface testAniVC ()

@end

@implementation testAniVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)backgroungView{
    if (!backgroungView) {
        backgroungView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        backgroungView.backgroundColor = hexColor(0xe6e6e6);
    }
    return backgroungView;
}

-(BaseRTPathView *)RTPathView{
    if (!RTPathView) {
        RTPathView = [[BaseRTPathView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        RTPathView.layer.affineTransform = CATransform3DGetAffineTransform([self getTransForm3DWith:0 * M_PI]);
        RTPathView.alpha = 1;
        RTPathView.userInteractionEnabled = YES;
        
        __weak typeof(self) weakSelf = self;
        RTPathView.switchToDataBlock = ^{
            weakSelf.curViewType = SwitchTypePath;
            [weakSelf viewSwitchFrom:SwitchTypePath];
        };
        
    }
    return RTPathView;
}

-(BaseRTDataView *)RTDataView{
    if (!RTDataView) {
        RTDataView = [[BaseRTDataView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        RTDataView.layer.affineTransform = CATransform3DGetAffineTransform([self getTransForm3DWith:-1 * M_PI]);
        RTDataView.alpha = 0;
        RTDataView.userInteractionEnabled = NO;
        
        __weak typeof(self) weakSelf = self;
        RTDataView.switchToPathBlock = ^{
            weakSelf.curViewType = SwitchTypeData;
            [weakSelf viewSwitchFrom:SwitchTypeData];
        };
    }
    return RTDataView;
}

-(void)viewSwitchFrom:(SwitchType)type{
    switch (type) {
        case SwitchTypePath:
            [self.RTPathView.layer addAnimation:[self makeLayerAnimation:HidePath] forKey:nil];
            [self.RTDataView.layer addAnimation:[self makeLayerAnimation:ShowData] forKey:nil];
            break;
            
        case SwitchTypeData:
            [self.RTPathView.layer addAnimation:[self makeLayerAnimation:ShowPath] forKey:nil];
            [self.RTDataView.layer addAnimation:[self makeLayerAnimation:HideData] forKey:nil];
            break;
            
        default:
            break;
    }
}

-(CAAnimationGroup *)makeLayerAnimations:(SwitchAnimationType)type{
    CABasicAnimation *rotaAni1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    CABasicAnimation *rotaAni2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = 4.5 / -2000;
    
    CATransform3D transScale1 = CATransform3DScale(transform1, 1, 1, 1);
    //    CATransform3D transMove1 = CATransform3DTranslate(transScale1, 0, 0, 0);
    CATransform3D transRotate1 = CATransform3DRotate(transform1, 0 * M_PI, 0, 1, 0);
    NSValue *value1 = [NSValue valueWithCATransform3D:transRotate1];
    rotaAni1.fromValue = value1;
    
    transScale1 = CATransform3DScale(transform1, 0.5, 0.5, 1);
    //    transMove1 = CATransform3DTranslate(transScale1, 0, 0, 0);
    transRotate1 = CATransform3DRotate(transform1, 0.5 * M_PI, 0, 1, 0);
    value1 = [NSValue valueWithCATransform3D:transRotate1];
    
    rotaAni1.toValue = value1;
    rotaAni1.beginTime = 0;
    rotaAni1.duration = 3;
    rotaAni1.fillMode = kCAFillModeForwards;
    rotaAni1.removedOnCompletion = NO;
    rotaAni1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    rotaAni2.fromValue = value1;
    
    transScale1 = CATransform3DScale(transform1, 1, 1, 1);
    //    transMove1 = CATransform3DTranslate(transScale1, 0, 0, 0);
    transRotate1 = CATransform3DRotate(transform1, 1 * M_PI, 0, 1, 0);
    value1 = [NSValue valueWithCATransform3D:transRotate1];
    rotaAni2.toValue = value1;
    
    rotaAni2.beginTime = 3;
    rotaAni2.duration = 3;
    rotaAni2.fillMode = kCAFillModeForwards;
    rotaAni2.removedOnCompletion = NO;
    rotaAni2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 6;
    group.animations = @[rotaAni1,rotaAni2];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    return group;
}

-(CABasicAnimation *)makeLayerAnimation:(SwitchAnimationType)type{
    
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D transform = CATransform3DIdentity;
    CATransform3D transScale;
    transform.m34 = 4.5 / -2000;
    NSValue *value;
    
    switch (type) {
        case ShowData:
            value = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, -1 * M_PI, 0, 1, 0)];
            rotaAni.fromValue = value;
            value = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 0.0001 * M_PI, 0, 1, 0)];
            rotaAni.toValue = value;
            break;
            
        case HidePath:
            
            value = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 0 * M_PI, 0, 1, 0)];
            rotaAni.fromValue = value;
            value = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 1 * M_PI, 0, 1, 0)];
            rotaAni.toValue = value;
            break;
            
        case ShowPath:
            value = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 1 * M_PI, 0, 1, 0)];
            rotaAni.fromValue = value;
            value = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 0 * M_PI, 0, 1, 0)];
            rotaAni.toValue = value;
            break;
            
        case HideData:
            value = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 0.0001 * M_PI, 0, 1, 0)];
            rotaAni.fromValue = value;
            value = [NSValue valueWithCATransform3D:CATransform3DRotate(transform, -1 * M_PI, 0, 1, 0)];
            rotaAni.toValue = value;
            break;
            
        default:
            break;
    }
    
    rotaAni.duration = 0.8;
    rotaAni.delegate = self;
    rotaAni.removedOnCompletion = NO;
    rotaAni.fillMode = kCAFillModeForwards;
    rotaAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return rotaAni;
}

#pragma mark -CAAnimation(CAAnimationDelegate)

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        self.aniCount ++;
        if (self.aniCount % 2 == 1) {
            if (self.curViewType == SwitchTypePath) {
                self.curViewType = SwitchTypeData;
                self.RTDataView.layer.affineTransform = CATransform3DGetAffineTransform([self getTransForm3DWith:0 * M_PI]);
            }else if (self.curViewType == SwitchTypeData){
                self.curViewType = SwitchTypePath;
                self.RTDataView.layer.affineTransform = CATransform3DGetAffineTransform([self getTransForm3DWith:-1 * M_PI]);
            }
        }
    }
}

-(void)animationDidStart:(CAAnimation *)anim{
    
    self.aniCount ++;
    if (self.aniCount % 2 == 1) {
        if (self.curViewType == SwitchTypePath) {
            
            [UIView animateWithDuration:anim.duration / 2
                             animations:^{
                                 self.RTPathView.alpha = 0;
                                 
                             }
                             completion:^(BOOL finished) {
                                 
                                 [UIView animateWithDuration:anim.duration / 2
                                                  animations:^{
                                                      self.RTDataView.alpha = 1;
                                                      
                                                  }
                                                  completion:^(BOOL finished) {
                                                      
                                                      self.RTPathView.userInteractionEnabled = NO;
                                                      self.RTDataView.userInteractionEnabled = YES;
                                                  }];
                                 
                                 
                             }];
        }else if (self.curViewType == SwitchTypeData){
            [UIView animateWithDuration:anim.duration / 2
                             animations:^{
                                 self.RTDataView.alpha = 0;
                                 
                             }
                             completion:^(BOOL finished) {
                                 [UIView animateWithDuration:anim.duration / 2
                                                  animations:^{
                                                      self.RTPathView.alpha = 1;
                                                      
                                                  }
                                                  completion:^(BOOL finished) {
                                                      self.RTPathView.userInteractionEnabled = YES;
                                                      self.RTDataView.userInteractionEnabled = NO;
                                                  }];
                                 
                                 
                             }];
        }
    }
}


@end
