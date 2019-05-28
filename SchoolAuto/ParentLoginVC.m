//
//  ParentLoginVC.m
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ParentLoginVC.h"
#import "Common.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Utils.h"
#import "PECropViewController.h"
#import <ImageIO/ImageIO.h>
#import <CoreLocation/CoreLocation.h>
#import "TrackVC.h"
#import "ForgotPasswordVC.h"
#import "ParentSignUpVC.h"
@interface ParentLoginVC ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *placemark;
}
@end

@implementation ParentLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

  //  self.title = @"Parent Login";
  
    // border radius
    [_loginView.layer setCornerRadius:20.0f];
    
    // border
//    [_loginView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [_loginView.layer setBorderWidth:1.5f];
    
    // drop shadow
    [_loginView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_loginView.layer setShadowOpacity:0.2];
    [_loginView.layer setShadowRadius:5.0];
    [_loginView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];

    _submitBtn.layer.cornerRadius=10;
    _submitBtn.clipsToBounds=YES;
    
    
    _signupBtn.layer.cornerRadius=10;
    _signupBtn.clipsToBounds=YES;

    
  
}


- (IBAction)submitBtnAction:(id)sender {
//    TrackVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TrackVC"];
//    [self PushToVc:vc];
    
    if(_emialTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Email")];
    }else if(_passwordTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Password")];
    }
    else{
        [self makePostCallForPageNEW:LOGIN withParams:@{@"email":_emialTxtField.text,@"password":_passwordTxtField.text} withRequestCode:100];
    }
}


- (IBAction)signupBtnAction:(id)sender {
   // [self imageSelection:sender];\
    
    ParentSignUpVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ParentSignUpVC"];
    [self PushToVc:vc];
}



-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
    if (reqeustCode == 100) {
        if ([[result valueForKey:@"status"] isEqual:@0]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            NSString *str=[result valueForKey:@"message"];
            [self showSuccessMessage:str];
//            [self.navigationController popViewControllerAnimated:YES];
            
            
            NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[result valueForKey:@"data"]];
            [currentDefaults setObject:data forKey:@"USERINFO"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
                        [Utils loginUserWithMemberId:[[result valueForKey:@"data"] valueForKey:@"pa_id"] withType:@"User"];
            

                        [APP_DELEGATE afterLoginSucess];
            
        }
    }
}

- (IBAction)forgotPasswordbtnAction:(id)sender {
    ForgotPasswordVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    [self PushToVc:vc];
}
@end
