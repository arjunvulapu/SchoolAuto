//
//  TarrifsVC.h
//  SchoolAuto
//
//  Created by Apple on 10/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TarrifsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *pricesTableView;
@property (weak, nonatomic) IBOutlet UITableView *plansTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceTableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *planTableViewheight;
@property (weak, nonatomic) IBOutlet UICollectionView *adsCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adsCollectionViewHeight;

@end

NS_ASSUME_NONNULL_END
