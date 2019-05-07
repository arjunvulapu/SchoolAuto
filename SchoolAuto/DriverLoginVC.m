//
//  DriverLoginVC.m
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "DriverLoginVC.h"

@interface DriverLoginVC ()

@end

@implementation DriverLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
}

- (IBAction)forgotPasswordbtnAction:(id)sender {
}
@end
