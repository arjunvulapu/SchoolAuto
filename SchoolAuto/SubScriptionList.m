//
//  SubScriptionList.m
//  SchoolAuto
//
//  Created by Apple on 13/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "SubScriptionList.h"
#import "ChildrenTC.h"
#import "TrackVC.h"
#import "AddChildVC.h"
#import "SubScriptionDetailVC.h"
#import "AddLunchBoxVC.h"
@interface SubScriptionList ()
{
    UIButton *addButton;
    NSMutableArray *subList;
}
@end

@implementation SubScriptionList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    subList=[[NSMutableArray alloc] init];
    self.navigationItem.title=@"SUBSCRIPTIONS LIST";
    _emptyImage.hidden=YES;
    _addNewBtn.hidden=YES;
    _emptyLbl.hidden=YES;
    
    _emptyLbl.text = @"You have Empty Subscriptions";
    
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [buttonUser setImage:[UIImage imageNamed:@"leftarrow-black90"] forState:UIControlStateNormal];
    
    [addButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    
    addButton.frame = CGRectMake(0, 0, 30, 30);
    [addButton addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    customBarRightBtn.tintColor=[UIColor blueColor];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:0];
    
    //    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn,nil];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    backButtonView.bounds = CGRectOffset(backButtonView.bounds, -10, 0);
    
    [backButtonView addSubview:addButton];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
   // self.navigationItem.rightBarButtonItem = backButton;
    
    
    _addChildBtn.layer.cornerRadius=10;
    _addChildBtn.clipsToBounds=YES;
    
    _addLunchBoxBtn.layer.cornerRadius=10;
    _addLunchBoxBtn.clipsToBounds=YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    _emptyImage.hidden=YES;
    _addNewBtn.hidden=YES;
    _listTableView.hidden = NO;
    [self subSegmentAction:nil];
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==109){
        NSLog(@"Result--%@",result);
        subList=result;
        [_listTableView reloadData];
        if(subList.count==0){
            _emptyImage.hidden=NO;
            _addNewBtn.hidden=NO;
            _listTableView.hidden = YES;
            _emptyLbl.hidden=NO;

        }else{
            _emptyImage.hidden=YES;
            _addNewBtn.hidden=YES;
            _listTableView.hidden = NO;
            _emptyLbl.hidden=YES;

        }
            
    }
}
-(void)addBtnAction{
    AddChildVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AddChildVC"];
    [self PushToVc:vc];
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
    
    
    cell.studentNameLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"kid_name"]];
    if(_subSegement.selectedSegmentIndex==0){

    cell.statusLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"kid_id"]];
    }else{
        cell.statusLbl.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"carriage_id"]];

    }

    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubScriptionDetailVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SubScriptionDetailVC"];
    NSDictionary *dic =[subList objectAtIndex:indexPath.row];
    vc.kidorNot = [NSString stringWithFormat:@"%ld",(long)_subSegement.selectedSegmentIndex];
    vc.subResult =dic;
    [self PushToVc:vc];
    
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
    [self addBtnAction];
}
- (IBAction)subSegmentAction:(id)sender {
    if(_subSegement.selectedSegmentIndex==0){
        [self makePostCallForPageNEWGET:ADDSUBSCRIPTIONS withParams:@{@"pid":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];

    }else{
        [self makePostCallForPageNEWGET:ADD_LUNCHBOX_SUBSCRIPTIONS withParams:@{@"pid":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]]} withRequestCode:109];

    }
}
- (IBAction)addchildBtnAction:(id)sender {
    AddChildVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AddChildVC"];
    [self PushToVc:vc];
    
}
- (IBAction)addLunchBoxBtnAction:(id)sender {
    AddLunchBoxVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AddLunchBoxVC"];
    [self PushToVc:vc];
}
@end
