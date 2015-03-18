//
//  BNPDateExtracter.m
//  DateExtracter
//
//  Created by BiXiaopeng on 15/3/16.
//  Copyright (c) 2015年 BiXiaopeng. All rights reserved.
//

#import "BNPDateExtracter.h"

@implementation BNPDateExtracter

+(BNPLanguageType)getSystemLanguageType{
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"%@",currentLanguage);
    if ([currentLanguage isEqualToString:@"ja"]) {
        return BNPLanguageTypeJA_JP;
    }
    if ([currentLanguage isEqualToString:@"en"]) {
        return BNPLanguageTypeEN_US;
    }
    if ([currentLanguage isEqualToString:@"zh"]) {
        return BNPLanguageTypeZH_CN;
    }
    return BNPLanguageTypeEN_US;
}

@end
