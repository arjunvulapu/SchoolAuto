//
//  MyAccountVC.m
//  SchoolAuto
//
//  Created by Apple on 14/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MyAccountVC.h"
#import "MyAccountTC.h"
#import "SubScriptionList.h"
#import "ChangePasswordVC.h"
@interface MyAccountVC ()
{
    NSMutableArray *menuList;
    NSMutableArray *menuImages;
    NSMutableArray *offersList;

}
@end

@implementation MyAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [currentDefaults objectForKey:@"BANNERS"];
    NSDictionary *bannersDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    offersList =[bannersDict valueForKey:@"offers"];
    menuList=[[NSMutableArray alloc] initWithObjects:@"MY PROFILE",@"SUBSCRIPTIONS",@"CHANGE PASSWORD",@"LOGOUT", nil];
    menuImages=[[NSMutableArray alloc] initWithObjects:@"muser",@"mcalendar",@"changepass",@"mlogout", nil];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *MyIdentifier = @"MyAccountTC";
    
    MyAccountTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell.menuImage.image=[UIImage imageNamed:[menuImages objectAtIndex:indexPath.row]];
    cell.menutitle.text=[NSString stringWithFormat:@"%@",[menuList objectAtIndex:indexPath.row]];

    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==3){
        [self logoutButtonPressed];
    } else  if(indexPath.row==1){
        SubScriptionList *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SubScriptionList"];
        [self PushToVc:vc];
    }else  if(indexPath.row==2){
        ChangePasswordVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordVC"];
        [self PushToVc:vc];
    }else  if(indexPath.row==0){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
- (void)logoutButtonPressed
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Logout"
                                 message:@"Are You Sure Want to Logout!"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                    [self clearAllData];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)clearAllData{
    [Utils logoutUser];
    [APP_DELEGATE afterLoginLogOut];
}

@end
