//
//  BDDiffView.h
//  JSCallOC
//
//  Created by 11111 on 2017/8/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BDDiffViewDelegate <NSObject>

-(void)tapEventFunc;

@end

@interface BDDiffView : UIView

@property (nonatomic,copy) void(^testBlock)();
@property (nonatomic,weak) id<BDDiffViewDelegate> delegate;

@end
