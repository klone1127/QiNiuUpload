//
//  ViewController.m
//  QiNiuUpload
//
//  Created by jgrm on 2017/4/13.
//  Copyright © 2017年 klone1127. All rights reserved.
//

#import "ViewController.h"
#import <QiniuSDK.h>
#import <CommonCrypto/CommonCrypto.h>

#define kToken      @"DoBVQEyHluJ27PPgPBIfp93HvfkloUSBc9aEBc9I:HilyAVJZbJUdZ6Bk97RBzlOenag=:eyJzY29wZSI6ImJsb2ciLCJkZWFkbGluZSI6MTQ5MjA3MjEwN30="

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.

    NSString *accessKey = @"DoBVQEyHluJ27PPgPBIfp93HvfkloUSBc9aEBc9I";
    NSString *secret = @"";
    NSString *bucketName = @"blog";
    NSString *token = [NSString getQiNiuToken:accessKey secretKey:secret bucketName:bucketName deadline:1];
    NSLog(@"--------------------------------");
    NSLog(@"token:%@", token);
    [self uploadWithToken:token];
    
}

- (void)uploadWithToken:(NSString *)token {
    NSString *imageName = @"Nav-busline-detail1";

    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNZone zone2];
    }];

    QNUploadManager *uploadManager = [[QNUploadManager alloc] initWithConfiguration:config];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"/Users/jgrm/Desktop/%@.png", imageName]];
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];

    [uploadManager putData:data
                       key:imageName
                     token:token
                  complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      NSLog(@"info:%@", info);
                      if (info.ok) {
                          [self showUploadSuccess:[NSString stringWithFormat:@"%@/%@", info.serverIp, key]];
                      }
                  } option:nil];
}

- (void)showUploadSuccess:(NSString *)string {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"上传成功" message:string preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertView animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            exit(0);
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
