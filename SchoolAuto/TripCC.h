//
//  TripCC.h
//  SchoolAuto
//
//  Created by Apple on 14/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TripCC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgiew;
@property (weak, nonatomic) IBOutlet UILabel *kidNameLbl;
- (IBAction)driverAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *driverBtn;
@property (nonatomic) void (^driverAction)();
@end

NS_ASSUME_NONNULL_END
