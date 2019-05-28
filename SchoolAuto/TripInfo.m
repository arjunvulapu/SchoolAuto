//
//  TripInfo.m
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TripInfo.h"
#import "TripInfoTC.h"
@interface TripInfo ()
{
    UIButton *addButton;
    NSMutableArray *subList;
}
@end

@implementation TripInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    subList=[[NSMutableArray alloc] init];
    self.navigationItem.title=@"TRIP INFO";
    _emptyImage.hidden=YES;
    _addNewBtn.hidden=YES;
    
    

    
}
-(void)viewWillAppear:(BOOL)animated{
    _emptyImage.hidden=YES;
    _addNewBtn.hidden=YES;
    _listTableView.hidden = NO;
    [self makePostCallForPageNEWGET:GETTRIPSTATUS withParams:@{@"id":[NSString stringWithFormat:@"%@",_student_id]} withRequestCode:109];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==109){
        NSLog(@"Result--%@",result);
        if ([[result valueForKey:@"status"] isEqual:@0]) {
            NSString *str=[result valueForKey:@"message"];
            [self showErrorAlertWithMessage:Localized(str)];
        } else {
        subList=[result valueForKey:@"data"];
        [_listTableView reloadData];
        }
//        if(subList.count==0){
//            _emptyImage.hidden=NO;
//            _addNewBtn.hidden=NO;
//            _listTableView.hidden = YES;
//        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return subList.count;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *arr = [subList valueForKey:@"trip_status"];
//    return arr.count;
    NSMutableDictionary *sdic =[subList objectAtIndex:section];
    NSMutableArray *sList =[sdic valueForKey:@"trip_status"];
    return sList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *sdic =[subList objectAtIndex:indexPath.section];
    NSMutableArray *sList =[sdic valueForKey:@"trip_status"];
    NSMutableDictionary *dic =[sList objectAtIndex:indexPath.row];

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
        }else if([[dic valueForKey:@"End"]  isEqual: @"true"]){
            cell.tripInfoLbl.text= @"Trip Ended";
            cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];
        }else{
            cell.tripInfoLbl.text= [dic valueForKey:@"dts_comment"];
            cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];
        }
//        cell.tripInfoLbl.text= [dic valueForKey:@"dts_comment"];
//        cell.createdDateInfoLbl.text= [dic valueForKey:@"created"];

        [cell.tripImage setImageWithURL:[dic valueForKey:@"dts_img"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 44)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSDictionary *sdic =[subList objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:[sdic valueForKey:@"date"]];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 44;
}
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
