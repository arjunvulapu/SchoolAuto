//
//  ParentSignUpVC.m
//  SchoolAuto
//
//  Created by Apple on 09/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ParentSignUpVC.h"

@interface ParentSignUpVC ()

@end

@implementation ParentSignUpVC

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
//    [self sendingAnHTTPPOSTRequestOniOSWithUserEmailId:@"" withPassword:@""];
    if(_nameTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Name")];
    }else if(_emailAddress.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Email")];
    }else if(_phoneNumber.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter PhoneNumber")];
    }else if(_passwordTxtfield.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Password")];
    }else if(_conformPasswordTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter ConformPassword")];
    }else if(_passwordTxtfield.text!=_conformPasswordTxtField.text){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Conform Password Same")];
    }
    else{
        [self makePostCallForPageNEW:REGISTER withParams:@{@"firstname":_nameTxtField.text,@"email":_emailAddress.text,@"phone":_phoneNumber.text,@"password":_passwordTxtfield.text,@"cpassword":_passwordTxtfield.text} withRequestCode:100];
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
            
//            [Utils loginUserWithMemberId:[result valueForKey:@"member_id"] withType:@"User"];
//
//            [APP_DELEGATE afterLoginSucess];
            
        }
    }
}

-(void)sendingAnHTTPPOSTRequestOniOSWithUserEmailId: (NSString *)emailId withPassword: (NSString *)password{
    //Init the NSURLSession with a configuration
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    //Create an URLRequest
    NSURL *url = [NSURL URLWithString:@"http://projects.yellowsoft.in/schoolauto/api/parents/register.php"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    //Create POST Params and add it to HTTPBody
    NSString *params = @"cpassword=arjun117&email=arjun%40gmail.com&firstname=arjun&password=arjun117&phone=9848012345";
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Create task
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //Handle your response here
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",responseDict);
    }];
    [dataTask resume];
}
@end
