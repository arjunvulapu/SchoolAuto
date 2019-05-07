//
//  DriverLoginVC.h
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DriverLoginVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitBtnAction:(id)sender;
- (IBAction)forgotPasswordbtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
