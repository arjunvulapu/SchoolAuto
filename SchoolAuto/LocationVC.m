//
//  LocationVC.m
//  SchoolAuto
//
//  Created by Apple on 06/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "LocationVC.h"

@interface LocationVC ()
{
    CLLocationCoordinate2D annotationViewCoordinate ;
}
@property (strong, nonatomic) MKPlacemark *destination;
@property (strong,nonatomic) MKPlacemark *source;

@end

@implementation LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationMapView.delegate=self;
   // [self getDirections];
    [_locationMapView setShowsUserLocation:YES];
annotationViewCoordinate = CLLocationCoordinate2DMake(15.584049, 79.114021);
    
}
-(void)getDirections {
    
    CLLocationCoordinate2D sourceCoords = CLLocationCoordinate2DMake(15.584049, 79.114021);
    
    MKCoordinateRegion region;
    //Set Zoom level using Span
    MKCoordinateSpan span;
    region.center = sourceCoords;
    
    span.latitudeDelta = 1;
    span.longitudeDelta = 1;
    region.span=span;
    [_locationMapView setRegion:region animated:TRUE];
    
    // first source
    
    MKPlacemark *placemark  = [[MKPlacemark alloc] initWithCoordinate:sourceCoords addressDictionary:nil];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = sourceCoords;
    annotation.title = @"Cumbum";
    [self.locationMapView addAnnotation:annotation];
    //[self.locationMapView addAnnotation:placemark];
    
    
    _destination = placemark;
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:_destination];
    
    CLLocationCoordinate2D destCoords = CLLocationCoordinate2DMake(17.690474

                                                                   , 83.231049
);
    MKPlacemark *placemark1  = [[MKPlacemark alloc] initWithCoordinate:destCoords addressDictionary:nil];
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    annotation1.coordinate = destCoords;
    annotation1.title = @"Vizag";
    [self.locationMapView addAnnotation:annotation1];
    
    //[self.locationMapView addAnnotation:placemark1];
    
    _source = placemark1;
    MKMapItem *mapItem2 = [[MKMapItem alloc] initWithPlacemark:_source];

  
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = mapItem;
    
    request.destination = mapItem2;
    request.requestsAlternateRoutes = YES;
    request.transportType = MKDirectionsTransportTypeAutomobile;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             NSLog(@"ERROR");
             NSLog(@"%@",[error localizedDescription]);
         } else {
             [self showRoute:response];
         }
     }];
    
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [_locationMapView
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

#pragma mark - MKMapViewDelegate methods

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor colorWithRed:0.0/255.0 green:171.0/255.0 blue:253.0/255.0 alpha:1.0];
    renderer.lineWidth = 4.0;
    return  renderer;
}







//second

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"Latitude: %f", view.annotation.coordinate.latitude);
    NSLog(@"Longitude: %f", view.annotation.coordinate.longitude);
    annotationViewCoordinate = view.annotation.coordinate;
    [self GetDirections:view.annotation.coordinate];
}

- (void)GetDirections:(CLLocationCoordinate2D)locationCoordinate
{
    MKPlacemark *aPlcSource = [[MKPlacemark alloc] initWithCoordinate:self.locationMapView.userLocation.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"17.690474",@"83.231049", nil]];
    
    
    
    MKCoordinateRegion region;
    //Set Zoom level using Span
    MKCoordinateSpan span;
    region.center = self.locationMapView.userLocation.coordinate;
    
    span.latitudeDelta = 1;
    span.longitudeDelta = 1;
    region.span=span;
    [_locationMapView setRegion:region animated:TRUE];
    
    
    MKPlacemark *aPlcDest = [[MKPlacemark alloc] initWithCoordinate:locationCoordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"15.584049",@"79.114021", nil]];
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    annotation1.coordinate = locationCoordinate;
    annotation1.title = @"Cumbum";
    [self.locationMapView addAnnotation:annotation1];
    
    
    
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
            
            [self.locationMapView removeOverlays:self.locationMapView.overlays];
            
            [aArrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                MKRoute *aRoute = obj;
                
                [self.locationMapView addOverlay:aRoute.polyline];
                
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
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *)[_locationMapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
    
    
    if (!pinView)
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:SFAnnotationIdentifier];
        UIImage *flagImage = [UIImage imageNamed:@"location.jpeg"];
        // You may need to resize the image here.
        annotationView.image = flagImage;
        return annotationView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}
@end
