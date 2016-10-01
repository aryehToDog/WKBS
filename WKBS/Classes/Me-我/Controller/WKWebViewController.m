//
//  WKWebViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/30.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKWebViewController.h"

@interface WKWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forWord;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //发送web请求
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
    
}


/** 
 *   前往
 */

- (IBAction)toForFord:(UIBarButtonItem *)sender {
    
    [self.webView goForward];
}

/**
 *   后退
 */
- (IBAction)toBack:(UIBarButtonItem *)sender {
    
    [self.webView goBack];
}

/**
 *   刷新
 */
- (IBAction)reload:(UIBarButtonItem *)sender {
    
    [self.webView reload];
}

/** 
 *  //加载完成时候才会进行点击
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    self.forWord.enabled = webView.canGoForward;
    self.back.enabled = webView.canGoBack;
    
}

@end
