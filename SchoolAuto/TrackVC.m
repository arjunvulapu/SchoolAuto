//
//  TrackVC.m
//  SchoolAuto
//
//  Created by Apple on 07/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TrackVC.h"
#import "MapAnnotation.h"
#import "AnnotationView.h"
#import "SDImageCache.h"
#import "MWCommon.h"
#import "MWPhotoBrowser.h"

@interface TrackVC ()<MWPhotoBrowserDelegate>
{
    CLLocationCoordinate2D annotationViewCoordinate ;
    CLLocationCoordinate2D autoCoordinate ;
    MKPointAnnotation *annotation2;
    MKPointAnnotation *annotation1;

    NSMutableDictionary *auto_info;
    CLLocationCoordinate2D oldautoCoordinate ;

    UIVisualEffectView *blurEffectView;
    NSMutableArray *photos ;
    NSMutableArray *thumbs ;

    
    BOOL zoomed;
}
@property (strong, nonatomic) MKPlacemark *destination;
@property (strong,nonatomic) MKPlacemark *source;

@end

@implementation TrackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView.delegate=self;
    _mapView2.delegate=self;
    // [self getDirections];
   // [_mapView setShowsUserLocation:YES];
    zoomed = NO;
    annotationViewCoordinate = CLLocationCoordinate2DMake([[[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_latitude"] floatValue], [[[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_longitude"] floatValue]);
    //[self GetDirections:annotationViewCoordinate];
    
    // rounded corneres
   annotation2 = [[MKPointAnnotation alloc] init];
    annotation1 = [[MKPointAnnotation alloc] init];
    _driverImage.layer.cornerRadius=10;
    _driverImage.clipsToBounds=YES;
    
    _fullscreenBtn.layer.cornerRadius=10;
    _fullscreenBtn.clipsToBounds=YES;
    
    _driverView.layer.cornerRadius=10;
    //_driverView.clipsToBounds=YES;
    
    _detailsView.layer.cornerRadius=10;
   // _detailsView.clipsToBounds=YES;
    
    _locationView.layer.cornerRadius=10;
    _locationView.clipsToBounds=YES;
    _mapView.layer.cornerRadius=10;
    _mapView.clipsToBounds=YES;
    _mapView2.layer.cornerRadius=10;
    _mapView2.clipsToBounds=YES;

    self.title = @"Children Track";
    
    // drop shadow
    [_detailsView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_detailsView.layer setShadowOpacity:0.2];
    [_detailsView.layer setShadowRadius:5.0];
    [_detailsView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    [_driverView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_driverView.layer setShadowOpacity:0.2];
    [_driverView.layer setShadowRadius:5.0];
    [_driverView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    [_locationView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_locationView.layer setShadowOpacity:0.2];
    [_locationView.layer setShadowRadius:5.0];
    [_locationView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    _imgBgView.layer.cornerRadius=10;
    
    [_driverView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_driverView.layer setShadowOpacity:0.2];
    [_driverView.layer setShadowRadius:5.0];
    [_driverView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    [_imgBgView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_imgBgView.layer setShadowOpacity:0.2];
    [_imgBgView.layer setShadowRadius:5.0];
    [_imgBgView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    auto_info =[_resultDic valueForKey:@"auto_info"];

    if(![[_resultDic valueForKey:@"auto_info"]  isEqual: @""]&&[_resultDic valueForKey:@"auto_info"] != (id)[NSNull null]){
    [self makePostCallForPageNEWGETNoProgess:UPDATEAUTOINFO withParams:@{@"id":[NSString stringWithFormat:@"%@",[auto_info valueForKey:@"auto_id"]]} withRequestCode:109];
    
    //auto_info =[_resultDic valueForKey:@"auto_info"];
    _autoId.text=[NSString stringWithFormat:@"%@",[auto_info valueForKey:@"auto_regno"]];
    
    _driverName.text=[NSString stringWithFormat:@"%@",[auto_info valueForKey:@"auto_driver"]];
    _driverPhoneNumber.text=[NSString stringWithFormat:@"%@",[auto_info valueForKey:@"auto_driver_phone"]];
    _driverEmail.text=[NSString stringWithFormat:@"%@",[auto_info valueForKey:@"auto_driver_email"]];

    _driverAddress.text=[NSString stringWithFormat:@"%@",[auto_info valueForKey:@"auto_driver_address"]];
    [_manImage setImageWithURL:[auto_info valueForKey:@"auto_driver_img"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    
    autoCoordinate = CLLocationCoordinate2DMake([[auto_info valueForKey:@"latitude"] floatValue], [[auto_info valueForKey:@"longitude"] floatValue]);
        [self GetDirections:annotationViewCoordinate];

        [NSTimer scheduledTimerWithTimeInterval:30
                                         target:self
                                       selector:@selector(updateMethod:)
                                       userInfo:nil
                                        repeats:YES];
    }else{
        
        //auto_info =[_resultDic valueForKey:@"auto_info"];
        _autoId.text=[NSString stringWithFormat:@"%@",@""];
        
        _driverName.text=[NSString stringWithFormat:@"%@",@"NOT-ASSIGNED"];
        _driverPhoneNumber.text=[NSString stringWithFormat:@"%@",@""];
        _driverEmail.text=[NSString stringWithFormat:@"%@",@""];
        
        _driverAddress.text=[NSString stringWithFormat:@"%@",@""];
        
        
       
    }
    _childrenStatusLbl.text=[NSString stringWithFormat:@"Status:%@",[_resultDic valueForKey:@"today_trip_status"]];

   
}


- (void)updateMethod:(NSTimer *)theTimer {
    // Your code goes here
    [self makePostCallForPageNEWGETNoProgess:UPDATEAUTOINFO withParams:@{@"id":[NSString stringWithFormat:@"%@",[auto_info valueForKey:@"auto_id"]]} withRequestCode:109];
  //  oldautoCoordinate = autoCoordinate;
  //  autoCoordinate = CLLocationCoordinate2DMake(autoCoordinate.latitude+0.01, autoCoordinate.longitude-0.005);
//    NSLog(@"auto -%f,%f,school-%f,%f",autoCoordinate.latitude,autoCoordinate.longitude,annotationViewCoordinate.latitude,annotationViewCoordinate.longitude);
//   [self updateLocation];
//    [self GetDirections:annotationViewCoordinate];
}

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==109){
        NSLog(@"%@",result);
        NSMutableDictionary *currentAuto=result[0];
       CLLocationCoordinate2D newcoordinates = CLLocationCoordinate2DMake([[currentAuto valueForKey:@"latitude"] floatValue], [[currentAuto valueForKey:@"longitude"] floatValue]);
        oldautoCoordinate = autoCoordinate;

        if(oldautoCoordinate.latitude != newcoordinates.latitude ||oldautoCoordinate.longitude != newcoordinates.longitude){

        autoCoordinate = CLLocationCoordinate2DMake([[currentAuto valueForKey:@"latitude"] floatValue], [[currentAuto valueForKey:@"longitude"] floatValue]);
        [self updateLocation];

        [self GetDirections:annotationViewCoordinate];
        }

    }
}

//-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
//    NSLog(@"Latitude: %f", view.annotation.coordinate.latitude);
//    NSLog(@"Longitude: %f", view.annotation.coordinate.longitude);
//    annotationViewCoordinate = view.annotation.coordinate;
//    [self GetDirections:view.annotation.coordinate];
//}

- (void)GetDirections:(CLLocationCoordinate2D)locationCoordinate
{
    
   // [_mapView removeAnnotations:_mapView.annotations];
    MKPlacemark *aPlcSource = [[MKPlacemark alloc] initWithCoordinate:autoCoordinate addressDictionary:nil];
    
    
//    if(!zoomed){
//    MKCoordinateRegion region;
//    //Set Zoom level using Span
//    MKCoordinateSpan span;
//        region.center = autoCoordinate;
//
//    span.latitudeDelta = 0.1;
//    span.longitudeDelta = 0.1;
//    region.span=span;
//    [_mapView setRegion:region animated:TRUE];
//        zoomed =YES;
//    }
    
    MKCoordinateRegion region;
    region.center.latitude = autoCoordinate.latitude - (autoCoordinate.latitude - locationCoordinate.latitude) * 0.5;
    region.center.longitude = autoCoordinate.longitude + (locationCoordinate.longitude - autoCoordinate.longitude) * 0.5;
    
    // Add a little extra space on the sides
    region.span.latitudeDelta = fabs(autoCoordinate.latitude - locationCoordinate.latitude) * 1.1;
    region.span.longitudeDelta = fabs(locationCoordinate.longitude - autoCoordinate.longitude) * 1.1;
    
    region = [_mapView regionThatFits:region];
    [_mapView setRegion:region animated:YES];
    // for fullscreen
    region = [_mapView2 regionThatFits:region];
    [_mapView2 setRegion:region animated:YES];
    
    MKPlacemark *aPlcDest = [[MKPlacemark alloc] initWithCoordinate:locationCoordinate addressDictionary:nil];
    
    //annotation1 = [[MKPointAnnotation alloc] init];
    annotation1.coordinate = locationCoordinate;
    annotation1.title = [[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_name"];
    
    //[self.mapView addAnnotation:annotation1];
    
  //annotation2 = [[MKPointAnnotation alloc] init];
//    annotation2.coordinate = autoCoordinate;
    [UIView animateWithDuration:2.0f
                          animations:^{
                              annotation2.coordinate = autoCoordinate;
                          }
                          completion:nil];
    annotation2.title = [auto_info valueForKey:@"auto_driver"];
    
    
    if(!zoomed){
    [self.mapView addAnnotation:annotation2];
        [self.mapView addAnnotation:annotation1];
        [self.mapView2 addAnnotation:annotation2];
        [self.mapView2 addAnnotation:annotation1];
        zoomed = YES;
    }
   
    
//    UIView.animate(withDuration: 3, animations: {
//        annotation2.coordinate = autoCoordinate
//    }, completion:  { success in
//        if success {
//            // handle a successfully ended animation
//        } else {
//            // handle a canceled animation, i.e move to destination immediately
//            annotation2.coordinate = autoCoordinate
//        }
//    })
    
    MKMapItem *mpItemSource = [[MKMapItem alloc] initWithPlacemark:aPlcSource];
    [mpItemSource setName:@"Source"];
    
    MKMapItem *mpItemDest  = [[MKMapItem alloc] initWithPlacemark:aPlcDest];
    [mpItemDest setName:@"Dest"];
    
    MKDirectionsRequest *aDirectReq = [[MKDirectionsRequest alloc] init];
    [aDirectReq setSource:mpItemSource];
    [aDirectReq setDestination:mpItemDest];
    [aDirectReq setTransportType:MKDirectionsTransportTypeAutomobile];
//    [aDirectReq setRequestsAlternateRoutes:YES];
    
    MKDirections *aDirections = [[MKDirections alloc] initWithRequest:aDirectReq];
    [aDirections calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error :: %@",error);
        }
        else{
            
            NSArray *aArrRoutes = [response routes];
          //  NSLog(@"Routes :: %@",aArrRoutes);
            
            [self.mapView removeOverlays:self.mapView.overlays];
            [self.mapView2 removeOverlays:self.mapView2.overlays];

            [aArrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                MKRoute *aRoute = obj;
              // to show the route with line
            //    [self.mapView addOverlay:aRoute.polyline];
            //    [self.mapView2 addOverlay:aRoute.polyline];

//                NSLog(@"Route Name : %@",aRoute.name);
//                NSLog(@"Total Distance (in Meters) :%f",aRoute.distance);
               NSArray *aArrSteps = [aRoute steps];
//
//                NSLog(@"Total Steps : %lu",(unsigned long)[aArrSteps count]);
                
                [aArrSteps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    NSLog(@"Rout Instruction : %@",[obj instructions]);
//                    NSLog(@"Rout Distance : %f",[obj distance]);
                }];
                
            }];
        }
    }];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
//    [self GetDirections:annotationViewCoordinate];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:253.0/255.0 alpha:1.0];
    renderer.lineWidth = 3.0;
    return  renderer;
}
//-(void) animateAnnotation:(MyAnnotation*)annotation{
//    [UIView animateWithDuration:2.0f
//                     animations:^{
//                         annotation.coordinate = newCordinates;
//                     }
//                     completion:nil];
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
//        if (!pinView)
//        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            if(annotation.title==[[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_name"]){
                pinView.image = [UIImage imageNamed:@"schoola"];
            }else{
                pinView.image = [UIImage imageNamed:@"autotrack"];
            }
//            pinView.calloutOffset = CGPointMake(-80, 0);

//        } else {
//            pinView.annotation = annotation;
//        }
        UIButton *rightButton   =   [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame       =   CGRectMake(0, 0, 30, 30);
       // [rightButton setTitle:@"Info!" forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
        rightButton.showsTouchWhenHighlighted   =   YES;
        [rightButton addTarget:self action:@selector(rightAcccoryViewButtonCLicked:) forControlEvents:UIControlEventTouchUpInside]; //rightAcccoryViewButtonCLicked is a function
        if(annotation.title==[[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_name"]){
        rightButton.tag = 1;
        }else{
            rightButton.tag = 2;
        }
        pinView.rightCalloutAccessoryView = rightButton;
        
        return pinView;
    }
    return nil;
}
-(void)rightAcccoryViewButtonCLicked:(UIButton *)sender{
    
    NSLog(@"%ld",(long)[sender tag]);
    NSInteger check =(long)[sender tag];
    if(check == 0){
        
        NSString *phoneNumber = [[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_phone"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];

    }else{
        NSString *phoneNumber = [[_resultDic valueForKey:@"auto_info"] valueForKey:@"auto_driver_phone"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];
    }
}



- (void)updateLocation {
    
    MKPointAnnotation *myAnnotation = annotation2;
    
    CLLocationCoordinate2D oldLocation;
    CLLocationCoordinate2D newLocation;
    
    
        
    oldLocation.latitude = oldautoCoordinate.latitude;
        oldLocation.longitude = oldautoCoordinate.longitude;
        newLocation.latitude = autoCoordinate.latitude;
        newLocation.longitude = autoCoordinate.latitude;
        float getAngle = [self angleFromCoordinate:oldLocation toCoordinate:newLocation];
        
        //        NSLog(@"Index : %ld, Angle : %f, Latitude : %f, Longtitude : %f",(long)self.index, getAngle, newLocation.latitude, newLocation.longitude);
        
        [UIView animateWithDuration:2
                         animations:^{
                             annotation2.coordinate = newLocation;
                             AnnotationView *annotationView = (AnnotationView *)[self.mapView viewForAnnotation:annotation2];
                             annotationView.transform = CGAffineTransformMakeRotation(getAngle);
                             AnnotationView *annotationView2 = (AnnotationView *)[self.mapView2 viewForAnnotation:annotation2];
                             annotationView2.transform = CGAffineTransformMakeRotation(getAngle);
                         }];
    
    
}


- (float)angleFromCoordinate:(CLLocationCoordinate2D)first
                toCoordinate:(CLLocationCoordinate2D)second {
    
    float deltaLongitude = second.longitude - first.longitude;
    float deltaLatitude = second.latitude - first.latitude;
    float angle = (M_PI * .5f) - atan(deltaLatitude / deltaLongitude);
    
    if (deltaLongitude > 0)      return angle;
    else if (deltaLongitude < 0) return angle + M_PI;
    else if (deltaLatitude < 0)  return M_PI;
    
    return 0.0f;
}

-(void)addCaptureViewFrom{

    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //always fill the view
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:blurEffectView]; //if you have more UIViews, use an insertSubview API to place it where needed
    } else {
       // self.view.backgroundColor = [UIColor blackColor];
        self.view.backgroundColor = [UIColor clearColor];

    }
    _locationFullScreen.frame=CGRectMake(0, 0, self.view.frame.size.width-60, self.view.frame.size.height-60-44);
    
    [UIView transitionWithView:_locationFullScreen duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        [self.view addSubview: _locationFullScreen];
    } completion:nil];
    _locationFullScreen.layer.cornerRadius=10;
    [_locationFullScreen.layer setShadowColor:[UIColor blackColor].CGColor];
    [_locationFullScreen.layer setShadowOpacity:0.2];
    [_locationFullScreen.layer setShadowRadius:5.0];
    [_locationFullScreen.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    _locationFullScreen.center=self.view.center;
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touches began");
//    UITouch *touch = [touches anyObject];
//
//    BOOL doesContain = [self.view.subviews containsObject:_locationFullScreen];
//
//    if(touch.view!=_locationFullScreen&&doesContain){
//        [_locationFullScreen removeFromSuperview];
//        blurEffectView.hidden = true;
//        [blurEffectView removeFromSuperview];
//        self.view.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
//
//
//    }
//
//}
- (IBAction)fullscreenBtnAction:(id)sender {
    [self addCaptureViewFrom];
}
- (IBAction)closeBtnAction:(id)sender {
    [_locationFullScreen removeFromSuperview];
    blurEffectView.hidden = true;
    [blurEffectView removeFromSuperview];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];

}
- (IBAction)imagesViewBtnAction:(id)sender {
    
}



@end
