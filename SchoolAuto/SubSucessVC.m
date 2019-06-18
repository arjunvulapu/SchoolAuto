//
//  SubSucessVC.m
//  SchoolAuto
//
//  Created by Apple on 15/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "SubSucessVC.h"
#import "ChildrenTC.h"
@interface SubSucessVC ()
{
    NSMutableArray *ItemList;
}
@end

@implementation SubSucessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"SUBSCRIPTIONS";

//    ItemList=[[NSMutableArray alloc] initWithObjects:@"KID NAME",@"AGE",@"CLASS",@"SCHOOL",@"HOME",@"SHARING",@"KMS", nil];
    // Do any additional setup after loading the view.
    ItemList=[[NSMutableArray alloc] initWithObjects:@"SUBSCRIPTION ID",@"KID NAME",@"AGE",@"CLASS",@"SCHOOL",@"HOME",@"SHARING",@"KMS",@"SUBSCRIPTION TYPE",@"DURATION", nil];

    NSLog(@"DIC-->%@",_subResult);
    
   NSString *rupee=@"\u20B9";

    _priceLbl.text=[NSString stringWithFormat:@"%@%@",rupee,[_subResult valueForKey:@"amount_paid"]];
    _amountView.layer.cornerRadius=10;
    _amountView.clipsToBounds=YES;
    
    if([_type  isEqual: @"success"])
    {
        _mainImage.image=[UIImage imageNamed:@"success"];
    }else{
        _mainImage.image=[UIImage imageNamed:@"failed"];

    }
}
//    if(_subResult.count==0){
//        [self makePostCallForPageNEWGET:ADDSUBSCRIPTIONS withParams:@{@"id":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];
//
//    }
//}
//
//-(void)parseResult:(id)result withCode:(int)reqeustCode{
//    if(reqeustCode==109){
//        NSLog(@"Result--%@",result);
//        _subResult=result[0];
//        [_listTableView reloadData];
//
//    }
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ItemList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *MyIdentifier = @"ChildrenTC";
    
    ChildrenTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.studentNameLbl.text=[NSString stringWithFormat:@"%@",[ItemList objectAtIndex:indexPath.row]];
    
        cell.studentNameLbl.text=[NSString stringWithFormat:@"%@",[ItemList objectAtIndex:indexPath.row]];
        if(indexPath.row==0){
            cell.statusLbl.text=[NSString stringWithFormat:@"%@",[_subResult valueForKey:@"kid_id"]];
        }
        else if(indexPath.row==1){
            cell.statusLbl.text=[NSString stringWithFormat:@"%@",[_subResult valueForKey:@"kid_name"]];
        }else if(indexPath.row==2){
            cell.statusLbl.text=[NSString stringWithFormat:@"%@",[_subResult valueForKey:@"kid_age"]];
        }else if(indexPath.row==3){
            cell.statusLbl.text=[NSString stringWithFormat:@"%@",[_subResult valueForKey:@"kid_class"]];
        }else if(indexPath.row==4){
            NSDictionary *s_dic=[_subResult valueForKey:@"school_info"];
            cell.statusLbl.text=[NSString stringWithFormat:@"%@\n%@,%@",[s_dic valueForKey:@"sch_name"],[s_dic valueForKey:@"sch_address"],[s_dic valueForKey:@"sch_city"]];
        }else if(indexPath.row==5){
            cell.statusLbl.text=[NSString stringWithFormat:@"%@",[_subResult valueForKey:@"pickup_address"]];
        }else if(indexPath.row==6){
            cell.statusLbl.text=[NSString stringWithFormat:@"%@",[_subResult valueForKey:@"share_count"]];
        }else if(indexPath.row==7){
            cell.statusLbl.text=[NSString stringWithFormat:@"%.2f",[[_subResult valueForKey:@"distance"] floatValue]];
        }
        else if(indexPath.row==8){
            cell.statusLbl.text=[NSString stringWithFormat:@"%@",[_subResult valueForKey:@"subscription_type"] ];
        }else if(indexPath.row==9){
            cell.statusLbl.text=[NSString stringWithFormat:@"%@ Days",[_subResult valueForKey:@"subscription_duration"]];
        }
    

    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
        _stableHeight.constant = _listTableView.contentSize.height;
    
    
}
-(void)back{
    [self.navigationController  popToRootViewControllerAnimated:YES];
}
@end
