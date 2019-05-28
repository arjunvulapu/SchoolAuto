//
//  AddChildVC.m
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AddChildVC.h"
#import "FTPopOverMenu.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SubSucessVC.h"
@interface AddChildVC ()<CLLocationManagerDelegate>
{
    CLLocationCoordinate2D clocation;
    MKPointAnnotation *startPin;
    NSMutableArray *schoolsList;
    NSMutableDictionary *selectedSchool;
    
    NSMutableArray *pkgsList;
    NSMutableDictionary *selectedPkg;
    CLGeocoder *ceo;
    CLPlacemark *placemark;
    CLLocationManager *locationManager;

    
    NSString *selectedTrip;

    NSMutableArray *pricesList;
    NSMutableDictionary *selectedPrices;
    NSMutableDictionary *priceResult;


    NSMutableDictionary *userDic;
    
    NSMutableArray *classList;
    NSString *rupee;
    
    int numberofDays;
    float price;
}
@end

@implementation AddChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    numberofDays=0;
    // Do any additional setup after loading the view.
    classList=[[NSMutableArray alloc] initWithObjects:@"U.K.G",@"L.K.G",@"1 Class",@"2 Class",@"3 Class",@"4 Class",@"5 Class",@"6 Class",@"7 Class",@"8 Class",@"9 Class",@"10 Class",nil];
    pricesList=[[NSMutableArray alloc] init];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [currentDefaults objectForKey:@"USERINFO"];
    userDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    _NameTxtField.text=[NSString stringWithFormat:@"%@",[userDic valueForKey:@"pa_firstname"]];
    self.title = @"SUBSCRIPTION";
    _mapView.delegate=self;
    // [self getDirections];
   // [_mapView setShowsUserLocation:YES];
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    schoolsList=[[NSMutableArray alloc] init];
   _bgView.layer.cornerRadius=10;
//    _bgView.clipsToBounds=YES;
    [_bgView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_bgView.layer setShadowOpacity:0.2];
    [_bgView.layer setShadowRadius:5.0];
    [_bgView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    
    _paymentView.layer.cornerRadius=10;
    _paymentView.clipsToBounds=YES;
    _paynowBtn.layer.cornerRadius=10;
    _paynowBtn.clipsToBounds=YES;
    
    rupee=@"\u20B9";
    _priceLbl.text=[NSString stringWithFormat:@"%@ %@",rupee,@"000.00"];
    
}
- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position;

