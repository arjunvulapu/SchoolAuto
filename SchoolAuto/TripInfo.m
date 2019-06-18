//
//  TripInfo.m
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TripInfo.h"
#import "TripInfoTC.h"
#import "Utils.h"
#import <BFRImageViewer/BFRImageViewController.h>
@interface TripInfo ()
{
    UIButton *addButton;
    
    NSMutableDictionary *resultDic;
    NSMutableArray *statusList;
    
}
@end

@implementation TripInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _subList=[[NSMutableArray alloc] init];
    self.navigationItem.title=@"TRIP INFO";
    _emptyImage.hidden=YES;
    _addNewBtn.hidden=YES;
    _emptyLbl.hidden=YES;
    self.navigationController.navigationBar.hidden=NO;

}
-(void)viewWillAppear:(BOOL)animated{
    _emptyImage.hidden=YES;
    _addNewBtn.hidden=YES;
    _listTableView.hidden = NO;
    _emptyLbl.hidden=YES;
    if([[APP_DELEGATE fromPushNotification] isEqual:@"YES"]){
        NSDictionary *pushDic=[APP_DELEGATE pushDict];

        [self makePostCallForPageNEWGET:GETTRIPSTATUS_FROMPUSH withParams:@{@"trip_id":[NSString stringWithFormat:@"%@",[pushDic valueForKey:@"type_id"]],@"pid":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];


    }else
    if([_from isEqualToString:@"Lunchbox"]){
    [self makePostCallForPageNEWGET:LUNCHBOX_GETTRIPSTATUS withParams:@{@"id":[NSString stringWithFormat:@"%@",_student_id]} withRequestCode:109];
    }else{
        [self makePostCallForPageNEWGET:GETTRIPSTATUS withParams:@{@"id":[NSString stringWithFormat:@"%@",_student_id]} withRequestCode:109];
    }
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==109){
        NSLog(@"Result--%@",result);
        if ([[result valueForKey:@"status"] isEqual:@0]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
        _subList=[result valueForKey:@"data"];
        [_listTableView reloadData];
        }
        if(_subList.count==0){
            _emptyImage.hidden=NO;
            _addNewBtn.hidden=NO;
            _emptyLbl.hidden=NO;

            _listTableView.hidden = YES;
        }else{
            resultDic = [_subList objectAtIndex:0];

            _emptyImage.hidden=YES;
            _addNewBtn.hidden=YES;
            _emptyLbl.hidden=YES;
            _listTableView.hidden = NO;
        }
    }
}
-(void)back{
    if([[APP_DELEGATE fromPushNotification] isEqual:@"YES"]){
        [APP_DELEGATE setIntialViewController];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return _subList.count>0?1:0;    //count of section
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *arr = [_subList valueForKey:@"trip_status"];
//    return arr.count;
    NSMutableDictionary *sdic =[_subList objectAtIndex:0];
    statusList =[sdic valueForKey:@"trip_status"];
    return statusList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSMutableDictionary *sdic =[_subList objectAtIndex:0];
//    NSMutableArray *sList =[sdic valueForKey:@"trip_status"];
    NSMutableDictionary *dic =[statusList objectAtIndex:indexPath.row];
    
    if([[dic valueForKey:@"dts_img"] isEqualToString:@""]){
    static NSString *MyIdentifier = @"TripInfoTCFirst";
    
    TripInfoTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if([[dic valueForKey:@"start"]  isEqual: @"true"]){
        cell.tripInfoLbl.text= @"Trip Started";
        cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];
        }else if([[dic valueForKey:@"end"]  isEqual: @"true"]){
            cell.tripInfoLbl.text= @"Trip Ended";
            cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];
        }else{
            cell.tripInfoLbl.text= [dic valueForKey:@"dts_comment"];
            cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];
        }



    return cell;
    }else{
        static NSString *MyIdentifier = @"TripInfoTC";
        
        TripInfoTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if([[dic valueForKey:@"start"]  isEqual: @"true"]){
            cell.tripInfoLbl.text= @"Trip Started";
            cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];
        }else if([[dic valueForKey:@"end"]  isEqual: @"true"]){
            cell.tripInfoLbl.text= @"Trip Ended";
            cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];
        }else{
            cell.tripInfoLbl.text= [dic valueForKey:@"dts_comment"];
            cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];
        }
//        cell.tripInfoLbl.text= [dic valueForKey:@"dts_comment"];
//        cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];

        [cell.tripImage setImageWithURL:[dic valueForKey:@"dts_img"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        cell.zoomImage = ^{
            BFRImageViewController *imageVC = [[BFRImageViewController alloc] initWithImageSource:@[[dic valueForKey:@"dts_img"] ]];
                
                [self presentViewController:imageVC animated:YES completion:nil];
            
        };
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 44)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSDictionary *sdic =[_subList objectAtIndex:section];
//    /* Section header is in 0th index... */
//    [label setText:[sdic valueForKey:@"date"]];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor clearColor]]; //your background color...
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//{
//    return 44;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addNewBtnAction:(id)sender {
}
@end
