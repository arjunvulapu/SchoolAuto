//
//  PriceTC.h
//  SchoolAuto
//
//  Created by Apple on 10/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PriceTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sharingTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *minChargeLbl;
@property (weak, nonatomic) IBOutlet UILabel *upto5kmLbl;
@property (weak, nonatomic) IBOutlet UILabel *upto6kmLbl;
@property (weak, nonatomic) IBOutlet UILabel *upto7kmLbl;

@end

NS_ASSUME_NONNULL_END
