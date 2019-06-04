//
//  LunchBoxTripsListVC.m
//  SchoolAuto
//
//  Created by Apple on 15/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "LunchBoxTripsListVC.h"
#import "ChildrenTC.h"
#import "LunchBoxTripVC.h"
#import "TrackListVC.h"
#import "StartTripTC.h"
#import "Common.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface LunchBoxTripsListVC ()
{
    NSMutableArray *tripsList;
    NSDictionary *selectedTrip;
}
@end

@implementation LunchBoxTripsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"LUNCH TRIP LIST'S";
    tripsList=[[NSMutableArray alloc] init];
//    [self makePostCallForPageNEWGET:TRIPSLIST withParams:@{@"auto_id":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];

}
-(void)viewWillAppear:(BOOL)animated{
    [self makePostCallForPageNEWGET:LUNCHBOX_TRIPSLIST withParams:@{@"auto_id":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];

}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    NSLog(@"Result--%@",result);

    if(reqeustCode==109){
        tripsList=result;
        [_listTableView reloadData];
    }else if(reqeustCode==110){
        LunchBoxTripVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LunchBoxTripVC"];
        vc.tripDict =selectedTrip;
        [self PushToVc:vc];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tripsList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =[tripsList objectAtIndex:indexPath.row];
    if([[dic valueForKey:@"today_trip_status"] isEqual:@"not started"]){
        static NSString *MyIdentifier = @"StartTripTC";

        StartTripTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        NSDictionary *dic =[tripsList objectAtIndex:indexPath.row];
        cell.bgView.backgroundColor =[UIColor colorWithRed:8/255.0f green:102/255.0f blue:198/255.0f alpha:1];

        
        cell.studentNameLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_name"]];
//        cell.statusLbl.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_type"]];
        cell.statusLbl.text=@"";

        cell.startTrip = ^{
            selectedTrip = dic;
          //  [self makePostCallForPageNEWFormData:TRIP_STATUS withParams:@{@"trip_id":[NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_id"]],@"start":@"true"} withRequestCode:110];
            
            [self uploadStatusWith:[NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_id"]]];
        };
        return cell;
    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"in progress"]){
        static NSString *MyIdentifier = @"ChildrenTC";
        
        ChildrenTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        NSDictionary *dic =[tripsList objectAtIndex:indexPath.row];
        cell.bgView.backgroundColor =[UIColor colorWithRed:244/255.0f green:153/255.0f blue:23/255.0f alpha:1];

        
        cell.studentNameLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_name"]];
       // cell.statusLbl.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_type"]];
        cell.statusLbl.text=@"";

        return cell;
        
    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"ended"]){
        static NSString *MyIdentifier = @"ChildrenTC";
        
        ChildrenTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        NSDictionary *dic =[tripsList objectAtIndex:indexPath.row];
        cell.bgView.backgroundColor =[UIColor colorWithRed:35/255.0f green:191/255.0f blue:8/255.0f alpha:1];

        
        cell.studentNameLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_name"]];
        //cell.statusLbl.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_type"]];
        cell.statusLbl.text=@"";

        return cell;
        
//    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"not assigned"]){
    }else{
        static NSString *MyIdentifier = @"ChildrenTC";
        
        ChildrenTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        NSDictionary *dic =[tripsList objectAtIndex:indexPath.row];
        
        cell.bgView.backgroundColor =[UIColor colorWithRed:134/255.0f green:142/255.0f blue:150/255.0f alpha:1];

        cell.studentNameLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_name"]];
        //cell.statusLbl.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"trip_type"]];
        cell.statusLbl.text=@"";
        return cell;
        
    }
    
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LunchBoxTripVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LunchBoxTripVC"];
    NSDictionary *dic =[tripsList objectAtIndex:indexPath.row];
    vc.tripDict =dic;
    [self PushToVc:vc];
    
}
-(void)uploadStatusWith:(NSString *)trip{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", SERVER_URL,LUNCHBOX_TRIP_STATUS]];
   
    NSDictionary *parameters = @{@"trip_id":[NSString stringWithFormat:@"%@",trip],@"start":@"true"};
    
    
   
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager POST:URL.absoluteString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
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
                  LunchBoxTripVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LunchBoxTripVC"];
                  vc.tripDict =selectedTrip;
                  [self PushToVc:vc];
              }else{
                  NSLog(@"Error: %@", [dict valueForKey:@"message"]);
                  
              }
              
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}
@end
