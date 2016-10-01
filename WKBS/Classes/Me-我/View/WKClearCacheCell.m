//
//  WKClearCacheCell.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/1.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKClearCacheCell.h"
#import <SVProgressHUD.h>
#import <SDImageCache.h>
@implementation WKClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        
        self.accessoryView = loadingView;
        
        self.textLabel.text = @"清除缓存(正在计算中...)";
        
        //禁止进行点击
        self.userInteractionEnabled = NO;
        
        __weak typeof(self) weakSelf = self;
        
        //计算文件大小
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            //获取缓存文件的路径
            unsigned long long size = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"custom"].fileSzie;
            
            size += [SDImageCache sharedImageCache].getSize;
            
            //如果cell被销毁直接返回
            if (weakSelf == nil) {
                return ;
            }
            
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            //生成文字
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            
            //回到主线程进行刷新
            dispatch_async(dispatch_get_main_queue(), ^{
               
                weakSelf.textLabel.text = text;
                
                weakSelf.accessoryView = nil;
                
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                //添加一个手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:weakSelf action:@selector(clearCache)];
                
                [weakSelf addGestureRecognizer:tap];
                
                //回复用户交互
                weakSelf.userInteractionEnabled = YES;
                
            });
        });
        
    }

    
    return self;
}


- (void)clearCache {

    [SVProgressHUD showWithStatus:@"正在清除缓存" maskType:SVProgressHUDMaskTypeBlack];
    
    //清除SDWebIMage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
       
        //清除自定义的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            NSFileManager *mgr = [NSFileManager defaultManager];
            [mgr removeItemAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"custom"] error:nil];
            
            //删除所在文件夹会重新创建一个文件夹
            [mgr createDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"custom"] withIntermediateDirectories:YES attributes:nil error:nil];
            
            
            //回到主线程重新刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
               
                //隐藏指示器
                [SVProgressHUD dismiss];
                
                self.textLabel.text = @"清除缓存(0B)";
                
            });
            
            
        });
        
    }];
    

}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //防止指示器不会刷新
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];

}


@end
