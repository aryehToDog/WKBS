//
//  WKSeeBigViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/5.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKSeeBigViewController.h"
#import "WKTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface WKSeeBigViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation WKSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    scrollView.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [scrollView addSubview:imageView];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) {
            return ;
        }
        
        self.saveBtn.enabled = YES;
    }];
    
    
    //设置imageview的frame
    imageView.wk_x = 0;
    imageView.wk_width = scrollView.wk_width;
    imageView.wk_height = imageView.wk_width * self.topic.height / self.topic.width;
    
    if (imageView.wk_height >= scrollView.wk_height) {
        //显示全屏图
        imageView.wk_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.wk_height);
    } else {
        //居中显示
        imageView.wk_centerY = scrollView.wk_height * 0.5;
    
    }
    self.imageView = imageView;
    
    //设置缩放比例
    CGFloat scale = self.topic.width / imageView.wk_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}


//返回
- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//保存图片到相册
- (IBAction)save {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }

}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
@end
