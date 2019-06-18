//
//  MyProfileVC.m
//  SchoolAuto
//
//  Created by Apple on 08/06/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MyProfileVC.h"

@interface MyProfileVC ()
{
    NSMutableDictionary *userDic;
}
@end

@implementation MyProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [currentDefaults objectForKey:@"USERINFO"];
    userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"%@",userDic);
    
    _nameLbl.text=[NSString stringWithFormat:@"%@",[userDic valueForKey:@"pa_firstname"]];
    _emailLbl.text=[NSString stringWithFormat:@"%@",[userDic valueForKey:@"pa_email"]];
    _phoneLbl.text=[NSString stringWithFormat:@"%@",[userDic valueForKey:@"pa_phone"]];
    
    
    _nameView.layer.cornerRadius=10.0;
    _nameView.clipsToBounds=YES;
    _emailView.layer.cornerRadius=10.0;
    _emailView.clipsToBounds=YES;
    _phoneView.layer.cornerRadius=10.0;
    _phoneView.clipsToBounds=YES;
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
