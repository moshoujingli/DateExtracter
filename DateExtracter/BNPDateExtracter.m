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
    return [BNPDateExtracter getLanguageTypeWithName:currentLanguage];
}

+(BNPLanguageType)getLanguageTypeWithName:(NSString *)local{
    if ([local isEqualToString:@"ja"]) {
        return BNPLanguageTypeJA_JP;
    }
    if ([local isEqualToString:@"en"]) {
        return BNPLanguageTypeEN_US;
    }
    if ([local isEqualToString:@"zh"]) {
        return BNPLanguageTypeZH_CN;
    }
    return BNPLanguageTypeDF_DF;
}

-(NSArray *)getDateEntitiesFromString:(NSString *)content{
    return nil;
}
-(NSArray *)getDateEntitiesFromString:(NSString *)content inLanguage:(BNPLanguageType)lang{
    return nil;
}

@end
