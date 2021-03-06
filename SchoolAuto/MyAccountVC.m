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
#import "TarrifsVC.h"
#import "AboutUsViewController.h"
#import "MyProfileVC.h"
#import "ParentEditVC.h"
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
    menuList=[[NSMutableArray alloc] initWithObjects:@"MY ACCOUNT",@"SUBSCRIPTIONS",@"CHANGE PASSWORD",@"EDIT PROFILE",@"ABOUT US",@"POLICIES",@"FAQ's",@"CUSTOMER CARE NUMBER",@"LOGOUT", nil];
    menuImages=[[NSMutableArray alloc] initWithObjects:@"muser",@"mcalendar",@"changepass",@"edit",@"about",@"privacy",@"faq",@"customer",@"mlogout", nil];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuList.count;
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
    if(indexPath.row==0){
    MyProfileVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileVC"];
    [self PushToVc:vc];
    }else if(indexPath.row==1){
        SubScriptionList *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SubScriptionList"];
        [self PushToVc:vc];
//    }else  if(indexPath.row==2){
//        TarrifsVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TarrifsVC"];
//        [self PushToVc:vc];
    }else  if(indexPath.row==2){
        ChangePasswordVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordVC"];
        [self PushToVc:vc];
    }else  if(indexPath.row==3){
        ParentEditVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ParentEditVC"];
        [self PushToVc:vc];
    }
    else  if(indexPath.row==4){
        AboutUsViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        vc.from = @"about";
        [self PushToVc:vc];
        
    }else  if(indexPath.row==5){
        AboutUsViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        vc.from = @"terms";

        [self PushToVc:vc];
        
    }else  if(indexPath.row==6){
        AboutUsViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        vc.from = @"faqs";

        [self PushToVc:vc];
        
    }else  if(indexPath.row==7){
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [currentDefaults objectForKey:@"SETTINGS"];
        NSArray *infoarr = [NSKeyedUnarchiver unarchiveObjectWithData:data];

        NSString *phoneNumber = @"";
        for (NSDictionary *dic in infoarr) {
            if([[dic valueForKey:@"content_type"] isEqual:@"phone"]){
                phoneNumber = [dic valueForKey:@"content_matter"];
                break;
            }
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]];

        
    }else if(indexPath.row==8){
        [self logoutButtonPressed];
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
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==1001){
        NSLog(@"push registered:%@",result);
    }
}
-(void)clearAllData{
    [Utils logoutUser];
    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"USERINFO"];
    [defaults synchronize];
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]:@"";
    NSString *playerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]:@"";
    [self makePostCallForPageNEW:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"dev_type":@"ios",@"type":@"",@"member_id":[Utils loggedInUserIdStr]} withRequestCode:1001];
    [APP_DELEGATE afterLoginLogOut];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
        _tableViewHeight.constant=_listTableView.contentSize.height;
    
    
}
-(NSString *)stringByStrippingHTML:(NSString *)inputStr {
    NSArray *components = [inputStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    for (int i = 0; i < [components count]; i = i + 2) {
        [componentsToKeep addObject:[components objectAtIndex:i]];
    }
    
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    return plainText;
}
@end
