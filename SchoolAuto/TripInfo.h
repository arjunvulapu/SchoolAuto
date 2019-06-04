//
//  TripInfo.h
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TripInfo : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImage;
@property (weak, nonatomic) IBOutlet UIButton *addNewBtn;
- (IBAction)addNewBtnAction:(id)sender;
@property(weak,nonatomic) NSString *student_id;
@property(weak,nonatomic) NSString *from;
@property (weak, nonatomic) IBOutlet UILabel *emptyLbl;

@end

NS_ASSUME_NONNULL_END
