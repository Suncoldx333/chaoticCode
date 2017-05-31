//
//  ImageReader.m
//  JSCallOC
//
//  Created by 11111 on 2017/5/23.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import "ImageReader.h"
#import "SBJSON.h"

@implementation ImageReader

+ (instancetype)shareInstance{
    
    static ImageReader *reader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reader = [[ImageReader alloc] init];

    });
    return reader;
}

-(void)whereXCAssetsLocation{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *appPath = [[NSBundle mainBundle] bundlePath];
    [self findSubPath:appPath];
    
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    for (NSString *path in paths) {
        
        if ([fm fileExistsAtPath:path]) { //文件是否存在,当路径是以缩略形式时，无法打开
            
            BOOL isDir = NO;
            [fm fileExistsAtPath:path isDirectory:&isDir]; //是否是一个目录
            if (isDir) {
                
                NSArray<NSString *> *subPaths = [fm subpathsOfDirectoryAtPath:path error:nil];
                for (NSString *subPath in subPaths) {
                    NSLog(@"%@",subPath);
                }
            }else{
                NSLog(@"is not a Dir");
            }
        }
        
    }
    
}

-(void)runDataAna{
    NSString *teStr = @"{\"allLocJson\" : [{\"speed\":\"0\",\"id\":\"3961\",\"pointid\":\"2910\",\"radius\":\"5.000000\",\"gaintime\":\"1495023463000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"5\",\"totaldis\":\"0\",\"lat\":\"36.567896\",\"flag\":\"1495023463000\",\"avgspeed\":\"0\",\"totaltime\":\"0.000000\",\"lng\":\"116.820185\",\"locationtype\":\"0\"},{\"speed\":\"31.15\",\"id\":\"3962\",\"pointid\":\"3962\",\"radius\":\"5.000000\",\"gaintime\":\"1495023480000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"14\",\"lat\":\"36.567785\",\"flag\":\"1495023463000\",\"avgspeed\":\"0.535116\",\"totaltime\":\"16.000000\",\"lng\":\"116.820269\",\"locationtype\":\"0\"},{\"speed\":\"5.43\",\"id\":\"3963\",\"pointid\":\"3963\",\"radius\":\"5.000000\",\"gaintime\":\"1495023484000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"26\",\"lat\":\"36.567675\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.072120\",\"totaltime\":\"20.000000\",\"lng\":\"116.820261\",\"locationtype\":\"0\"},{\"speed\":\"5.06\",\"id\":\"3964\",\"pointid\":\"3964\",\"radius\":\"5.000000\",\"gaintime\":\"1495023488000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"39\",\"lat\":\"36.567557\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.295464\",\"totaltime\":\"24.000000\",\"lng\":\"116.820246\",\"locationtype\":\"0\"},{\"speed\":\"5.12\",\"id\":\"3965\",\"pointid\":\"3965\",\"radius\":\"5.000000\",\"gaintime\":\"1495023492000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"52\",\"lat\":\"36.567442\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.252538\",\"totaltime\":\"28.000000\",\"lng\":\"116.820277\",\"locationtype\":\"0\"},{\"speed\":\"4.54\",\"id\":\"3966\",\"pointid\":\"3966\",\"radius\":\"5.000000\",\"gaintime\":\"1495023495000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"63\",\"lat\":\"36.567343\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.673609\",\"totaltime\":\"31.000000\",\"lng\":\"116.820269\",\"locationtype\":\"0\"},{\"speed\":\"4.47\",\"id\":\"3967\",\"pointid\":\"3967\",\"radius\":\"5.000000\",\"gaintime\":\"1495023498000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"75\",\"lat\":\"36.567244\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.726338\",\"totaltime\":\"34.000000\",\"lng\":\"116.820246\",\"locationtype\":\"0\"},{\"speed\":\"4.07\",\"id\":\"3968\",\"pointid\":\"3968\",\"radius\":\"5.000000\",\"gaintime\":\"1495023501000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"87\",\"lat\":\"36.567133\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.096118\",\"totaltime\":\"37.000000\",\"lng\":\"116.820239\",\"locationtype\":\"0\"},{\"speed\":\"4.54\",\"id\":\"3969\",\"pointid\":\"3969\",\"radius\":\"5.000000\",\"gaintime\":\"1495023504000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"98\",\"lat\":\"36.567034\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.668264\",\"totaltime\":\"40.000000\",\"lng\":\"116.820239\",\"locationtype\":\"0\"},{\"speed\":\"5.76\",\"id\":\"3970\",\"pointid\":\"3970\",\"radius\":\"5.000000\",\"gaintime\":\"1495023510000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"115\",\"lat\":\"36.566878\",\"flag\":\"1495023463000\",\"avgspeed\":\"2.893642\",\"totaltime\":\"46.000000\",\"lng\":\"116.820231\",\"locationtype\":\"0\"},{\"speed\":\"4.07\",\"id\":\"3971\",\"pointid\":\"3971\",\"radius\":\"5.000000\",\"gaintime\":\"1495023513000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"128\",\"lat\":\"36.566767\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.099631\",\"totaltime\":\"49.000000\",\"lng\":\"116.820239\",\"locationtype\":\"0\"},{\"speed\":\"4.07\",\"id\":\"3972\",\"pointid\":\"3972\",\"radius\":\"5.000000\",\"gaintime\":\"1495023516000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"140\",\"lat\":\"36.566656\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.099623\",\"totaltime\":\"52.000000\",\"lng\":\"116.820246\",\"locationtype\":\"0\"},{\"speed\":\"4.21\",\"id\":\"3973\",\"pointid\":\"3973\",\"radius\":\"5.000000\",\"gaintime\":\"1495023519000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"152\",\"lat\":\"36.566550\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.955217\",\"totaltime\":\"55.000000\",\"lng\":\"116.820239\",\"locationtype\":\"0\"},{\"speed\":\"4.72\",\"id\":\"3974\",\"pointid\":\"3974\",\"radius\":\"5.000000\",\"gaintime\":\"1495023522000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"162\",\"lat\":\"36.566454\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.532738\",\"totaltime\":\"58.000000\",\"lng\":\"116.820231\",\"locationtype\":\"0\"},{\"speed\":\"3.92\",\"id\":\"3975\",\"pointid\":\"3975\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"175\",\"lat\":\"36.566348\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.249227\",\"totaltime\":\"60.000000\",\"lng\":\"116.820178\",\"locationtype\":\"0\"},{\"speed\":\"4.58\",\"id\":\"3976\",\"pointid\":\"3976\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"186\",\"lat\":\"36.566253\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.636254\",\"totaltime\":\"60.000000\",\"lng\":\"116.820147\",\"locationtype\":\"0\"},{\"speed\":\"4.73\",\"id\":\"3977\",\"pointid\":\"3977\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"197\",\"lat\":\"36.566157\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.527128\",\"totaltime\":\"60.000000\",\"lng\":\"116.820147\",\"locationtype\":\"0\"},{\"speed\":\"5.03\",\"id\":\"3978\",\"pointid\":\"3978\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"210\",\"lat\":\"36.566039\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.316113\",\"totaltime\":\"60.000000\",\"lng\":\"116.820124\",\"locationtype\":\"0\"},{\"speed\":\"4.22\",\"id\":\"3979\",\"pointid\":\"3979\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"222\",\"lat\":\"36.565933\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.950370\",\"totaltime\":\"60.000000\",\"lng\":\"116.820124\",\"locationtype\":\"0\"},{\"speed\":\"4.21\",\"id\":\"3980\",\"pointid\":\"3980\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"234\",\"lat\":\"36.565826\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.955137\",\"totaltime\":\"60.000000\",\"lng\":\"116.820117\",\"locationtype\":\"0\"},{\"speed\":\"4.50\",\"id\":\"3981\",\"pointid\":\"3981\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"245\",\"lat\":\"36.565727\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.700036\",\"totaltime\":\"60.000000\",\"lng\":\"116.820132\",\"locationtype\":\"0\"},{\"speed\":\"4.63\",\"id\":\"3982\",\"pointid\":\"3982\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"255\",\"lat\":\"36.565631\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.598175\",\"totaltime\":\"60.000000\",\"lng\":\"116.820155\",\"locationtype\":\"0\"},{\"speed\":\"4.38\",\"id\":\"3983\",\"pointid\":\"3983\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"267\",\"lat\":\"36.565528\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.809265\",\"totaltime\":\"61.000000\",\"lng\":\"116.820155\",\"locationtype\":\"0\"},{\"speed\":\"3.57\",\"id\":\"3984\",\"pointid\":\"3984\",\"radius\":\"5.000000\",\"gaintime\":\"1495023583000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"281\",\"lat\":\"36.565402\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.663144\",\"totaltime\":\"61.000000\",\"lng\":\"116.820163\",\"locationtype\":\"0\"},{\"speed\":\"4.02\",\"id\":\"3985\",\"pointid\":\"3985\",\"radius\":\"5.000000\",\"gaintime\":\"1495023584000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"293\",\"lat\":\"36.565292\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.142888\",\"totaltime\":\"61.000000\",\"lng\":\"116.820140\",\"locationtype\":\"0\"},{\"speed\":\"4.07\",\"id\":\"3986\",\"pointid\":\"3986\",\"radius\":\"5.000000\",\"gaintime\":\"1495023644000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"306\",\"lat\":\"36.565181\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.095955\",\"totaltime\":\"62.000000\",\"lng\":\"116.820132\",\"locationtype\":\"0\"},{\"speed\":\"4.01\",\"id\":\"3987\",\"pointid\":\"3987\",\"radius\":\"5.000000\",\"gaintime\":\"1495023644000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"318\",\"lat\":\"36.565070\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.153581\",\"totaltime\":\"62.000000\",\"lng\":\"116.820155\",\"locationtype\":\"0\"},{\"speed\":\"3.93\",\"id\":\"3988\",\"pointid\":\"3988\",\"radius\":\"10.000000\",\"gaintime\":\"1495023644000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"331\",\"lat\":\"36.564956\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.236815\",\"totaltime\":\"62.000000\",\"lng\":\"116.820148\",\"locationtype\":\"0\"},{\"speed\":\"3.79\",\"id\":\"3989\",\"pointid\":\"3989\",\"radius\":\"10.000000\",\"gaintime\":\"1495023644000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"344\",\"lat\":\"36.564838\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.400882\",\"totaltime\":\"62.000000\",\"lng\":\"116.820163\",\"locationtype\":\"0\"},{\"speed\":\"4.37\",\"id\":\"3990\",\"pointid\":\"3990\",\"radius\":\"10.000000\",\"gaintime\":\"1495023644000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"355\",\"lat\":\"36.564735\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.817847\",\"totaltime\":\"62.000000\",\"lng\":\"116.820171\",\"locationtype\":\"0\"},{\"speed\":\"3.94\",\"id\":\"3991\",\"pointid\":\"3991\",\"radius\":\"10.000000\",\"gaintime\":\"1495023644000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"368\",\"lat\":\"36.564620\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.232463\",\"totaltime\":\"62.000000\",\"lng\":\"116.820171\",\"locationtype\":\"0\"},{\"speed\":\"3.97\",\"id\":\"3992\",\"pointid\":\"3992\",\"radius\":\"10.000000\",\"gaintime\":\"1495023644000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"381\",\"lat\":\"36.564509\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.198898\",\"totaltime\":\"62.000000\",\"lng\":\"116.820202\",\"locationtype\":\"0\"},{\"speed\":\"4.46\",\"id\":\"3993\",\"pointid\":\"3993\",\"radius\":\"10.000000\",\"gaintime\":\"1495023644000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"392\",\"lat\":\"36.564410\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.736695\",\"totaltime\":\"63.000000\",\"lng\":\"116.820225\",\"locationtype\":\"0\"},{\"speed\":\"4.68\",\"id\":\"3994\",\"pointid\":\"3994\",\"radius\":\"10.000000\",\"gaintime\":\"1495023645000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"403\",\"lat\":\"36.564315\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.559971\",\"totaltime\":\"63.000000\",\"lng\":\"116.820240\",\"locationtype\":\"0\"},{\"speed\":\"4.05\",\"id\":\"3995\",\"pointid\":\"3995\",\"radius\":\"10.000000\",\"gaintime\":\"1495023645000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"415\",\"lat\":\"36.564208\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.120170\",\"totaltime\":\"63.000000\",\"lng\":\"116.820278\",\"locationtype\":\"0\"},{\"speed\":\"4.06\",\"id\":\"3996\",\"pointid\":\"3996\",\"radius\":\"10.000000\",\"gaintime\":\"1495023705000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"427\",\"lat\":\"36.564108\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.109547\",\"totaltime\":\"64.000000\",\"lng\":\"116.820339\",\"locationtype\":\"0\"},{\"speed\":\"4.19\",\"id\":\"3997\",\"pointid\":\"3997\",\"radius\":\"10.000000\",\"gaintime\":\"1495023705000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"439\",\"lat\":\"36.564020\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.980559\",\"totaltime\":\"64.000000\",\"lng\":\"116.820416\",\"locationtype\":\"0\"},{\"speed\":\"4.31\",\"id\":\"3998\",\"pointid\":\"3998\",\"radius\":\"10.000000\",\"gaintime\":\"1495023705000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"451\",\"lat\":\"36.563936\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.865589\",\"totaltime\":\"64.000000\",\"lng\":\"116.820492\",\"locationtype\":\"0\"},{\"speed\":\"3.95\",\"id\":\"3999\",\"pointid\":\"3999\",\"radius\":\"10.000000\",\"gaintime\":\"1495023705000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"463\",\"lat\":\"36.563836\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.216818\",\"totaltime\":\"64.000000\",\"lng\":\"116.820561\",\"locationtype\":\"0\"},{\"speed\":\"4.07\",\"id\":\"4000\",\"pointid\":\"4000\",\"radius\":\"10.000000\",\"gaintime\":\"1495023705000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"476\",\"lat\":\"36.563744\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.096439\",\"totaltime\":\"64.000000\",\"lng\":\"116.820638\",\"locationtype\":\"0\"},{\"speed\":\"3.78\",\"id\":\"4001\",\"pointid\":\"4001\",\"radius\":\"10.000000\",\"gaintime\":\"1495023705000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"489\",\"lat\":\"36.563656\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.411347\",\"totaltime\":\"64.000000\",\"lng\":\"116.820737\",\"locationtype\":\"0\"},{\"speed\":\"3.73\",\"id\":\"4002\",\"pointid\":\"4002\",\"radius\":\"10.000000\",\"gaintime\":\"1495023705000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"502\",\"lat\":\"36.563571\",\"flag\":\"1495023463000\",\"avgspeed\":\"4.468764\",\"totaltime\":\"65.000000\",\"lng\":\"116.820844\",\"locationtype\":\"0\"},{\"speed\":\"4.65\",\"id\":\"4003\",\"pointid\":\"4003\",\"radius\":\"10.000000\",\"gaintime\":\"1495023705000\",\"createtime\":\"\",\"modifytime\":\"\",\"type\":\"0\",\"totaldis\":\"513\",\"lat\":\"36.563502\",\"flag\":\"1495023463000\",\"avgspeed\":\"3.582169\",\"totaltime\":\"65.000000\",\"lng\":\"116.820928\",\"locationtype\":\"0\"}]}";
    
    NSMutableDictionary *teDic = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *hahDic = [[NSMutableDictionary alloc] init];
    NSMutableArray *hahArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *hahDic1 = [[NSMutableDictionary alloc] init];
    [hahDic1 setObject:@"inner" forKey:@"innerKey"];
    [hahArr addObject:hahDic1];
    [hahDic setObject:hahArr forKey:@"dickEY"];
    
    SBJSON *sb = [[SBJSON alloc] init];
    teDic = [sb objectWithString:teStr error:nil];
    
    NSString *preGainTime;
    NSString *preTotalTime;
    
    NSMutableArray *equalArr = [[NSMutableArray alloc] init];
    NSMutableArray *unEqualArr = [[NSMutableArray alloc] init];
    NSMutableArray *totalTimeArr = [[NSMutableArray alloc] init];
    NSMutableArray *gainTimeDiffArr = [[NSMutableArray alloc] init];
    NSMutableArray *totalTimeDiffArr = [[NSMutableArray alloc] init];
    NSMutableArray *AccuracyArr = [[NSMutableArray alloc] init];
    NSMutableArray *radiusArr = [[NSMutableArray alloc] init];
    
    NSMutableArray *typeAgreeArr = [[NSMutableArray alloc] init];
    
    NSMutableArray *pointTypeArr = [[NSMutableArray alloc] init];
    
    NSMutableArray *jsArr = [teDic objectForKey:@"allLocJson"];
    for (NSInteger i = 0 ; i < jsArr.count; i++) {
        NSMutableDictionary *jsDic = [jsArr objectAtIndex:i];
        
        NSString *totalTimeStr = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"totaltime"] doubleValue]];
        NSString *typeStr = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"type"] doubleValue]];
        NSString *accuracyStr = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"radius"] doubleValue]];
        NSString *redisStr = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"radius"] doubleValue]];
        [totalTimeArr addObject:totalTimeStr];
        [pointTypeArr addObject:typeStr];
        [AccuracyArr addObject:accuracyStr];
        [radiusArr addObject:redisStr];
        if (typeStr.intValue == 0) {
            [typeAgreeArr addObject:accuracyStr];
        }
        
        if (i == 0) {
            preGainTime = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"gaintime"] doubleValue]];
            preTotalTime = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"totaltime"] doubleValue]];
        }else{
            NSString *curGainTime = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"gaintime"] doubleValue]];
            NSString *curTotalTime = [NSString stringWithFormat:@"%f",[[jsDic objectForKey:@"totaltime"] doubleValue]];
            
            double gainTimeDiff = (curGainTime.doubleValue - preGainTime.doubleValue)/1000;
            double totalTimeDiff = (curTotalTime.doubleValue - preTotalTime.doubleValue)/1;
            
            [gainTimeDiffArr addObject:[NSString stringWithFormat:@"%f",gainTimeDiff]];
            [totalTimeDiffArr addObject:[NSString stringWithFormat:@"%f",totalTimeDiff]];
            
            preTotalTime = curTotalTime;
            preGainTime = curGainTime;
            
            if (gainTimeDiff == totalTimeDiff) {
                [equalArr addObject:[NSNumber numberWithInteger:i]];
            }else{
                [unEqualArr addObject:[NSNumber numberWithInteger:i]];
            }
            
            
        }
    }
    NSMutableArray *queadATA = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < equalArr.count; i++) {
        NSNumber *index = [equalArr objectAtIndex:i];
        
        if (index.integerValue > 0) {
            [queadATA addObject:[jsArr objectAtIndex:index.integerValue - 1]];
        }
        
        [queadATA addObject:[jsArr objectAtIndex:index.integerValue]];
    }
}

