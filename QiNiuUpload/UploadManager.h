//
//  UploadManager.h
//  QiNiuUpload
//
//  Created by CF on 2017/4/13.
//  Copyright © 2017年 klone1127. All rights reserved.
//

#import <QiniuSDK.h>

@interface UploadManager : QNUploadManager

+ (id)manager;


/**
 上传至七牛

 @param data
 @param key
 @param token
 @param success
 */
- (void)uploadWithData:(NSData *)data key:(NSString *)key token:(NSString *)token success:(void (^)(QNResponseInfo *info, NSString *key))success;

@end
