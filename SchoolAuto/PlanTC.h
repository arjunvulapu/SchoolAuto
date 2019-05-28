//
//  PlanTC.h
//  SchoolAuto
//
//  Created by Apple on 10/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlanTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *durationLbl;
@property (weak, nonatomic) IBOutlet UILabel *snoLbl;
@property (weak, nonatomic) IBOutlet UILabel *discountlbl;

@end

NS_ASSUME_NONNULL_END
