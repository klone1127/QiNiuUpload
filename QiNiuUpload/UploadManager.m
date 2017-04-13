//
//  UploadManager.m
//  QiNiuUpload
//
//  Created by CF on 2017/4/13.
//  Copyright © 2017年 klone1127. All rights reserved.
//

#import "UploadManager.h"

@implementation UploadManager

+ (UploadManager *)manager {
    static UploadManager *uploadManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        uploadManager = [[self alloc] initWithConfiguration:[self config]];
    });
    return uploadManager;
}

+ (QNConfiguration *)config {
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNZone zone2];
    }];
    return config;
}

- (void)uploadWithData:(NSData *)data key:(NSString *)key token:(NSString *)token success:(void (^)(QNResponseInfo *info, NSString *key))success {
    [self putData:data
                       key:key
                     token:token
                  complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      NSLog(@"info:%@", info);
                      if (info.ok) {
                          success(info, key);
                      }
                  } option:nil];
}

@end
