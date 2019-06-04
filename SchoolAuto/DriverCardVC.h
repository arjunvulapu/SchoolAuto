//
//  DriverCardVC.h
//  SchoolAuto
//
//  Created by Apple on 07/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BaseViewController/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface DriverCardVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *driverImage;
@property (weak, nonatomic) IBOutlet UILabel *autoId;
@property (weak, nonatomic) IBOutlet UILabel *driverName;
@property (weak, nonatomic) IBOutlet UILabel *driverPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *driverEmail;
@property (weak, nonatomic) IBOutlet UILabel *driverAddress;
@property (weak, nonatomic) IBOutlet UIView *driverView;
@property (weak, nonatomic) IBOutlet UILabel *childrenStatusLbl;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
@property (weak, nonatomic) IBOutlet UIImageView *manImage;
@property (weak, nonatomic) IBOutlet UIView *driverImageBg;
@property (weak, nonatomic) IBOutlet UILabel *headingLbl;

@property(strong,nonatomic)NSDictionary *resultDic;
@end

NS_ASSUME_NONNULL_END
