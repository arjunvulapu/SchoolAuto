//
//  DriverCardVC.m
//  SchoolAuto
//
//  Created by Apple on 07/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "DriverCardVC.h"

@interface DriverCardVC ()
{
    CLLocationCoordinate2D annotationViewCoordinate ;
    
    BOOL zoomed;
    NSMutableDictionary *driverDict;
}
@property (strong, nonatomic) MKPlacemark *destination;
@property (strong,nonatomic) MKPlacemark *source;

@end

@implementation DriverCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView.delegate=self;
    // [self getDirections];
    [_mapView setShowsUserLocation:YES];
    zoomed = NO;
    annotationViewCoordinate = CLLocationCoordinate2DMake([[[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_latitude"] floatValue], [[[_resultDic valueForKey:@"school_info"] valueForKey:@"sch_longitude"] floatValue]);
    //[self GetDirections:annotationViewCoordinate];
    
    // rounded corneres
    
    _driverImage.layer.cornerRadius=10;
   // _driverImage.clipsToBounds=YES;
    
    _driverView.layer.cornerRadius=10;
  //  _driverView.clipsToBounds=YES;
    
    _detailsView.layer.cornerRadius=10;
    //_detailsView.clipsToBounds=YES;
    
    _locationView.layer.cornerRadius=10;
    _locationView.clipsToBounds=YES;
    _mapView.layer.cornerRadius=10;
    _mapView.clipsToBounds=YES;
    
    self.title = @"Children Track";
    
    // drop shadow
    _driverImageBg.layer.cornerRadius=10;

    [_driverView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_driverView.layer setShadowOpacity:0.2];
    [_driverView.layer setShadowRadius:5.0];
    [_driverView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    [_driverImageBg.layer setShadowColor:[UIColor blackColor].CGColor];
    [_driverImageBg.layer setShadowOpacity:0.2];
    [_driverImageBg.layer setShadowRadius:5.0];
    [_driverImageBg.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    
    [self makePostCallForPageNEWGET:AUTOINFO withParams:@{@"id":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];


    _autoId.text=[NSString stringWithFormat:@"%@",@""];
    _driverName.text=[NSString stringWithFormat:@"%@",@""];
    _driverPhoneNumber.text=[NSString stringWithFormat:@"%@",@""];
    _driverEmail.text=[NSString stringWithFormat:@"%@",@""];
    _driverAddress.text=[NSString stringWithFormat:@"%@",@""];
    
}

-(void)loadAutoDetails{
    _autoId.text=[NSString stringWithFormat:@"%@",[driverDict   valueForKey:@"auto_regno"]];
    _driverName.text=[NSString stringWithFormat:@"%@",[driverDict   valueForKey:@"auto_driver"]];
    _driverPhoneNumber.text=[NSString stringWithFormat:@"%@",[driverDict   valueForKey:@"auto_driver_phone"]];
    _driverEmail.text=[NSString stringWithFormat:@"%@",[driverDict   valueForKey:@"auto_driver_email"]];
    _driverAddress.text=[NSString stringWithFormat:@"%@",[driverDict   valueForKey:@"auto_driver_address"]];
    [_manImage setImageWithURL:[driverDict   valueForKey:@"auto_driver_img"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==109){
        NSLog(@"%@",result);
        driverDict=result[0];
        [self loadAutoDetails];
        
    }
}

@end
