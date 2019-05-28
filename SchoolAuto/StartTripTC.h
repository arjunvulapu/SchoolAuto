//
//  StartTripTC.h
//  SchoolAuto
//
//  Created by Apple on 21/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StartTripTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
- (IBAction)startBtnAction:(id)sender;
@property(nonatomic) void (^startTrip)();
@end

NS_ASSUME_NONNULL_END
