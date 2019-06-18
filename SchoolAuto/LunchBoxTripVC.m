//
//  LunchBoxTripVC.m
//  SchoolAuto
//
//  Created by Apple on 14/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "LunchBoxTripVC.h"
#import "TripCC.h"
#import "Common.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Utils.h"
#import "PECropViewController.h"
#import <ImageIO/ImageIO.h>
#import <CoreLocation/CoreLocation.h>
#import "FTPopOverMenu.h"

@interface LunchBoxTripVC ()<CLLocationManagerDelegate,UIImagePickerControllerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *placemark;

    NSMutableArray *childList;
    MKPointAnnotation   *annotation0;
    UIVisualEffectView *blurEffectView;
   
    MKPointAnnotation *autoCurrectAnn;
    NSDictionary *selectedKid;

    NSString *pushingFrom;
    
    NSMutableArray *statusList;
    NSDictionary *selectedStatusDict;
    NSDictionary *selectedCommnetDict;
    
    NSMutableArray *preExistMessagesList;
    NSMutableDictionary *preExistMessagesDict;

    NSUInteger selectedStatusIndex;
    
}
@end

@implementation LunchBoxTripVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    preExistMessagesList=[[NSMutableArray alloc] init];

    statusList=[[NSMutableArray alloc] init];
    childList=[[NSMutableArray alloc] init];
    self.navigationItem.title= @"TRIP";
    [_endTripBtn.layer setCornerRadius:10];
    _endTripBtn.clipsToBounds =YES;
    [_addMessageBtn.layer setCornerRadius:10];
    _addMessageBtn.clipsToBounds =YES;
    _addMessageBtn.hidden=YES;
    [_selectCommentBtn.layer setCornerRadius:10];
    _selectCommentBtn.clipsToBounds =YES;
    
    [_bgView.layer setCornerRadius:10];

    [_bgView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_bgView.layer setShadowOpacity:0.2];
    [_bgView.layer setShadowRadius:5.0];
    [_bgView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
//    [_kidsTableView setEditing:YES animated:YES];
//    [_kidsTableView setAllowsSelection:YES];
    [self.mapView setShowsUserLocation:YES];
    _mapView.hidden = YES;
    _userlocation.hidden=YES;

    _kidsTableView.hidden=NO;
//    [self makePostCallForPageNEWGET:ADDSUBSCRIPTIONS withParams:@{@"pid":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];
    childList=[[_tripDict valueForKey:@"subscriptions"] mutableCopy];
    if([[_tripDict valueForKey:@"today_trip_status"] isEqual:@"ended"]){
        _endTripBtn.hidden=YES;
        _addMessageBtn.hidden=YES;
    }else{
        _endTripBtn.hidden=NO;
        _addMessageBtn.hidden=YES;


    }
    [self addallPins];

    self->locationManager = [[CLLocationManager alloc]init];
    self->locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    _kidsTableView.userInteractionEnabled=YES;
    _bgView.userInteractionEnabled=YES;
    
    _submitBtn.layer.cornerRadius=10;
    _submitBtn.clipsToBounds=YES;
    
    [self makePostCallForPageNEWGET:LUNCHBOX_STATUSLIST withParams:nil withRequestCode:12];
    _userlocation.layer.cornerRadius=10;
    _userlocation.clipsToBounds=YES;
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
        if(annotation==autoCurrectAnn){
//            pinView.image = [UIImage imageNamed:@"pin"];
            pinView.image = [UIImage imageNamed:@"autotrack"];

        }else{
            pinView.image = [UIImage imageNamed:@"home"];
        }
        //            pinView.calloutOffset = CGPointMake(-80, 0);
        
        //        } else {
        //            pinView.annotation = annotation;
        //        }
        return pinView;
    }
    return nil;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.mapView removeAnnotation:autoCurrectAnn];
  //  [self updateToServer:userLocation.coordinate.latitude withlong:userLocation.coordinate.longitude];
    
    autoCurrectAnn = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=userLocation.coordinate.latitude;
    myCoordinate.longitude=userLocation.coordinate.longitude;
    autoCurrectAnn.coordinate = myCoordinate;
