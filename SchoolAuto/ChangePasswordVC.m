//
//  ChangePasswordVC.m
//  SchoolAuto
//
//  Created by Apple on 09/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    _signupView.layer.cornerRadius=10.0;
//    _signupView.clipsToBounds=YES;
    
   // self.title = @"Parent Signup";
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitbtnAction:(id)sender {

    if(_phoneNumber.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter OldPassword")];
    }else if(_passwordTxtfield.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter NewPassword")];
    }else if(_conformPasswordTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter ConformPassword")];
    }else if(_passwordTxtfield.text!=_conformPasswordTxtField.text){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Conform Password Same")];
    }
    else{
        [self makePostCallForPageNEW:CHANGE_PASSWORD withParams:@{@"parent_id":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]],@"old_password":_phoneNumber.text,@"new_password":_passwordTxtfield.text,@"confirm_password":_passwordTxtfield.text} withRequestCode:100];
    }
}

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
     if (reqeustCode == 100) {
        if ([[result valueForKey:@"status"] isEqual:@0]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            NSString *str=[result valueForKey:@"message"];
//            [self showSuccessMessage:str];
            [Utils showAlertWithMessage:[MCLocalization stringForKey:str]];
            [self.navigationController popViewControllerAnimated:YES];
        
        }
    }
}


@end
