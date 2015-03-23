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
@property (strong,nonatomic)NSDateComponents *now;
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
    
    NSString *pattern = @"(\\+\\d{1,2}[a-zA-Z]{1})+";
    self.now =  [[NSCalendar currentCalendar ]components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate date]];
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
        NSLog(@"%@",[NSDate date]);
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
//    XCTAssertEqual([entities count], [desc count]);
    for (NSInteger i = 0; i<[desc count]; i++) {
        NSString *dateDesc = desc[i];
        NSLog(@"%@ , %@",dateDesc,[self getDateFromDesc:dateDesc]);

//        NSDate *date = ((BNPDateEntity *)entities[i]).date;
//        [self assertDesc:dateDesc equalToDate:date];
    }
}

-(void)assertDesc:(NSString *)desc equalToDate:(NSDate *)date{
    
    
    XCTAssertEqualObjects([self getDateFromDesc:desc], date);
}

-(NSDate *)getDateFromDesc:(NSString *)desc{
    NSArray *matches =  [desc componentsSeparatedByString:@";"];
    NSDateComponents *dateComponents = [self.now copy];
    NSDateComponents *plusComponents = [[NSDateComponents alloc]init];

    for (NSString *timeUnit in matches) {
        NSInteger timeValue = [[timeUnit substringToIndex:timeUnit.length-1]integerValue];
        
        
        switch ([timeUnit characterAtIndex: timeUnit.length-1 ]) {
            case 'y':
                timeValue?[plusComponents setYear:timeValue]:(dateComponents.year = 0);
                //if set a larger time unit , the subunit should need set to 0
                dateComponents.month = 0;
                break;
            case 'M':
                timeValue?[plusComponents setMonth:timeValue]:(dateComponents.month = 0);
                dateComponents.day = 0;
                break;
            case 'D': //day of month
                timeValue?[plusComponents setDay:timeValue]:(dateComponents.day = 0);
                dateComponents.hour = 0;
                break;
            case 'w':
                timeValue?[plusComponents setWeekOfYear:timeValue]:(dateComponents.weekOfYear = 0);
                dateComponents.weekday=0;
                break;
            case 'd': //day of week
                timeValue?[plusComponents setWeekday:timeValue]:(dateComponents.weekday = 0);
                dateComponents.hour = 0;
                break;
            case 'h':
                timeValue?[plusComponents setHour:timeValue]:(dateComponents.hour = 0);
                dateComponents.minute = 0;
                break;
            case 'm':
                timeValue?[plusComponents setMinute:timeValue]:(dateComponents.minute = 0);
                break;
            default:
                break;
        }
        
    }
    NSLog(@"%@",plusComponents);
    return [[NSCalendar currentCalendar]dateByAddingComponents:plusComponents toDate:[[NSCalendar currentCalendar]dateFromComponents:dateComponents] options:0];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