{
    NSLog(@"In willMove");
    //NSLog(@"%@",[mapView.camera target]);
    CLLocationCoordinate2D center = [mapView.camera target];
    clocation = center;
    _latLbl.text= [NSString stringWithFormat:@"%f",clocation.latitude];
    _logLbl.text= [NSString stringWithFormat:@"%f",clocation.longitude];
    [self getupdatedList];
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = buttonItem;
//    txtLatitude = center.latitude;
//    txtLongitude = center.longitude;
//    [self getGoogleAdrressFromLatLong:txtLatitude lon:txtLongitude];
}
-(void)viewWillAppear:(BOOL)animated{
//    clocation = self.mapView.userLocation.coordinate;
//    [self addpinAtCurrentLocation];
//    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:clocation.latitude longitude:clocation.longitude];
//    [self getAddressFromLocation:location2];
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"---- %@",userLocation);
    if(clocation.latitude == 0.00){
        clocation = userLocation.coordinate;
        [self addpinAtCurrentLocation];
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        CLLocationCoordinate2D location;
        location.latitude = userLocation.coordinate.latitude;
        location.longitude = userLocation.coordinate.longitude;
        region.span = span;
        region.center = location;
        [_mapView setRegion:region animated:YES];
       
    }
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:clocation.latitude longitude:clocation.longitude];
    [self getAddressFromLocation:location2];
    MKAnnotationView *userLocationView = [mapView viewForAnnotation:userLocation];
    userLocationView.hidden = YES;
}
//-(void)viewWillAppear:(BOOL)animated{
//    CLLocationCoordinate2D clocation = self.mapView.userLocation.coordinate;
//    NSLog(@"%@",clocation);
//    [self addpinAtCurrentLocation];
//
//}
//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
//{
//    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(_mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
//    CGFloat txtLatitude = coord.latitude;
//    CGFloat txtLongitude = coord.longitude;
//    NSLog(@"Latitude is===>>>%f",txtLatitude);
//    NSLog(@"Longitude is===>>>%f",txtLongitude);
//    clocation=coord;
//    _latLbl.text= [NSString stringWithFormat:@"%f",txtLatitude];
//    _logLbl.text= [NSString stringWithFormat:@"%f",txtLongitude];
//    [self addpinAtCurrentLocation];
//
//}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(_mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
    CGFloat txtLatitude = coord.latitude;
    CGFloat txtLongitude = coord.longitude;
    NSLog(@"Latitude is===>>>%f",txtLatitude);
    NSLog(@"Longitude is===>>>%f",txtLongitude);
    clocation=coord;
    _latLbl.text= [NSString stringWithFormat:@"%f",txtLatitude];
    _logLbl.text= [NSString stringWithFormat:@"%f",txtLongitude];
    [self addpinAtCurrentLocation];
    
}
-(void)addpinAtCurrentLocation{

//     clocation = self.mapView.userLocation.coordinate;
//    NSLog(@"%@",clocation);
    _latLbl.text= [NSString stringWithFormat:@"%f",clocation.latitude];
    _logLbl.text= [NSString stringWithFormat:@"%f",clocation.longitude];
    [self getupdatedList];
  

    // Example location
//    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(15.584049, 79.114021);
    
//    MKCoordinateRegion region;
//    //Set Zoom level using Span
//    MKCoordinateSpan span;
//    region.center = clocation;
//
//    span.latitudeDelta = 0.2;
//    span.longitudeDelta = 0.2;
//    region.span=span;
//    [_mapView setRegion:region animated:TRUE];
    
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(clocation, 500, 500);
//    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
//    [self.mapView setRegion:adjustedRegion animated:YES];
//
//    // Drop a pin
//    startPin = [[MKPointAnnotation alloc] init];
//    startPin.coordinate = clocation;
//    startPin.title = @"Address";
//
//    [self.mapView addAnnotation:startPin];
//
//    [self.mapView setCenterCoordinate:clocation];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *reuseId = @"pin";
    MKPinAnnotationView *pav = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pav == nil)
    {
        pav = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        pav.draggable = YES;
        pav.canShowCallout = YES;
        pav.animatesDrop=YES;
    }
    else
    {
        pav.annotation = annotation;
    }
    
    return pav;
}

