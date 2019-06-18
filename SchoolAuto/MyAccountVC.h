//
//  MyAccountVC.h
//  SchoolAuto
//
//  Created by Apple on 14/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyAccountVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@end

NS_ASSUME_NONNULL_END
