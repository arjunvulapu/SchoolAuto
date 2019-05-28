//
//  ForgotPasswordVC.h
//  SchoolAuto
//
//  Created by Apple on 09/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ForgotPasswordVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *signupView;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitbtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTxtField;
@end

NS_ASSUME_NONNULL_END
