//
//  HomeViewController.h
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *parentbtn;
@property (weak, nonatomic) IBOutlet UIButton *driverBtn;
- (IBAction)parentBtnAction:(id)sender;
- (IBAction)driverbtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *lunchBoxBtn;
- (IBAction)lunchboxBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *poweredBtn;
- (IBAction)poweredbyBtnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