//    autoCurrectAnn.title=@"auto";
    [self.mapView addAnnotation:autoCurrectAnn];
    
//    annotation0= [[MKPointAnnotation alloc] init];
//    CLLocationCoordinate2D myCoordinate;
//    myCoordinate.latitude=16.5189;
//    myCoordinate.longitude=80.6773;
//    annotation0.coordinate = myCoordinate;
//    annotation0.title=@"0";
//    annotation0.subtitle=@"";
//    [self.mapView addAnnotation:annotation0];
}
-(void)updateToServer:(CGFloat)lat withlong:(CGFloat)lng{
    [self makePostCallForPageNEWNoProgess:UPDATEAUTOINFO withParams:@{@"auto_id":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]],@"latitude":[NSString stringWithFormat:@"%f",lat],@"longitude":[NSString stringWithFormat:@"%f",lng]} withRequestCode:110];

}
-(void)addallPins{
            for(NSMutableDictionary *dic in childList){
                MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
                CLLocationCoordinate2D myCoordinate;
                myCoordinate.latitude=[[dic valueForKey:@"pickup_latitude"] floatValue];
                myCoordinate.longitude=[[dic valueForKey:@"pickup_longitude"] floatValue];
                annotation.coordinate = myCoordinate;
                annotation.title=[dic valueForKey:@"kid_name"];
                annotation.subtitle=@"";
                [self.mapView addAnnotation:annotation];
            }
    
    if(childList.count>0){
        NSMutableDictionary *dic =[childList objectAtIndex:0];
        CLLocationCoordinate2D myCoordinate;
        myCoordinate.latitude=[[dic valueForKey:@"pickup_latitude"] floatValue];
        myCoordinate.longitude=[[dic valueForKey:@"pickup_longitude"] floatValue];
                MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, 3000, 3000);
                MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
                [self.mapView setRegion:adjustedRegion animated:YES];
                self.mapView.showsUserLocation = YES;
    }
}


