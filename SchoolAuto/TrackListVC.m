//
//  TrackListVC.m
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TrackListVC.h"
#import "ChildrenTC.h"
#import "TrackVC.h"
#import "TripInfo.h"
@interface TrackListVC ()
{
    NSMutableArray *subList;

}
@end

@implementation TrackListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _emptyImage.hidden=YES;
    self.navigationItem.title=@"LIVE TRACKING";
    subList=[[NSMutableArray alloc] init];

    [self makePostCallForPageNEWGET:ADDSUBSCRIPTIONS withParams:@{@"pid":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];

}
-(void)viewWillAppear:(BOOL)animated{
    [_listTableView reloadData];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==109){
        NSLog(@"Result--%@",result);
        subList=result;
        [_listTableView reloadData];
        if(subList.count==0){
            _emptyImage.hidden=NO;
            _listTableView.hidden=YES;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return subList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
            
            static NSString *MyIdentifier = @"ChildrenTC";
            
            ChildrenTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    NSDictionary *dic =[subList objectAtIndex:indexPath.row];
    
//    if([[dic valueForKey:@"today_trip_status"] isEqual:@"not started"]){
//        cell.bgView.backgroundColor =[UIColor blueColor];
//        cell.userInteractionEnabled = false;
//    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"in progress"]){
//        cell.bgView.backgroundColor =[UIColor yellowColor];
//        cell.userInteractionEnabled = true;
//
//    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"ended"]){
//        cell.bgView.backgroundColor =[UIColor redColor];
//        cell.userInteractionEnabled = false;
//
//    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"not assigned"]){
//        cell.bgView.backgroundColor =[UIColor brownColor];
//        cell.userInteractionEnabled = false;
//
//    }
    if([[dic valueForKey:@"today_trip_status"] isEqual:@"not started"]){
        cell.bgView.backgroundColor =[UIColor colorWithRed:8/255.0f green:102/255.0f blue:198/255.0f alpha:1];
    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"in progress"]){
        cell.bgView.backgroundColor =[UIColor colorWithRed:244/255.0f green:153/255.0f blue:23/255.0f alpha:1];
        
    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"ended"]){
        cell.bgView.backgroundColor =[UIColor colorWithRed:35/255.0f green:191/255.0f blue:8/255.0f alpha:1];
        
    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"not assigned"]){
        cell.bgView.backgroundColor =[UIColor colorWithRed:134/255.0f green:142/255.0f blue:150/255.0f alpha:1];
        
    }
    cell.studentNameLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"kid_name"]];
    cell.statusLbl.text = [NSString stringWithFormat:@"%@",@""];
    cell.infoBtnPressed = ^{
        TripInfo *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TripInfo"];
        vc.student_id=[dic valueForKey:@"subscription_id"];
        vc.from = @"Driver";

        [self PushToVc:vc];
    };
            return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic =[subList objectAtIndex:indexPath.row];

    if([[dic valueForKey:@"today_trip_status"] isEqual:@"not started"]){
        [self showErrorAlertWithMessage:@"Trip Not Started"];
    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"in progress"]){
        TrackVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TrackVC"];
        vc.resultDic=[subList objectAtIndex:indexPath.row];
        [self PushToVc:vc];
    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"ended"]){
        [self showErrorAlertWithMessage:@"Trip Ended"];

    }else if([[dic valueForKey:@"today_trip_status"] isEqual:@"not assigned"]){
        [self showErrorAlertWithMessage:@"Trip Not Assigned"];

    }
   
    
}
@end
