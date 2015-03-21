//
//  DateExtracterTests.m
//  DateExtracterTests
//
//  Created by BiXiaopeng on 15/3/16.
//  Copyright (c) 2015年 BiXiaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BNPDateExtracter.h"

@interface DateExtracterTests : XCTestCase
@property (strong,nonatomic)BNPDateExtracter *extracter;
@property (strong,nonatomic)NSDictionary *testContent;
@end

@implementation DateExtracterTests



- (void)setUp {
    [super setUp];
    self.extracter = [[BNPDateExtracter alloc]init];
    
    NSString *filepath = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"TestContent.json"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file%@: %@",filepath, error.localizedDescription);
    
    NSLog(@"contents: %@", fileContents);
    
    NSData* jsonData = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
    self.testContent = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",self.testContent);
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    
    
    NSArray *singleResult = [self.extracter getDateEntitiesFromString:@"下周一晚上七点面谈"];
    XCTAssertEqual([singleResult count], 1);
    
    NSArray *periodResult = [self.extracter getDateEntitiesFromString:@"周末回国"];
    XCTAssertEqual([periodResult count], 2);

    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
