//
//  ForgotPasswordVC.m
//  SchoolAuto
//
//  Created by Apple on 09/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ForgotPasswordVC.h"

@interface ForgotPasswordVC ()

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.title = @"Forgot Password";
    
    // border radius
    [_signupView.layer setCornerRadius:20.0f];
    
    // border
    //    [_loginView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //    [_loginView.layer setBorderWidth:1.5f];
    
    // drop shadow
    [_signupView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_signupView.layer setShadowOpacity:0.2];
    [_signupView.layer setShadowRadius:5.0];
    [_signupView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    _submitBtn.layer.cornerRadius=10.0;
    _submitBtn.clipsToBounds=YES;
}
- (IBAction)submitbtnAction:(id)sender {
    
   
    
    if(_emailTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Email")];
    }
    else{
        [self makePostCallForPageNEW:FORGOTPASSWORD withParams:@{@"email":_emailTxtField.text} withRequestCode:109];
    }
}

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
    if (reqeustCode == 109) {
        if ([[result valueForKey:@"status"] isEqual:@0]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
            NSString *str=[result valueForKey:@"message"];
            [self showSuccessMessage:Localized(str)];
            
        }
    }
}
@end
