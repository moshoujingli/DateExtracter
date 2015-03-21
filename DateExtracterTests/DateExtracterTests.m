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
    
    NSData* jsonData = [fileContents dataUsingEncoding:NSUTF8StringEncoding];
    //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
    self.testContent = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",self.testContent);
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResult{
    NSArray *testContents = [self.testContent objectForKey:@"contents"];
    NSArray *locals = @[@"zh_cn",@"en_us",@"ja_jp"];
    for (NSString *local in locals) {
        NSString *contentName = [@"text_" stringByAppendingString:local];
        NSString *lanName = [local substringToIndex:2];
        BNPLanguageType lanType = [BNPDateExtracter getLanguageTypeWithName:lanName];
        for (NSDictionary *testContent in testContents) {
            NSString *content = [testContent objectForKey:contentName];
            if (content) {
                NSArray *timeExpectedDesc = [testContent objectForKey:@"time"];
                NSArray *result = [self.extracter getDateEntitiesFromString:content inLanguage:lanType];
                [self assertTimeDesc:timeExpectedDesc EqualDateEntities:result];
                
            }
        }
    }
}

-(void)assertTimeDesc:(NSArray *)desc EqualDateEntities:(NSArray *)entities{
    XCTAssertEqual([entities count], [desc count]);
    for (NSInteger i = 0; i<[entities count]; i++) {
        NSString *dateDesc = desc[i];
        NSDate *date = ((BNPDateEntity *)entities[i]).date;
        [self assertDesc:dateDesc equalToDate:date];
    }
}

-(void)assertDesc:(NSString *)desc equalToDate:(NSDate *)date{
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
