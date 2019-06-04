//
//  TrackVC.h
//  SchoolAuto
//
//  Created by Apple on 07/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BaseViewController/BaseViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrackVC : BaseViewController
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
@property (weak, nonatomic) IBOutlet UIView *imgBgView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView2;

@property(strong,nonatomic)NSDictionary *resultDic;

@property (strong, nonatomic) IBOutlet UIView *locationFullScreen;
@property (weak, nonatomic) IBOutlet UIButton *fullscreenBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
- (IBAction)closeBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imagesViewBtn;
- (IBAction)imagesViewBtnAction:(id)sender;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;

@end

NS_ASSUME_NONNULL_END
