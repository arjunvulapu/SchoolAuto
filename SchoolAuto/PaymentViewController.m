//
//  PaymentViewController.m
//  Cavaratmall
//
//  Created by Amit Kulkarni on 30/09/15.
//  Copyright © 2015 iMagicsoftware. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = Localized(@"Online Payment");
   
    //http://mamacgroup.com/gifts/Tap-app.php
    NSString *url = [NSString stringWithFormat:@"%@/%@",SERVER_URL, PAGE_PAYMENT];
   // NSString *url = [NSString stringWithFormat:@"http://trymonasabat.com/api/Tap.php"];
//    NSString *finalUrl = [NSString stringWithFormat:@"%@?member_id=%@&amount=%@&order_id=%@",
//                          url, [Utils loggedInUserIdStr], self.amount,_invoice_id];
//    NSLog(@"final url: %@", finalUrl);
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
     [self showHUD:@"Loading..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHUD];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL result = YES;
    
    NSURL *url = [request URL];
    //if ([[url host] containsString:@"cavaratmall.com"]) {
        if ([[url query] containsString:@"status=failed"]) {
            [self.navigationController popViewControllerAnimated:YES];
            if (self.completionBlock) {
                self.completionBlock(@"failed");
            }
            return YES;
        } else if ([[url query] containsString:@"status=success"]) {
            [self.navigationController popViewControllerAnimated:YES];

            if (self.completionBlock) {
                self.completionBlock(@"success");
            }
            return YES;
        }
    //}
    
    return result;
}

@end