//- (void)setDragState:(MKAnnotationViewDragState)newDragState animated:(BOOL)animated
//{
//    NSLog(@"%lu",(unsigned long)newDragState);
//    if(newDragState==MKAnnotationViewDragStateEnding)
//    {
//        clocation =startPin.coordinate;
//        _latLbl.text= [NSString stringWithFormat:@"%f",clocation.latitude];
//        _logLbl.text= [NSString stringWithFormat:@"%f",clocation.longitude];
//    }
//}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        clocation = annotationView.annotation.coordinate;
        NSLog(@"dropped at %f,%f", clocation.latitude, clocation.longitude);
        _latLbl.text= [NSString stringWithFormat:@"%f",clocation.latitude];
        _logLbl.text= [NSString stringWithFormat:@"%f",clocation.longitude];
        [self getupdatedList];
    }
}
-(void)getupdatedList{
   // school_id, latitude, longitude (of pickup points)
    if(_selectSchoolTxtField.text.length!=0){
    [self makePostCallForPageNEWNoProgess:SAHRING_OPTIONS withParams:@{@"school_id":[selectedSchool valueForKey:@"sch_id"],@"latitude":[NSString stringWithFormat:@"%f",clocation.latitude],@"longitude":[NSString stringWithFormat:@"%f",clocation.longitude]} withRequestCode:108];
    }
    CLLocation *location = [[CLLocation alloc] initWithLatitude:clocation.latitude longitude:clocation.longitude];
    [self getAddressFromLocation:location];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==108){
        NSLog(@"%@",result);
        priceResult = result;
        pricesList=[priceResult valueForKey:@"prices"];
       
    }else if(reqeustCode==118){
        NSLog(@"%@",result);
        if ([[result valueForKey:@"status"] isEqual:@0]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
            NSString *str=[result valueForKey:@"message"];
            //[self showSuccessMessage:str];
//            [self.navigationController popViewControllerAnimated:YES];
//            [self showSuccessMessage:str];
            SubSucessVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SubSucessVC"];
            NSMutableArray *suddata =[result valueForKey:@"subscription_data"];
            vc.subResult =suddata[0];
            [self PushToVc:vc];
        }
            
        
    }
    else if(reqeustCode==102){
        schoolsList =result;
        //    NSMutableArray *statusList=[NSMutableArray arrayWithObjects:@"Casual Leave",@"LOP",@"Sick Leave", nil];
        FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
        configuration.menuRowHeight = 40;
        configuration.menuWidth = self.view.frame.size.width-60;
        configuration.textColor = [UIColor blackColor];
        configuration.textFont = [UIFont boldSystemFontOfSize:14];
        configuration.tintColor = [UIColor whiteColor];
        configuration.borderColor = [UIColor lightGrayColor];
        configuration.borderWidth = 0.5;
        configuration.textAlignment = UITextAlignmentCenter;
        NSMutableArray *Item=[[NSMutableArray alloc] init];
        
        for(NSDictionary *LDic in schoolsList){
            [Item addObject:[LDic valueForKey:@"sch_name"]];
        }
        //        [Item addObject:@"t1"];
        //        [Item addObject:@"t2"];
        //        [Item addObject:@"t3"];
        //        [Item addObject:@"t4"];
        
        [FTPopOverMenu showForSender:_schoolbtn
                       withMenuArray:Item
                           doneBlock:^(NSInteger selectedIndex) {
                               
                               NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                               self->selectedSchool =[self->schoolsList objectAtIndex:selectedIndex];
                               self->_selectSchoolTxtField.text =[self->selectedSchool valueForKey:@"sch_name"];
                               [self getupdatedList];
                               //                           NSDictionary *LtypeDic=[leaveTypes objectAtIndex:selectedIndex];
                               //                           [self makePostCallForPage:HRLEAVEACTION withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":self->cancelStr,@"status":@"1",@"leave_type":[NSString stringWithFormat:@"%@",[LtypeDic valueForKey:@"id"]]} withRequestCode:11];
                               //
                               
                           } dismissBlock:^{
                               
                               NSLog(@"user canceled. do nothing.");
                               
                               //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                               //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                               
                           }];
        
    }else if(reqeustCode==103){
        pkgsList =result;
        //    NSMutableArray *statusList=[NSMutableArray arrayWithObjects:@"Casual Leave",@"LOP",@"Sick Leave", nil];
        FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
        configuration.menuRowHeight = 40;
        configuration.menuWidth = self.view.frame.size.width-60;
        configuration.textColor = [UIColor blackColor];
        configuration.textFont = [UIFont boldSystemFontOfSize:14];
        configuration.tintColor = [UIColor whiteColor];
        configuration.borderColor = [UIColor lightGrayColor];
        configuration.borderWidth = 0.5;
        configuration.textAlignment = UITextAlignmentCenter;
        NSMutableArray *Item=[[NSMutableArray alloc] init];
        
        for(NSDictionary *LDic in pkgsList){
            [Item addObject:[NSString stringWithFormat:@"%@ Sharing",[LDic valueForKey:@"auto_max_seating"]]];
        }
        //        [Item addObject:@"t1"];
        //        [Item addObject:@"t2"];
        //        [Item addObject:@"t3"];
        //        [Item addObject:@"t4"];
        
        [FTPopOverMenu showForSender:_selectPkgBtn
                       withMenuArray:Item
                           doneBlock:^(NSInteger selectedIndex) {
                               
                               NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                               self->selectedPkg =[self->pkgsList objectAtIndex:selectedIndex];
                               self->_selectPkgTxtField.text =[NSString stringWithFormat:@"%@ Sharing",[self->selectedPkg valueForKey:@"auto_max_seating"]];
                               
                               //                           NSDictionary *LtypeDic=[leaveTypes objectAtIndex:selectedIndex];
                               //                           [self makePostCallForPage:HRLEAVEACTION withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":self->cancelStr,@"status":@"1",@"leave_type":[NSString stringWithFormat:@"%@",[LtypeDic valueForKey:@"id"]]} withRequestCode:11];
                               //
                               
                           } dismissBlock:^{
                               
                               NSLog(@"user canceled. do nothing.");
                               
                               //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                               //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                               
                           }];
        
    }
}

