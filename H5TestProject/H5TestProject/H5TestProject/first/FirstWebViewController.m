//
//  FirstWebViewController.m
//  H5TestProject
//
//  Created by KlayThompson on 2018/6/27.
//  Copyright © 2018年 KlayThompson. All rights reserved.
//

#import "FirstWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface FirstWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)JSContext *context;

@end

@implementation FirstWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"location02.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [self.webView loadRequest: request];
    
    self.webView.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __weak typeof (self) weakSelf = self;
    self.context[@"backButtonClick"] = ^(){//不是在主线程，需要返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
