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
    [_mapView setShowsUserLocation:YES];
    
    annotationViewCoordinate = CLLocationCoordinate2DMake(15.584049, 79.114021);
    [self GetDirections:annotationViewCoordinate];
    
    // rounded corneres
    
    _driverImage.layer.cornerRadius=10;
    _driverImage.clipsToBounds=YES;
    
    _driverView.layer.cornerRadius=10;
    _driverView.clipsToBounds=YES;
    
    _detailsView.layer.cornerRadius=10;
    _detailsView.clipsToBounds=YES;
    
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
    
    
}


-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"Latitude: %f", view.annotation.coordinate.latitude);
    NSLog(@"Longitude: %f", view.annotation.coordinate.longitude);
    annotationViewCoordinate = view.annotation.coordinate;
    [self GetDirections:view.annotation.coordinate];
}

- (void)GetDirections:(CLLocationCoordinate2D)locationCoordinate
{
    MKPlacemark *aPlcSource = [[MKPlacemark alloc] initWithCoordinate:self.mapView.userLocation.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"17.690474",@"83.231049", nil]];
    
    
    
    MKCoordinateRegion region;
    //Set Zoom level using Span
    MKCoordinateSpan span;
    region.center = self.mapView.userLocation.coordinate;
    
    span.latitudeDelta = 1;
    span.longitudeDelta = 1;
    region.span=span;
    [_mapView setRegion:region animated:TRUE];
    
    
    MKPlacemark *aPlcDest = [[MKPlacemark alloc] initWithCoordinate:locationCoordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"15.584049",@"79.114021", nil]];
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    annotation1.coordinate = locationCoordinate;
    annotation1.title = @"Cumbum";
    [self.mapView addAnnotation:annotation1];
    
    
    
    MKMapItem *mpItemSource = [[MKMapItem alloc] initWithPlacemark:aPlcSource];
    [mpItemSource setName:@"Source"];
    
    MKMapItem *mpItemDest  = [[MKMapItem alloc] initWithPlacemark:aPlcDest];
    [mpItemDest setName:@"Dest"];
    
    MKDirectionsRequest *aDirectReq = [[MKDirectionsRequest alloc] init];
    [aDirectReq setSource:mpItemSource];
    [aDirectReq setDestination:mpItemDest];
    [aDirectReq setTransportType:MKDirectionsTransportTypeAutomobile];
    [aDirectReq setRequestsAlternateRoutes:YES];
    
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
    [self GetDirections:annotationViewCoordinate];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:253.0/255.0 alpha:1.0];
    renderer.lineWidth = 4.0;
    return  renderer;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *fgAnnView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"MKPinAnnotationView"];
    
//    if (annotation == myRestaurantAnnotation) {
//        fgAnnView.image = //MAGIC GOES HERE//;
//    } else if (annotation == myBankAnnotation) {
//        fgAnnView.image = //MAGIC GOES HERE//;
//    }
    return fgAnnView;
}
//- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
//    MKPinAnnotationView *pinView =
//    (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
//    
//    
//    if (!pinView)
//    {
//        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
//                                                                        reuseIdentifier:SFAnnotationIdentifier];
//        UIImage *flagImage = [UIImage imageNamed:@"location.jpeg"];
//        // You may need to resize the image here.
//        annotationView.image = flagImage;
//        return annotationView;
//    }
//    else
//    {
//        pinView.annotation = annotation;
//    }
//    return pinView;
//}
@end