-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"Result--%@",result);

    if(reqeustCode==109){
//        NSLog(@"Result--%@",result);
        childList=result;
        [_kidsTableView reloadData];
        
       

        
//        for(NSMutableDictionary *dic in resultList){
//            MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
//            CLLocationCoordinate2D myCoordinate;
//            myCoordinate.latitude=[[dic valueForKey:@"latitude"] floatValue];
//            myCoordinate.longitude=[[dic valueForKey:@"longitude"] floatValue];
//            annotation.coordinate = myCoordinate;
//            annotation.title=[dic valueForKey:@"title"];
//            annotation.subtitle=@"";
//
//
//            [self.mapView addAnnotation:annotation];
//            //        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, 10000, 10000);
//            //        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
//            //        [self.mapView setRegion:adjustedRegion animated:YES];
//            //        self.mapView.showsUserLocation = YES;
//
//
//        }
    }else if(reqeustCode==12){
        statusList=result;
        [_kidsTableView reloadData];
    }
        else if(reqeustCode==110){

    }else if(reqeustCode==111){
        [self showSuccessMessage:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]]];
        _endTripBtn.hidden=YES;
        _addMessageBtn.hidden=YES;

    }else if(reqeustCode==113){
        
        preExistMessagesList=result;
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
        NSMutableArray *imagesArray=[[NSMutableArray alloc] init];
        
        for(NSDictionary *LDic in preExistMessagesList){
            [Item addObject:[NSString stringWithFormat:@"%@",[LDic valueForKey:@"title"]]];
           // [imagesArray addObject:@"pingreen.png"];
            
        }
        
        
        
        [FTPopOverMenu showForSender:_selectCommentBtn
                       withMenuArray:Item
                          //imageArray:imagesArray
                           doneBlock:^(NSInteger selectedIndex) {
                               
                               NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                               preExistMessagesDict = [preExistMessagesList objectAtIndex:selectedIndex];
                               
                               [self->_selectCommentBtn setTitle:[self->preExistMessagesDict valueForKey:@"title"] forState:UIControlStateNormal];
                               
                               
                               
                           } dismissBlock:^{
                               
                               NSLog(@"user canceled. do nothing.");
                               
                               //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                               //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                               
                           }];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    ceo= [[CLGeocoder alloc]init];
    [self->locationManager requestWhenInUseAuthorization];
    if ([self->locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self->locationManager requestWhenInUseAuthorization];
    }
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude=locationManager.location.coordinate.latitude;
    coordinate.longitude=locationManager.location.coordinate.longitude;
    //CLLocationCoordinate2D  ctrpoint;
    //  ctrpoint.latitude = ;
    //ctrpoint.longitude =f1;
    //coordinate.latitude=23.6999;
    //coordinate.longitude=75.000;
    //MKPointAnnotation *marker = [MKPointAnnotation new];
    //   marker.coordinate = coordinate;
    NSLog(@"%f",coordinate.latitude);
    //[self.mapView addAnnotation:marker];
    
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude
                       ];
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  placemark = [placemarks objectAtIndex:0];
                  NSLog(@"placemark %@",placemark);
                  //String to hold address
                  NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                  NSLog(@"addressDictionary %@", placemark.addressDictionary);
                  
                  NSLog(@"placemark %@",placemark.region);
                  NSLog(@"placemark %@",placemark.country);  // Give Country Name
                  NSLog(@"placemark %@",placemark.locality); // Extract the city name
                  NSLog(@"location %@",placemark.name);
                  NSLog(@"location %@",placemark.ocean);
                  NSLog(@"location %@",placemark.postalCode);
                  NSLog(@"location %@",placemark.subLocality);
                  
                  NSLog(@"location %@",placemark.location);
                  //Print the location to console
                  NSLog(@"I am currently at %@",locatedAt);
                  
                  
                  // _City.text=[placemark.addressDictionary objectForKey:@"City"];
                //  [locationManager stopUpdatingLocation];
              }
     
     ];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return statusList.count==0?0:childList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"TripCC";
    
    TripCC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    NSDictionary *dic =[childList objectAtIndex:indexPath.row];
   
    cell.kidNameLbl.text = [NSString stringWithFormat:@"%@\n%@",[dic valueForKey:@"kid_name"],[dic valueForKey:@"pickup_address"]];
    NSDictionary *statusdic =[[NSDictionary alloc] init];
    if([[dic valueForKey:@"today_pickup_status"] intValue]==0){
//   statusdic =[statusList objectAtIndex:[[dic valueForKey:@"today_pickup_status"] intValue]];
        [cell.driverBtn setTitle:@"Start" forState:UIControlStateNormal];

    }else{
        statusdic =[statusList objectAtIndex:[[dic valueForKey:@"today_pickup_status"] intValue]-1];
        [cell.driverBtn setTitle:[statusdic valueForKey:@"status_name"] forState:UIControlStateNormal];


    }
    cell.driverAction = ^{
        selectedStatusIndex = indexPath.row;
        selectedKid =[childList objectAtIndex:indexPath.row];
        //[self addCaptureViewFrom:@"kid"];
        [self changeStatus:cell.driverBtn];
    };
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TrackVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TrackVC"];
//    [self PushToVc:vc];
    NSDictionary *dic =[childList objectAtIndex:indexPath.row];
    NSLog(@"%@",dic);
    
}
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    //Even if the method is empty you should be seeing both rearrangement icon and animation.
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
- (IBAction)tripSegementAction:(id)sender {
    if(_tripSegment.selectedSegmentIndex==0){
        _mapView.hidden = YES;
        _userlocation.hidden=YES;

        _kidsTableView.hidden=NO;
    }else{
        _mapView.hidden = NO;
        _userlocation.hidden=NO;

        _kidsTableView.hidden=YES;
    }
}
- (IBAction)captureBtnAction:(id)sender {
    [self imageSelection:sender];
}