- (IBAction)classBtnAction:(id)sender {
    [self resignFirstResponder];
    //    NSMutableArray *statusList=[NSMutableArray arrayWithObjects:@"Casual Leave",@"LOP",@"Sick Leave", nil];
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuRowHeight = 40;
    configuration.menuWidth = self.view.frame.size.width-60;
    configuration.textColor = [UIColor blackColor];
    configuration.textFont = [UIFont boldSystemFontOfSize:14];
    configuration.tintColor = [UIColor whiteColor];
    configuration.borderColor = [UIColor lightGrayColor];
    configuration.borderWidth = 0.5;
    configuration.textAlignment = UITextAlignmentCenter;
    
    //        [Item addObject:@"t1"];
    //        [Item addObject:@"t2"];
    //        [Item addObject:@"t3"];
    //        [Item addObject:@"t4"];
    
    [FTPopOverMenu showForSender:_classBtn
                   withMenuArray:classList
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           self->_classTxtField.text =[self->classList objectAtIndex:selectedIndex];
                           
                           //                           NSDictionary *LtypeDic=[leaveTypes objectAtIndex:selectedIndex];
                           //                           [self makePostCallForPage:HRLEAVEACTION withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":self->cancelStr,@"status":@"1",@"leave_type":[NSString stringWithFormat:@"%@",[LtypeDic valueForKey:@"id"]]} withRequestCode:11];
                           //
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                           //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                           //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                           
                       }];
    
}
-(void)getAddressFromLocation:(CLLocation *)location {
    NSLog(@"%f,%f",location.coordinate.latitude,location.coordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!placemarks) {
             // handle error
         }
         
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             NSString *address = [NSString stringWithFormat:@"%@ %@,%@ %@", [placemark subThoroughfare],[placemark thoroughfare],[placemark locality], [placemark administrativeArea]];
             NSString *locatedat =[[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             _enterAddressTxtView.text=[NSString stringWithFormat:@"%@",locatedat];
             NSLog(@"%@",locatedat);
//             // you have the address.
//             // do something with it.
//             [[NSNotificationCenter defaultCenter] postNotificationName:@"MBDidReceiveAddressNotification"
//                                                                 object:self
//                                                               userInfo:@{ @"address" : address }];
         }
     }];
}
- (IBAction)schoolbtnAction:(id)sender {
  //  if(schoolsList.count==0){
    [self makePostCallForPageNEWGET:SCHOOLSLIST withParams:nil withRequestCode:102];
 //   }
}
- (IBAction)selectPkgBtnAction:(id)sender {
//   // if(pkgsList.count==0){
//        [self makePostCallForPageNEWGET:PACKAGESLIST  withParams:nil withRequestCode:103];
//   // }
    if(_selectSchoolTxtField.text.length!=0){
        if(pricesList.count!=0){
    
        FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
       // configuration.menuRowHeight = 40;
        configuration.menuWidth = self.view.frame.size.width-60;
        configuration.textColor = [UIColor blackColor];
        configuration.textFont = [UIFont boldSystemFontOfSize:14];
        configuration.tintColor = [UIColor whiteColor];
        configuration.borderColor = [UIColor lightGrayColor];
        configuration.borderWidth = 0.5;
        configuration.textAlignment = UITextAlignmentCenter;
        NSMutableArray *Item=[[NSMutableArray alloc] init];
        
        for(NSDictionary *LDic in pricesList){
            [Item addObject:[NSString stringWithFormat:@"%@ Sharing-%@/-",[LDic valueForKey:@"share_count"],[LDic valueForKey:@"price"]]];
        }
        //        [Item addObject:@"t1"];
        //        [Item addObject:@"t2"];
        //        [Item addObject:@"t3"];
        //        [Item addObject:@"t4"];
        
        [FTPopOverMenu showForSender:_selectPkgBtn
                       withMenuArray:Item
                           doneBlock:^(NSInteger selectedIndex) {
                               
                               NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                               self->selectedPrices =[self->pricesList objectAtIndex:selectedIndex];
                               self->_selectPkgTxtField.text =[NSString stringWithFormat:@"%@ Sharing-%@/-",[self->selectedPrices valueForKey:@"share_count"],[self->selectedPrices valueForKey:@"price"]];
                               [self getupdatedList];
                               //                           NSDictionary *LtypeDic=[leaveTypes objectAtIndex:selectedIndex];
                               //                           [self makePostCallForPage:HRLEAVEACTION withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":self->cancelStr,@"status":@"1",@"leave_type":[NSString stringWithFormat:@"%@",[LtypeDic valueForKey:@"id"]]} withRequestCode:11];
                               //
                               
                           } dismissBlock:^{
                               
                               NSLog(@"user canceled. do nothing.");
                               
                               //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                               //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                               
                           }];
        }else{
            [self showErrorAlertWithMessage:@"Your Location is not in serverd Region"];

        }
    }else{
        [self showErrorAlertWithMessage:@"Please Select School"];
    }
        
    
}
- (IBAction)selectDurationTxtField:(id)sender {
}
- (IBAction)paynowBtnAction:(id)sender {
    if(_kidNameTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Enter KidName"];
    }else if(_ageTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Enter Age"];
    }else if(_classTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Select Class"];
    }else if(_selectSchoolTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Select School"];
    }else if(_selectTripTypeTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Select TripType"];
    }else if(_enterAddressTxtView.text.length==0){
        [self showErrorAlertWithMessage:@"Please Enter Address"];
    }else if(_selectPkgTxtField.text.length==0){
        [self showErrorAlertWithMessage:@"Please Select Package"];
    }else{
     //   parent_id, school_id, price_id, kid_name, kid_age, kid_class, pickup_address, pickup_latitude, pickup_longitude
        [self makePostCallForPageNEW:ADDSUBSCRIPTIONS withParams:@{@"parent_id":[userDic valueForKey:@"pa_id"],@"school_id":[selectedSchool valueForKey:@"sch_id"],@"price_id":[selectedPrices valueForKey:@"price_id"],@"kid_name":_kidNameTxtField.text,@"kid_age":_ageTxtField.text,@"kid_class":_classTxtField.text,@"pickup_address":_enterAddressTxtView.text,@"pickup_latitude":[NSString stringWithFormat:@"%f",clocation.latitude],@"pickup_longitude":[NSString stringWithFormat:@"%f",clocation.longitude],@"subscription_duration": [NSString stringWithFormat:@"%d",numberofDays],@"amount_paid":[NSString stringWithFormat:@"%.2f",price]} withRequestCode:118];
    }

    
}
- (IBAction)durationBtnAction:(id)sender {
    
        //   // if(pkgsList.count==0){
        //        [self makePostCallForPageNEWGET:PACKAGESLIST  withParams:nil withRequestCode:103];
        //   // }
        if(_selectPkgTxtField.text.length!=0){
            
            
            FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
            // configuration.menuRowHeight = 40;
            configuration.menuWidth = self.view.frame.size.width-60;
            configuration.textColor = [UIColor blackColor];
            configuration.textFont = [UIFont boldSystemFontOfSize:14];
            configuration.tintColor = [UIColor whiteColor];
            configuration.borderColor = [UIColor lightGrayColor];
            configuration.borderWidth = 0.5;
            configuration.textAlignment = UITextAlignmentCenter;
            NSMutableArray *Item=[[NSMutableArray alloc] init];
            
//            for(NSDictionary *LDic in pricesList){
//                [Item addObject:[NSString stringWithFormat:@"%@ Sharing-%@/-",[LDic valueForKey:@"share_count"],[LDic valueForKey:@"price"]]];
//            }
                    [Item addObject:@"1Month"];
                    [Item addObject:@"3Months"];
                    [Item addObject:@"5Months"];
            
            [FTPopOverMenu showForSender:_durationBtn
                           withMenuArray:Item
                               doneBlock:^(NSInteger selectedIndex) {
                                   
                                   NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                                   //self->selectedPrices =[self->pricesList objectAtIndex:selectedIndex];
                                   self->_selectdurationTxtField.text =[NSString stringWithFormat:@"%@",[Item objectAtIndex:selectedIndex]];
                                   
                                   price =0;
                                   if(selectedIndex==0){
                                       self->numberofDays=30;
                                       price =[[self->selectedPrices valueForKey:@"price_1mon"] floatValue];
                                   }else if(selectedIndex==1){
                                       self->numberofDays=90;
                                       price =[[self->selectedPrices valueForKey:@"price_3mon"] floatValue];

                                   }else if(selectedIndex==2){
                                       self->numberofDays=150;
                                       price =[[self->selectedPrices valueForKey:@"price_5mon"] floatValue];


                                   }
                                   self->_priceLbl.text=[NSString stringWithFormat:@"%@%.2f",rupee,price];

                                   //                           NSDictionary *LtypeDic=[leaveTypes objectAtIndex:selectedIndex];
                                   //                           [self makePostCallForPage:HRLEAVEACTION withParams:@{@"employee_id":[Utils loggedInUserIdStr],@"leave_id":self->cancelStr,@"status":@"1",@"leave_type":[NSString stringWithFormat:@"%@",[LtypeDic valueForKey:@"id"]]} withRequestCode:11];
                                   //
                                   
                               } dismissBlock:^{
                                   
                                   NSLog(@"user canceled. do nothing.");
                                   
                                   //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                                   //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                                   
                               }];
        }else{
            [self showErrorAlertWithMessage:@"Please Select School"];
        }
        
        
    
}
- (IBAction)tripBtnAction:(id)sender {
    
    
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    // configuration.menuRowHeight = 40;
    configuration.menuWidth = self.view.frame.size.width-60;
    configuration.textColor = [UIColor blackColor];
    configuration.textFont = [UIFont boldSystemFontOfSize:14];
    configuration.tintColor = [UIColor whiteColor];
    configuration.borderColor = [UIColor lightGrayColor];
    configuration.borderWidth = 0.5;
    configuration.textAlignment = UITextAlignmentCenter;
    NSMutableArray *Item=[[NSMutableArray alloc] init];
    
    //            for(NSDictionary *LDic in pricesList){
    //                [Item addObject:[NSString stringWithFormat:@"%@ Sharing-%@/-",[LDic valueForKey:@"share_count"],[LDic valueForKey:@"price"]]];
    //            }
    [Item addObject:@"HOME TO SCHOOL"];
    [Item addObject:@"SCHOOL TO HOME"];
    [Item addObject:@"ROUND TRIP"];
    
    [FTPopOverMenu showForSender:_tripBtn
                   withMenuArray:Item
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                   
                           self.selectTripTypeTxtField.text=[Item objectAtIndex:selectedIndex];
                           
                           
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                           //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                           //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                           
                       }];
}
@end
