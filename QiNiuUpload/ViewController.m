//
//  ViewController.m
//  QiNiuUpload
//
//  Created by jgrm on 2017/4/13.
//  Copyright © 2017年 klone1127. All rights reserved.
//

#import "ViewController.h"
#import "UploadManager.h"

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

    NSData *data = [self imageToData:imageName];

    __weak typeof(self)weakSelf = self;
    [[UploadManager manager] uploadWithData:data key:imageName token:token success:^(QNResponseInfo *info, NSString *key) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf showUploadSuccess:[NSString stringWithFormat:@"%@/%@", info.serverIp, key]];
    }];
 
}

- (NSData *)imageToData:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"/Users/jgrm/Desktop/%@.png", imageName]];
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];
    return data;
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
