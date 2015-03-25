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
    return [self getDateEntitiesFromString:content inLanguage:([BNPDateExtracter getSystemLanguageType])];
}
-(NSArray *)getDateEntitiesFromString:(NSString *)content inLanguage:(BNPLanguageType)lang{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSString *filtedContent = [self getFiltedContent:content InLanguage:lang];
    NSArray *pieces = [self getDatePiecesInContent:filtedContent];
    NSString *timePhrase;
    if (pieces.count==0) {
        return nil;
    }else{
        timePhrase = [self judgeMultiDatePieces:pieces inLanguage:lang];
    }
    return [self getDateEntitiesFromTimePhrase:timePhrase inLanguage:lang];
}
-(NSArray *)getDateEntitiesFromTimePhrase:(NSString *)phrase inLanguage:(BNPLanguageType)lang{
    
    return nil;
}

-(NSString *)getDelimitWordInLanguage:(BNPLanguageType)lang{
    return nil;
}


-(NSString *)getFiltedContent:(NSString *)content  InLanguage:(BNPLanguageType)lang{
    return content;
}
// currently only 1
-(NSArray *)getDatePiecesInContent:(NSString *)content{
    NSMutableArray *result = [[NSMutableArray alloc]initWithCapacity:1];
    [self initPointer];
    for (int i=0; i<content.length; i++) {
        NSString *c = [content substringWithRange:NSMakeRange(i, 1)];
        if (![self acceptable:c] && [self currentPhrase].length>0) {
            [result addObject:[self currentPhrase]];
        }
    }
    return result;
}
-(NSString *)judgeMultiDatePieces:(NSArray*)pieces inLanguage:(BNPLanguageType)lang{
    if (pieces.count == 1) {
        return pieces[0];
    }else{
        switch (lang) {
            case BNPLanguageTypeJA_JP:
            case BNPLanguageTypeZH_CN:
                return pieces[0];
            default:
                return pieces[pieces.count-1];
                break;
        }
    }
}


-(void)initPointer{
    
}
-(BOOL)acceptable:(NSString *)c{
    return false;
}
-(NSString *)currentPhrase{
    return nil;
}


@end