-(CLLocationCoordinate2D) getLocation{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}

         
-(void)imageSelection:(id)sender{
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude
                       ];
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  placemark = [placemarks objectAtIndex:0];
                  NSLog(@"placemark %@",placemark);
                  //String to hold address
                  NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                  NSLog(@"addressDictionary %@", placemark.addressDictionary);
                  
                  NSLog(@"placemark %@",placemark.region);
                  NSLog(@"placemark %@",placemark.country);  // Give Country Name
                  NSLog(@"placemark %@",placemark.locality); // Extract the city name
                  NSLog(@"location %@",placemark.name);
                  NSLog(@"location %@",placemark.ocean);
                  NSLog(@"location %@",placemark.postalCode);
                  NSLog(@"location %@",placemark.subLocality);
                  
                  NSLog(@"location %@",placemark.location);
                  //Print the location to console
                  NSLog(@"I am currently at %@",locatedAt);
                  
                  
                  // _City.text=[placemark.addressDictionary objectForKey:@"City"];
                 // [locationManager stopUpdatingLocation];
              }
     
     ];
    
    // if (!_userPicker) {
    _userPicker = [[UIImagePickerController alloc] init];
    _userPicker.delegate = self;
    //}
    _userPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_userPicker animated:YES completion:nil];
//    UIAlertController *controller = [UIAlertController alertControllerWithTitle:Localized(@"Select Image") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"Camera") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        _userPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:_userPicker animated:YES completion:nil];
//    }]];
//    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"Gallery") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        _userPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:_userPicker animated:YES completion:nil];
//    }]];
//    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"Cancel") style:UIAlertActionStyleCancel handler:nil]];
//
//    [self presentViewController:controller animated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)image {
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    if (image != nil) {
        self.user_image.image = image;
        user_uiimage2 = image;
        
        
    }
}
UIImage *user_uiimage2;
//- (void)uploadImagesWithProgressWithId:(NSString *)adId {
//
//    //http://clients.yellowsoft.in/lawyers/api/add-member-image.php
//
//    NSString *serverURL = [NSString stringWithFormat:@"%@/%@", SERVER_URL,TRIP_STATUS];
//
//    NSDictionary *parameters = @{@"trip_id":[NSString stringWithFormat:@"%@",[_tripDict valueForKey:@"trip_id"]],@"subscription_id":[NSString stringWithFormat:@"%@",[selectedKid valueForKey:@"subscription_id"]],@"comment":[NSString stringWithFormat:@"%@",_commnetView.text]};
//
//
//    //    UIImage *image = user_uiimage;
//    UIImage *image = [UIImage imageWithCGImage:_captureImage.image.CGImage scale:0.25 orientation:_captureImage.image.imageOrientation];
//
//    if (image == nil) {
//        [self hideHUD];
//        [Utils showAlertWithMessage:[MCLocalization stringForKey:@"Updated Sucessfully"]];
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//
//
//    // image = [image resizedImageToFitInSize:CGSizeMake(960, 640) scaleIfSmaller:NO];
//
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:serverURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//        [formData appendPartWithFileData:UIImagePNGRepresentation(image)
//                                    name:@"image"
//                                fileName:@"file.png"
//                                mimeType:@"image/png"];
//    } error:nil];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//   // manager.responseSerializer = [AFImageResponseSerializer serializer];
//    NSURLSessionUploadTask *uploadTask;
//
//    uploadTask = [manager uploadTaskWithStreamedRequest:request
//                                               progress:^(NSProgress * _Nonnull uploadProgress) {
//                                                   dispatch_async(dispatch_get_main_queue(), ^{
//                                                       [SVProgressHUD showProgress:uploadProgress.fractionCompleted];
//                                                   });
//                                               }
//                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                                          if (error) {
//                                              NSLog(@"Failure %@", error.description);
//                                              [self hideHUD];
//                                              [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"error_while_posting_ad"]];
//
//                                          } else {
//
//                                              NSLog(@"Success %@", responseObject);
//
//                                              [self hideHUD];
//                                              [Utils showAlertWithMessage:[MCLocalization stringForKey:@"Updated Sucessfully"]];
//                                              [self.navigationController popViewControllerAnimated:YES];
//                                          }
//                                      }];
//
//
//
//    [uploadTask resume];
//}

