//
//  NSString+QiNiu.m
//  QiNiuUpload
//
//  Created by jgrm on 2017/4/13.
//  Copyright © 2017年 klone1127. All rights reserved.
//

#import "NSString+QiNiu.h"
#import <QiniuSDK.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (QiNiu)

+ (NSString *)getQiNiuToken:(NSString *)accessKey secretKey:(NSString *)secret bucketName:(NSString *)bucketName deadline:(CGFloat)hour {
    if (!hour) {
        hour = 1;
    }
    
    NSDictionary *jsonDic = @{@"scope":bucketName,@"deadline":[NSNumber numberWithInteger:[self deadLine:hour].integerValue]};
    NSString *jsonString = [self generationJsonString:jsonDic];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64 = [QNUrlSafeBase64 encodeData:jsonData];
    //    NSString *hmacSHA1 = [secret hmacSHA1StringWithKey:base64];
    NSString *hmacSHA1 = [self hmacSha1Key:secret textData:base64];
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@", accessKey, hmacSHA1, base64];
    return token;
    
}

+ (NSString *)generationJsonString:(NSDictionary *)jsonDic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"generation json error:%@", error);
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)hmacSha1Key:(NSString*)key textData:(NSString*)text {
    const char *cData  = [text cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [QNUrlSafeBase64 encodeData:HMAC];
    return hash;
}

/**
 token 有效时间
 
 @param hour 小时
 @return
 */
+ (NSString *)deadLine:(CGFloat)hour {
    CGFloat seconds = hour * 3600;
    
    NSDate *addedSeconds = [[NSDate getCurrentTime] dateByAddingTimeInterval:seconds];
    
    return [NSString stringWithFormat:@"%.f", addedSeconds.timeIntervalSince1970];
    
    //    NSDate *date = [NSDate dateWithTimeInterval:seconds sinceDate:[NSDate date]];
    //    return [NSString stringWithFormat:@"%.f", [date timeIntervalSince1970]];
}


@end
