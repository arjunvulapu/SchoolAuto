//
//  MainViewController.h
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSliderView.h"
#import "BaseViewController/BaseViewController.h"
#define _AUTO_SCROLL_ENABLED 1

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : BaseViewController
@property (weak, nonatomic) IBOutlet SBSliderView *slider2;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewheight;
@property (weak, nonatomic) IBOutlet UICollectionView *homemainCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *adsCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adsCollectionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderHeight;

@end

NS_ASSUME_NONNULL_END
