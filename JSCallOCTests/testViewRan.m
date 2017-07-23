//
//  testViewRan.m
//  JSCallOC
//
//  Created by 11111 on 2017/7/20.
//  Copyright © 2017年 wangdan. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "teView.h"
#import "teView+UnitTest.h"

@interface testViewRan : XCTestCase

@property (nonatomic,strong) teView *teRan;

@end

@implementation testViewRan

- (void)setUp {
    [super setUp];
    self.teRan = [[teView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testMakeRandomFunc{
    NSInteger ranInteger = [self.teRan makeRandom];
    NSLog(@"ran = %ld",(long)ranInteger);
    XCTAssert(ranInteger < 10);
}

@end
