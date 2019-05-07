//
//  ParentLoginVC.m
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ParentLoginVC.h"
#import "Common.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Utils.h"
#import "PECropViewController.h"
#import <ImageIO/ImageIO.h>
#import <CoreLocation/CoreLocation.h>
@interface ParentLoginVC ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *ceo;
    CLPlacemark *placemark;
}
@end

@implementation ParentLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"Parent Login";
  
    // border radius
    [_loginView.layer setCornerRadius:20.0f];
    
    // border
//    [_loginView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [_loginView.layer setBorderWidth:1.5f];
    
    // drop shadow
    [_loginView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_loginView.layer setShadowOpacity:0.2];
    [_loginView.layer setShadowRadius:5.0];
    [_loginView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];

    _submitBtn.layer.cornerRadius=10;
    _submitBtn.clipsToBounds=YES;
    
    
    _signupBtn.layer.cornerRadius=10;
    _signupBtn.clipsToBounds=YES;

    
    self->locationManager = [[CLLocationManager alloc]init];
    self->locationManager.delegate = self;
    [locationManager startUpdatingLocation];
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
                  [locationManager stopUpdatingLocation];
              }
     
     ];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  self->placemark = [placemarks objectAtIndex:0];
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
                  [locationManager stopUpdatingLocation];
              }
     
     ];

}
    /*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitBtnAction:(id)sender {
}

- (IBAction)forgotPasswordbtnAction:(id)sender {
}
- (IBAction)signupBtnAction:(id)sender {
   // [self imageSelection:sender];
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
                  [locationManager stopUpdatingLocation];
              }
     
     ];

    // if (!_userPicker) {
    _userPicker = [[UIImagePickerController alloc] init];
    _userPicker.delegate = self;
    //}
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:Localized(@"Select Image") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"Camera") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _userPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_userPicker animated:YES completion:nil];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"Gallery") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _userPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_userPicker animated:YES completion:nil];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:Localized(@"Cancel") style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}
//- (void)imagePickerController:(UIImagePickerController *)picker2 didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//
//    PECropViewController *controller = [[PECropViewController alloc] init];
//    controller.image = image;
//    controller.delegate = self;
//    controller.keepingCropAspectRatio = YES;
//    controller.toolbarHidden = YES;
//
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
//    [self presentViewController:navigationController animated:YES completion:NULL];
//}
//
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
        user_uiimage = image;
        
        
    }
}
UIImage *user_uiimage;
- (void)uploadImagesWithProgressWithId:(NSString *)adId {
    
    //http://clients.yellowsoft.in/lawyers/api/add-member-image.php
    
    NSString *serverURL = [NSString stringWithFormat:@"%@/%@", SERVER_URL,@"EDIT_PROFILE_IMAGE"];
    
    NSDictionary *parameters = @{@"member_id":adId};
    
    
    //    UIImage *image = user_uiimage;
    UIImage *image = [UIImage imageWithCGImage:user_uiimage.CGImage scale:0.25 orientation:user_uiimage.imageOrientation];
    
    
    if (image == nil) {
        [self hideHUD];
        [Utils showAlertWithMessage:[MCLocalization stringForKey:@"SignUp Sucessfully"]];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    
    // image = [image resizedImageToFitInSize:CGSizeMake(960, 640) scaleIfSmaller:NO];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:serverURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                    name:@"file"
                                fileName:@"file.png"
                                mimeType:@"image/png"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    
    uploadTask = [manager uploadTaskWithStreamedRequest:request
                                               progress:^(NSProgress * _Nonnull uploadProgress) {
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       [SVProgressHUD showProgress:uploadProgress.fractionCompleted];
                                                   });
                                               }
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          if (error) {
                                              NSLog(@"Failure %@", error.description);
                                              [self hideHUD];
                                              [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"error_while_posting_ad"]];
                                              
                                          } else {
                                              
                                              NSLog(@"Success %@", responseObject);
                                              
                                              [self hideHUD];
                                              [Utils showAlertWithMessage:[MCLocalization stringForKey:@"SignUp Sucessfully"]];
                                              [self.navigationController popViewControllerAnimated:YES];
                                          }
                                      }];
    
    
    
    [uploadTask resume];
}

// Ensure you've set yourself as the UIImagePickerController delegate to ensure this method is called
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    image = [self imageWithRenderedDateMetadata:info[UIImagePickerControllerMediaMetadata]
                                        onImage:image];
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
    CGRect rect = CGRectMake(100, image.size.height-300, image.size.width,200);
    [[UIColor whiteColor] set];
    NSDictionary* attributes = @{NSFontAttributeName :[UIFont boldSystemFontOfSize:100],
                                 NSStrokeColorAttributeName : [UIColor blackColor],
                                 NSForegroundColorAttributeName : [UIColor yellowColor],
                                 NSStrokeWidthAttributeName : @-2.0};
    

    [dateString drawInRect:rect withAttributes:attributes];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _user_image.image=newImage;

    return newImage;
}
@end
