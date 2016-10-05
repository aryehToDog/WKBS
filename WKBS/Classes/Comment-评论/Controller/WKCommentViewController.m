//
//  WKCommentViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/6.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCommentViewController.h"

@interface WKCommentViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;


@end

@implementation WKCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyboardWillChangeFrame: (NSNotification*)info {
    
    //获取键盘弹出的高度
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat keyBoardY = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    self.bottomMargin.constant = screenH - keyBoardY;
    
    
    //获取键盘弹出的时间
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
       
        [self.view layoutIfNeeded];
        
    }];

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/** 
 *    tableView 即将开始进行拖拽的时候
 */

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.view endEditing:YES];

}


@end
