//
//  TrackListVC.h
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController/BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TrackListVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegment;
- (IBAction)statusSegmentAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *emptyLbl;

@end

NS_ASSUME_NONNULL_END
