//
//  HomeViewController.m
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "HomeViewController.h"
#import "ParentLoginVC.h"
#import "DriverLoginVC.h"
#import "LunchBoxLoginVC.h"
#import <CoreLocation/CoreLocation.h>
@interface HomeViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;

}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _parentbtn.layer.cornerRadius=_parentbtn.frame.size.height/2;
    _parentbtn.clipsToBounds=YES;
    _driverBtn.layer.cornerRadius=_driverBtn.frame.size.height/2;
    _driverBtn.clipsToBounds=YES;
    _lunchBoxBtn.layer.cornerRadius=_driverBtn.frame.size.height/2;
    _lunchBoxBtn.clipsToBounds=YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [self->locationManager requestWhenInUseAuthorization];
    if ([self->locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self->locationManager requestWhenInUseAuthorization];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)parentBtnAction:(id)sender {
    ParentLoginVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ParentLoginVC"];
    [self PushToVc:vc];

}

- (IBAction)driverbtnAction:(id)sender {
    DriverLoginVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"DriverLoginVC"];
    [self PushToVc:vc];
}
- (IBAction)lunchboxBtnAction:(id)sender {
    
    LunchBoxLoginVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LunchBoxLoginVC"];
    [self PushToVc:vc];
}

- (IBAction)poweredbyBtnAction:(id)sender;
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"https://www.develappsolutions.com"]]];
}
@end
