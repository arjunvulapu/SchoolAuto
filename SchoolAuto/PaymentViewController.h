//
//  PaymentViewController.h
//  Cavaratmall
//
//  Created by Amit Kulkarni on 30/09/15.
//  Copyright © 2015 iMagicsoftware. All rights reserved.
//

#import "BaseViewController.h"
#import "Common.h"


@interface PaymentViewController : BaseViewController <UIWebViewDelegate>
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *invoice_id;


@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, copy) void (^completionBlock)(NSString *status);

@end
