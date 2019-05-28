//
//  TrackVC.m
//  SchoolAuto
//
//  Created by Apple on 07/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TrackVC.h"

@interface TrackVC ()
{
    CLLocationCoordinate2D annotationViewCoordinate ;
    CLLocationCoordinate2D autoCoordinate ;

    NSMutableDictionary *auto_info;
    
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
    // [self getDirections];
   // [_mapView setShowsUserLocation:YES];
    zoomed = NO;
    annotationViewCoordinate = CLLocationCoordinate2DMake([[[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_latitude"] floatValue], [[[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_longitude"] floatValue]);
    //[self GetDirections:annotationViewCoordinate];
    
    // rounded corneres
    
    _driverImage.layer.cornerRadius=10;
    _driverImage.clipsToBounds=YES;
    
    _driverView.layer.cornerRadius=10;
    //_driverView.clipsToBounds=YES;
    
    _detailsView.layer.cornerRadius=10;
   // _detailsView.clipsToBounds=YES;
    
    _locationView.layer.cornerRadius=10;
    _locationView.clipsToBounds=YES;
    _mapView.layer.cornerRadius=10;
    _mapView.clipsToBounds=YES;
    
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
    _childrenStatusLbl.text=[NSString stringWithFormat:@"Status:%@",[_resultDic valueForKey:@"pickup_status_txt"]];

   
}


- (void)updateMethod:(NSTimer *)theTimer {
    // Your code goes here
    [self makePostCallForPageNEWGETNoProgess:UPDATEAUTOINFO withParams:@{@"id":[NSString stringWithFormat:@"%@",[auto_info valueForKey:@"auto_id"]]} withRequestCode:109];
//    autoCoordinate = CLLocationCoordinate2DMake(autoCoordinate.latitude+0.01, autoCoordinate.longitude);
    
    //[self GetDirections:annotationViewCoordinate];
}

-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==109){
        NSLog(@"%@",result);
        NSMutableDictionary *currentAuto=result[0];
        autoCoordinate = CLLocationCoordinate2DMake([[currentAuto valueForKey:@"latitude"] floatValue], [[currentAuto valueForKey:@"longitude"] floatValue]);

        [self GetDirections:annotationViewCoordinate];

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
    
    [_mapView removeAnnotations:_mapView.annotations];
    MKPlacemark *aPlcSource = [[MKPlacemark alloc] initWithCoordinate:autoCoordinate addressDictionary:nil];
    
    
    if(!zoomed){
    MKCoordinateRegion region;
    //Set Zoom level using Span
    MKCoordinateSpan span;
        region.center = autoCoordinate;
    
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    region.span=span;
    [_mapView setRegion:region animated:TRUE];
        zoomed =YES;
    }
    
    
    MKPlacemark *aPlcDest = [[MKPlacemark alloc] initWithCoordinate:locationCoordinate addressDictionary:nil];
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    annotation1.coordinate = locationCoordinate;
    annotation1.title = [[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_name"];
    
    [self.mapView addAnnotation:annotation1];
    
    MKPointAnnotation *annotation2 = [[MKPointAnnotation alloc] init];
    annotation2.coordinate = autoCoordinate;
    annotation2.title = [auto_info valueForKey:@"auto_driver"];
    
    [self.mapView addAnnotation:annotation2];
    
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
            NSLog(@"Routes :: %@",aArrRoutes);
            
            [self.mapView removeOverlays:self.mapView.overlays];
            
            [aArrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                MKRoute *aRoute = obj;
                
                [self.mapView addOverlay:aRoute.polyline];
                
                NSLog(@"Route Name : %@",aRoute.name);
                NSLog(@"Total Distance (in Meters) :%f",aRoute.distance);
                NSArray *aArrSteps = [aRoute steps];
                
                NSLog(@"Total Steps : %lu",(unsigned long)[aArrSteps count]);
                
                [aArrSteps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSLog(@"Rout Instruction : %@",[obj instructions]);
                    NSLog(@"Rout Distance : %f",[obj distance]);
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
        return pinView;
    }
    return nil;
}
@end
