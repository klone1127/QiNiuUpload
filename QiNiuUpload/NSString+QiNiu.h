//
//  NSString+QiNiu.h
//  QiNiuUpload
//
//  Created by jgrm on 2017/4/13.
//  Copyright © 2017年 klone1127. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (QiNiu)


/**
 生成七牛 Token

 @param accessKey
 @param secret
 @param bucketName 空间名
 @param hour 过期时间
 @return Token (单位小时，默认为1小时)
 */
+ (NSString *)getQiNiuToken:(NSString *)accessKey secretKey:(NSString *)secret bucketName:(NSString *)bucketName deadline:(CGFloat)hour;

@end
