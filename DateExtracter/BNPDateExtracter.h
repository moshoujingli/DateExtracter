//
//  BNPDateExtracter.h
//  DateExtracter
//
//  Created by BiXiaopeng on 15/3/16.
//  Copyright (c) 2015年 BiXiaopeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNPDateEntity.h"
#define BNPLanguageTypeDF_DF BNPLanguageTypeEN_US

typedef NS_ENUM(NSInteger, BNPLanguageType) {
    BNPLanguageTypeALL = 0,
    BNPLanguageTypeEN_US,
    BNPLanguageTypeJA_JP,
    BNPLanguageTypeZH_CN
};

@interface BNPDateExtracter : NSObject

//alloc tree for all lan
-(instancetype)init;
//alloc tree for certain lan
-(instancetype)initWithLanguage:(BNPLanguageType)lan;

+(BNPLanguageType)getSystemLanguageType;
+(BNPLanguageType)getLanguageTypeWithName:(NSString *)local;
+(BNPLanguageType)guessLanguageTypeFromString:(NSString*)content;

//use default language
-(NSArray *)getDateEntitiesFromString:(NSString *)content;
-(NSArray *)getDateEntitiesFromString:(NSString *)content inLanguage:(BNPLanguageType)lang;

@end