-(void)uploadFile2{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", SERVER_URL,LUNCHBOX_TRIP_STATUS]];
    NSDictionary *parameters = [[NSDictionary  alloc] init];;
    if([pushingFrom isEqualToString:@"end"]){
        parameters = @{@"trip_id":[NSString stringWithFormat:@"%@",[_tripDict valueForKey:@"trip_id"]],@"end":@"true",@"latitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.longitude],@"comment":@"Trip Ended"};
    }else if([pushingFrom isEqualToString:@"kid"]){
        parameters = @{@"trip_id":[NSString stringWithFormat:@"%@",[_tripDict valueForKey:@"trip_id"]],@"subscription_id":[NSString stringWithFormat:@"%@",[selectedKid valueForKey:@"subscription_id"]],@"pickup_status":[NSString stringWithFormat:@"%@",[selectedStatusDict valueForKey:@"status_id"]],@"latitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.longitude]};
    }else {
        parameters = @{@"trip_id":[NSString stringWithFormat:@"%@",[_tripDict valueForKey:@"trip_id"]],@"latitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.longitude]};
    }
    
    
    
    UIImage *myImageObj = _captureImage.image;
    NSData *imageData= UIImageJPEGRepresentation(myImageObj, 0.6);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager POST:URL.absoluteString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"image"
                                fileName:@"image.jpg" mimeType:@"image/jpeg"];
        
        // etc.
    } progress:^(NSProgress * _Nonnull uploadProgress) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showProgress:uploadProgress.fractionCompleted];
                                                           });
                                                       }
    success:^(NSURLSessionDataTask *task, id responseObject) {
         [self hideHUD];
        NSLog(@"Response: %@", responseObject);
        
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if([[dict valueForKey:@"status"] isEqual:@1]){
            NSLog(@"Result:%@",dict);
            if([pushingFrom isEqualToString:@"kid"]){
                [self reloadForStatus];
            }
//            [_caprtureView removeFromSuperview];
//            blurEffectView.hidden = true;
//            [blurEffectView removeFromSuperview];
            
        }else{
            NSLog(@"Error: %@", [dict valueForKey:@"message"]);

        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
// Ensure you've set yourself as the UIImagePickerController delegate to ensure this method is called
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = info[UIImagePickerControllerOriginalImage];
//    image = [self imageWithRenderedDateMetadata:info[UIImagePickerControllerMediaMetadata]
//                                        onImage:image];
    NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];

    NSString* dateString = [NSString stringWithFormat:@"%@ %@",[[[info valueForKey:@"UIImagePickerControllerMediaMetadata"] valueForKey:@"{TIFF}"] valueForKey:@"DateTime"],locatedAt];

    image = [self drawText:dateString inImage:image atPoint:CGPointMake(0, 0)];
    //image = [self drawFront:image text:dateString atPoint:CGPointMake(0, 0)];
    _imagePlaceHolder.hidden =YES;

}

-(UIImage*)drawFront:(UIImage*)image text:(NSString*)text atPoint:(CGPoint)point
{
    UIFont *font = [UIFont systemFontOfSize:120];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, (point.y - 5), image.size.width, image.size.height);
    [[UIColor whiteColor] set];
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, [attString length]);
    
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(1.0f, 1.5f);
    [attString addAttribute:NSShadowAttributeName value:shadow range:range];
    
    [attString drawInRect:CGRectIntegral(rect)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _user_image.image=newImage;
    _captureImage.image=newImage;
    
    return newImage;
}
-(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:120];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
//    [[UIColor brownColor] set];
//    CGContextFillRect(UIGraphicsGetCurrentContext(),
//                      CGRectMake(0, 0,
//                                 image.size.width, [text sizeWithFont:font].height));
    [[UIColor whiteColor] set];
