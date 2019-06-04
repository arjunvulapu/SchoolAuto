//
//  DriverLoginVC.m
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "DriverLoginVC.h"

@interface DriverLoginVC ()
{
    NSString *selectedType;
}
@end

@implementation DriverLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectedType = @"";
    self.title = @"Driver Login";
  
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
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    [defaults setObject:nil forKey:@"USERINFO"];
//    [defaults synchronize];
//    
//    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]:@"";
//    NSString *playerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]:@"";
//    [self makePostCallForPageNEW:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"dev_type":@"ios",@"type":@"",@"member_id":[Utils loggedInUserIdStr]} withRequestCode:1001];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitBtnAction:(id)sender {
    if(_emialTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Email")];
    }else if(_passwordTxtField.text.length == 0){
        [self showErrorAlertWithMessage:Localized(@"Please Enter Password")];
    }else if(selectedType.length==0){
        [self showErrorAlertWithMessage:Localized(@"Please Select LoginType")];
    }

    else{
        [self makePostCallForPageNEW:AUTOLOGIN withParams:@{@"phone":_emialTxtField.text,@"password":_passwordTxtField.text,@"entity":selectedType} withRequestCode:110];
    }
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"%@",result);
    
    if (reqeustCode == 110) {
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
            
            if([[[result valueForKey:@"data"] valueForKey:@"entity"]  isEqual: @"carriages"]){
                [Utils loginUserWithMemberId:[[result valueForKey:@"data"] valueForKey:@"auto_id"] withType:@"Lunchbox"];
            }else{
            [Utils loginUserWithMemberId:[[result valueForKey:@"data"] valueForKey:@"auto_id"] withType:@"Driver"];
            }
            
            NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]:@"";
            NSString *playerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]:@"";
            if([[[result valueForKey:@"data"] valueForKey:@"entity"]  isEqual: @"carriages"]){

                [self makePostCallForPageNEW:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"dev_type":@"ios",@"type":@"lunchbox",@"member_id":[Utils loggedInUserIdStr]}
                         withRequestCode:1001];
            }else{
                [self makePostCallForPageNEW:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"dev_type":@"ios",@"type":@"driver",@"member_id":[Utils loggedInUserIdStr]}
                             withRequestCode:1001];
            }
            [APP_DELEGATE afterDriverLoginSucess];
            
        }
    }else if(reqeustCode==1001){
        NSLog(@"Push Register%@",result);
    }
}
- (IBAction)forgotPasswordbtnAction:(id)sender {
}
- (IBAction)driverradioBtnAction:(id)sender {
    selectedType = @"kids";
    [_lunchboxRadioBtn setImage:[UIImage imageNamed:@"radio-off"] forState:UIControlStateNormal];
    [_driverRadiobtn setImage:[UIImage imageNamed:@"radio-on"] forState:UIControlStateNormal];

}
- (IBAction)lunchboxRadioBtnAction:(id)sender {
    selectedType = @"carriages";
    [_lunchboxRadioBtn setImage:[UIImage imageNamed:@"radio-on"] forState:UIControlStateNormal];
    [_driverRadiobtn setImage:[UIImage imageNamed:@"radio-off"] forState:UIControlStateNormal];


}
@end
