//
//  SubScriptionList.h
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubScriptionList : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImage;
@property (weak, nonatomic) IBOutlet UIButton *addNewBtn;
- (IBAction)addNewBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *subSegement;
- (IBAction)subSegmentAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addChildBtn;
- (IBAction)addchildBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addLunchBoxBtn;
- (IBAction)addLunchBoxBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *emptyLbl;

@end

NS_ASSUME_NONNULL_END