//    [text drawInRect:CGRectIntegral(rect) withFont:font];
    [text drawInRect:CGRectIntegral(rect) withAttributes:@{NSFontAttributeName :font,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _user_image.image=newImage;
    _captureImage.image=newImage;
    return newImage;
}
- (UIImage*)imageWithRenderedDateMetadata:(NSDictionary*)metadata onImage:(UIImage*)image
{
    if (!image || !metadata) { return nil; }
    
    // Get Date String
    // Note: You can format the date string here into a more readable format if you want
    // Here, I'll just use the YYYY:MM:DD HH:MM:SS format given
    NSDictionary *tiffMetadata = metadata[(__bridge id)kCGImagePropertyTIFFDictionary];
    NSString* dateString = [NSString stringWithFormat:@"%@-%@",[tiffMetadata valueForKey:@"DateTime"],placemark.locality];
    
    UIFont *font = [UIFont boldSystemFontOfSize:200];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(100, image.size.height-300, image.size.width,image.size.height);
    [[UIColor whiteColor] set];
    NSDictionary* attributes = @{NSFontAttributeName :[UIFont boldSystemFontOfSize:image.size.height/20],
                                 NSStrokeColorAttributeName : [UIColor blackColor],
                                 NSForegroundColorAttributeName : [UIColor yellowColor],
                                 NSStrokeWidthAttributeName : @-2.0};
    
    
    [dateString drawInRect:rect withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _user_image.image=newImage;
    _captureImage.image=newImage;
    
    return newImage;
}
         
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
             NSLog(@"touches began");
             UITouch *touch = [touches anyObject];
    
             BOOL doesContain = [self.view.subviews containsObject:_caprtureView];
             
             if(touch.view!=_caprtureView&&doesContain){
                 [_caprtureView removeFromSuperview];
                 blurEffectView.hidden = true;
                 [blurEffectView removeFromSuperview];             }
         }
-(void)addCaptureViewFrom:(NSString *)from{
    pushingFrom = from;
    _imagePlaceHolder.hidden =NO;

    _captureImage.image = nil;
    _commnetView.text=@"";
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //always fill the view
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [self.view addSubview:blurEffectView]; //if you have more UIViews, use an insertSubview API to place it where needed
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
             _caprtureView.frame=CGRectMake(0, 0, self.view.frame.size.width-70, 450);
             
             [UIView transitionWithView:_caprtureView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
                 [self.view addSubview: _caprtureView];
             } completion:nil];
             _caprtureView.layer.cornerRadius=10;
    [_caprtureView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_caprtureView.layer setShadowOpacity:0.2];
    [_caprtureView.layer setShadowRadius:5.0];
    [_caprtureView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    _caprtureView.center=self.view.center;
}

- (IBAction)submitbtnAction:(id)sender {
//    [self uploadImagesWithProgressWithId:@"1"];
//    UIImage *image = [UIImage imageWithCGImage:_captureImage.image.CGImage scale:0.25 orientation:_captureImage.image.imageOrientation];
//    if(image==nil){
//        [self uploadWithOutImage];
//    }else{
//        [self uploadFile2];
//
//    }
   [self uploadWithOutImage];


}
-(void)uploadWithOutImage{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", SERVER_URL,LUNCHBOX_TRIP_STATUS]];
    NSDictionary *parameters = [[NSDictionary  alloc] init];;
    if([pushingFrom isEqualToString:@"end"]){
        parameters = @{@"trip_id":[NSString stringWithFormat:@"%@",[_tripDict valueForKey:@"trip_id"]],@"end":@"true",@"latitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.longitude],@"comment":@"Trip Ended"};
    }else if([pushingFrom isEqualToString:@"kid"]){
        parameters = @{@"trip_id":[NSString stringWithFormat:@"%@",[_tripDict valueForKey:@"trip_id"]],@"subscription_id":[NSString stringWithFormat:@"%@",[selectedKid valueForKey:@"subscription_id"]],@"pickup_status":[NSString stringWithFormat:@"%@",[selectedStatusDict valueForKey:@"status_id"]],@"comment":[NSString stringWithFormat:@"%@",[selectedStatusDict valueForKey:@"status_name"]],@"latitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.longitude]};
    }else {
        parameters = @{@"trip_id":[NSString stringWithFormat:@"%@",[_tripDict valueForKey:@"trip_id"]],@"latitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.longitude]};
    }
    
    
    
//    UIImage *myImageObj = _captureImage.image;
//    NSData *imageData= UIImageJPEGRepresentation(myImageObj, 0.6);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager POST:URL.absoluteString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData
//                                    name:@"image"
//                                fileName:@"image.jpg" mimeType:@"image/jpeg"];
        
        // etc.
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showProgress:uploadProgress.fractionCompleted];
        });
    }
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [self hideHUD];
              NSLog(@"Response: %@", responseObject);
              
              NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              NSLog(@"%@",string);
              NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
              if([[dict valueForKey:@"status"] isEqual:@1]){
                  NSLog(@"Result:%@",dict);
                  if([self->pushingFrom isEqualToString:@"kid"]){
                      [self reloadForStatus];
                  }
                  if([self->pushingFrom isEqualToString:@"end"]){
                  
                  [self showSuccessMessage:[NSString stringWithFormat:@"%@",[dict valueForKey:@"message"]]];
                  _endTripBtn.hidden=YES;
                      _addMessageBtn.hidden=YES;

                  }
//                  [self->_caprtureView removeFromSuperview];
//                  blurEffectView.hidden = true;
//                  [blurEffectView removeFromSuperview];
                  
              }else{
                  NSLog(@"Error: %@", [dict valueForKey:@"message"]);
                  
              }
              
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}
- (IBAction)addMessageBtnAction:(id)sender {
    [self addCaptureViewFrom:@"message"];
}

