//
//  TripInfoTC.h
//  SchoolAuto
//
//  Created by Apple on 24/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TripInfoTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tripInfoLbl;
@property (weak, nonatomic) IBOutlet UIImageView *tripImage;
@property (weak, nonatomic) IBOutlet UIView *tripBgView;
@property (weak, nonatomic) IBOutlet UILabel *createdDateInfoLbl;

@end

NS_ASSUME_NONNULL_END
