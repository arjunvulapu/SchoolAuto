//
//  LunchBoxSucessVC.h
//  SchoolAuto
//
//  Created by Apple on 15/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LunchBoxSucessVC : BaseViewController
@property(strong,nonatomic) NSDictionary *subResult;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIView *amountView;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stableHeight;

@end

NS_ASSUME_NONNULL_END