-(void)findSubPath:(NSString *)mainPath{
    
    NSFileManager *fm = [NSFileManager defaultManager];

    if ([fm fileExistsAtPath:mainPath]) { //文件是否存在,当路径是以缩略形式时，无法打开
        
        BOOL isDir = NO;
        [fm fileExistsAtPath:mainPath isDirectory:&isDir]; //是否是一个目录
        if (isDir) {
            
            NSArray<NSString *> *subPaths = [fm subpathsOfDirectoryAtPath:mainPath error:nil];
            for (NSString *subPath in subPaths) {
                
                if ([subPath rangeOfString:@"Assets"].location != NSNotFound) {
                    NSString *assetsPath = [NSString stringWithFormat:@"%@/%@",mainPath,subPath];
                    
                    [self carFileAna:assetsPath];
                    
//                    BOOL assets = NO;
//                    [fm fileExistsAtPath:assetsPath isDirectory:&assets];
//                    assets == YES ? NSLog(@"isDir") : NSLog(@"notDir");
                }else if ([subPath rangeOfString:@"JSCallOC"].location != NSNotFound){
                    NSString *assetsPath = [NSString stringWithFormat:@"%@/%@",mainPath,subPath];
                    
                    BOOL assets = NO;
                    [fm fileExistsAtPath:assetsPath isDirectory:&assets];
                    assets == YES ? NSLog(@"isDir") : NSLog(@"notDir");
                }
                
                NSLog(@"%@",subPath);
            }
        }else{
            NSLog(@"is not a Dir");
        }
    }
}

-(void)carFileAna:(NSString *)path{
    
    
    
}

@end
