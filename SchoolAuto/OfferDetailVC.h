//
//  OfferDetailVC.h
//  SchoolAuto
//
//  Created by Apple on 18/06/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface OfferDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *offerImage;
@property (strong, nonatomic) NSDictionary *offerDetials;
@end

NS_ASSUME_NONNULL_END
