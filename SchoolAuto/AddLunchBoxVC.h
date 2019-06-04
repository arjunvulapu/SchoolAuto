//
//  AddLunchBoxVC.h
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
#import <MapKit/MapKit.h>
#import "SZTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddLunchBoxVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *NameTxtField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *kidNameTxtField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *ageTxtField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *classTxtField;
@property (weak, nonatomic) IBOutlet UIButton *classBtn;
- (IBAction)classBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *selectSchoolTxtField;
@property (weak, nonatomic) IBOutlet UIButton *schoolbtn;
- (IBAction)schoolbtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *selectPkgTxtField;
@property (weak, nonatomic) IBOutlet UIButton *selectPkgBtn;
- (IBAction)selectPkgBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *enterAddressTxtField;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIView *paymentView;
- (IBAction)paynowBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *paynowBtn;

@property (weak, nonatomic) IBOutlet SZTextView *enterAddressTxtView;
@property (weak, nonatomic) IBOutlet UILabel *latLbl;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *selectdurationTxtField;
@property (weak, nonatomic) IBOutlet UILabel *logLbl;
@property (weak, nonatomic) IBOutlet UIButton *durationBtn;
- (IBAction)durationBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *selectTripTypeTxtField;
@property (weak, nonatomic) IBOutlet UIButton *tripBtn;
- (IBAction)tripBtnAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
