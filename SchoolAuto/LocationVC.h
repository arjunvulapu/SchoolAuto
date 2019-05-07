//
//  LocationVC.h
//  SchoolAuto
//
//  Created by Apple on 06/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LocationVC : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *locationMapView;

@end

NS_ASSUME_NONNULL_END