- (IBAction)endBtnAction:(id)sender {
    //[self addCaptureViewFrom:@"end"];
 //   [self uploadWithOutImage];

    // [self makePostCallForPageNEW:TRIP_STATUS withParams:@{@"trip_id":[NSString stringWithFormat:@"%@",[_tripDict valueForKey:@"trip_id"]],@"end":@"true"} withRequestCode:111];
    pushingFrom = @"end";
    [self uploadWithOutImage];
}
-(void)changeStatus:(id)sender{
    if([[_tripDict valueForKey:@"today_trip_status"] isEqual:@"ended"]){
        [self showErrorAlertWithMessage:@"Trip Ended"];
    }else{
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
    
    NSMutableArray *Item=[[NSMutableArray alloc] init];
    
                for(NSDictionary *LDic in statusList){
                    [Item addObject:[NSString stringWithFormat:@"%@",[LDic valueForKey:@"status_name"]]];
                }
    
    
    [FTPopOverMenu showForSender:sender
                   withMenuArray:Item
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           selectedStatusDict = [statusList objectAtIndex:selectedIndex];
//                           [self addCaptureViewFrom:@"kid"];
                           pushingFrom=@"kid";
                           [self uploadWithOutImage];
                           
                       } dismissBlock:^{
                           
                           NSLog(@"user canceled. do nothing.");
                           
                           //                           FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
                           //                           configuration.allowRoundedArrow = !configuration.allowRoundedArrow;
                           
                       }];
    }
    
}

-(void)reloadForStatus{
    
    
    NSMutableDictionary *article = [[NSMutableDictionary alloc] init];

    article = [[childList objectAtIndex:selectedStatusIndex] mutableCopy];
    [article setValue:[NSString stringWithFormat:@"%@",[selectedStatusDict valueForKey:@"status_id"]] forKey:@"today_pickup_status"];
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:article];

    [childList replaceObjectAtIndex:selectedStatusIndex withObject:dict];
    [_kidsTableView reloadData];
}
- (IBAction)selectCommentBtnAction:(id)sender {
    [self makePostCallForPageNEWGET:TRIP_EXIST_MESSAGES withParams:nil withRequestCode:113];

}
- (void)zoomToUserLocation {
    // create a region object with the user's location as the center coordinate, and some
    // arbitrary value you'd like as the region span (.005 is one I use regularly)
    //    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.userLocation.coordinate, MKCoordinateSpanMake(0.005, 0.005));
    //    [_mapView setRegion:region animated:TRUE];
    //
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 3000, 3000);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:TRUE];
    
}
- (IBAction)userlocationbtnAction:(id)sender {
    [self zoomToUserLocation];
}
-(void)back{
    if([[APP_DELEGATE fromPushNotification] isEqual:@"YES"]){
        [APP_DELEGATE setIntialViewController];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
