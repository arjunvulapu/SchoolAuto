//
//  TripVC.h
//  SchoolAuto
//
//  Created by Apple on 14/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
#import <MapKit/MapKit.h>
#import "SZTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface TripVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *kidsTableView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tripSegment;
@property (strong,nonatomic) NSDictionary *tripDict;
- (IBAction)tripSegementAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *caprtureView;
@property (weak, nonatomic) IBOutlet UIImageView *captureImage;
@property (weak, nonatomic) IBOutlet UIButton *captureBtn;
- (IBAction)captureBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet SZTextView *commnetView;
@property (weak, nonatomic) IBOutlet UIImageView *user_image;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitbtnAction:(id)sender;
@property (strong, nonatomic)  UIImagePickerController *userPicker;
@property (weak, nonatomic) IBOutlet UIImageView *imagePlaceHolder;
@property (weak, nonatomic) IBOutlet UIButton *addMessageBtn;
- (IBAction)addMessageBtnAction:(id)sender;
- (IBAction)endBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *endTripBtn;
@property (weak, nonatomic) IBOutlet UIButton *tripInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectCommentBtn;
- (IBAction)selectCommentBtnAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
