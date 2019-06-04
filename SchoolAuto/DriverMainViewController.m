//
//  DriverMainViewController.m
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "DriverMainViewController.h"
#import "HomeMainCC.h"
#import "AdsCC.h"
#import "TarrifsVC.h"
#import "TripsListVC.h"
#import "AddChildVC.h"
#import "DriverCardVC.h"
#import "MyAccountVC.h"
#import "LunchBoxListVC.h"
#import "LunchBoxTripsListVC.h"
@interface DriverMainViewController ()<SBSliderDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *mainCatList;
    NSMutableArray *mainCatImages;
    NSMutableArray *offersList;
    SBSliderView *slider;
    CLLocationManager *locationManager;


}
@end

@implementation DriverMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    offersList=[[NSMutableArray alloc]init];
    NSMutableArray *imagesArray=[[NSMutableArray alloc]init];
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [currentDefaults objectForKey:@"BANNERS"];
    NSDictionary *bannersDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray *bannerslist =[bannersDict valueForKey:@"banners"];
    offersList =[bannersDict valueForKey:@"offers"];
    for(NSDictionary *dict in bannerslist){
        [imagesArray addObject:[dict valueForKey:@"banner_image"]];
    }
    _homemainCollectionView.layer.cornerRadius=10;
   _homemainCollectionView.clipsToBounds=YES;
//    [_slider2 startAutoPlay];
//    _slider2.delegate = self;
//    [_slider2 createSliderWithImages:imagesArray WithAutoScroll:YES inView:self.bannerView];
   // _sliderheight.constant = self.view.frame.size.width*2/3;
    // cat loading from static data
    
    slider = [[[NSBundle mainBundle] loadNibNamed:@"SBSliderView" owner:self options:nil] firstObject];
    slider.delegate = self;
    [slider startAutoPlay];
    
    [self.bannerView addSubview:slider];
    slider.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*2/3);

    slider.sliderHeight.constant =[UIScreen mainScreen].bounds.size.width*2/3;

    [slider createSliderWithImages:imagesArray WithAutoScroll:_AUTO_SCROLL_ENABLED inView:self.bannerView];
    
    mainCatList=[[NSMutableArray alloc] init];
    if([[Utils loggedInUserType]  isEqual: @"Lunchbox"]){

    [mainCatList addObject:@"ORDERS LIST"];
    }else{
        [mainCatList addObject:@"TRIPS"];

    }
    [mainCatList addObject:@"MYPROFILE"];
  //  [mainCatList addObject:@"TARRIFS"];
    [mainCatList addObject:@"LOGOUT"];

    mainCatImages=[[NSMutableArray alloc] init];
    [mainCatImages addObject:@"route"];
    [mainCatImages addObject:@"muser"];
   // [mainCatImages addObject:@"india-rupee-currency-symbol"];
    [mainCatImages addObject:@"mlogout"];
    
    
    _adsCollectionView.delegate=self;
    _adsCollectionView.dataSource=self;
    _adsCollectionView.backgroundColor=[UIColor clearColor];
    //_sliderheight.constant = self.view.frame.size.width*2/3;
    self.navigationController.navigationBar.hidden=YES;
    
    _mainBg.layer.cornerRadius=10;

    [_mainBg.layer setShadowColor:[UIColor blackColor].CGColor];
    [_mainBg.layer setShadowOpacity:0.2];
    [_mainBg.layer setShadowRadius:5.0];
    [_mainBg.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]:@"";
    NSString *playerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]:@"";
    if([[Utils loggedInUserType]  isEqual: @"Lunchbox"]){

    [self makePostCallForPageNEWNoProgess:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"dev_type":@"ios",@"type":@"lunchbox",@"member_id":[Utils loggedInUserIdStr]}
                          withRequestCode:1001];
    }else{
        [self makePostCallForPageNEWNoProgess:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"dev_type":@"ios",@"type":@"driver",@"member_id":[Utils loggedInUserIdStr]}
                              withRequestCode:1001];
    }
    
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==1001){
        NSLog(@"Push Register%@",result);
    }
}
-(void)viewWillAppear:(BOOL)animated{
  //  _sliderheight.constant = self.view.frame.size.width*2/3;
     self.navigationController.navigationBar.hidden=YES;
    _slider2.frame = _bannerView.bounds;
}
- (void)sbslider:(SBSliderView *)sbslider didTapOnImage:(UIImage *)targetImage andParentView:(UIImageView *)targetView {
    
    // SBPhotoManager *photoViewerManager = [[SBPhotoManager alloc] init];
    //[photoViewerManager initializePhotoViewerFromViewControlller:self forTargetImageView:targetView withPosition:sbslider.frame];
    
    
}

- (void)sbslider:(SBSliderView *)sbslider didTapOnImage:(UIImage *)targetImage andParentView:(UIImageView *)targetView withTag:(NSInteger)Number{
    
    NSLog(@"------%ld",(long)Number);
    //NSMutableDictionary *dict=[banners objectAtIndex:Number];
    //NSMutableDictionary *dic=[dict valueForKey:@"company"];
    
    //    ProductsListViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductsListViewController"];
    //    obj.from=@"shop";
    //    obj.catid=[dic valueForKey:@"id"];
    //    obj.pTitle=[dic valueForKey:@"title"];
    //    [self.navigationController pushViewController:obj animated:YES];
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView==_homemainCollectionView){

    return mainCatList.count;
    }else{
        return offersList.count;

    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView==_homemainCollectionView){
    _collectionViewheight.constant=_homemainCollectionView.contentSize.height;
        HomeMainCC *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMainCC" forIndexPath:indexPath];
        ccell.catTitle.text = [NSString stringWithFormat:@"%@",[mainCatList objectAtIndex:indexPath.row]];
    ccell.catImage.image=[UIImage imageNamed:[mainCatImages objectAtIndex:indexPath.row]];
    ccell.borderView.layer.cornerRadius=10;
    ccell.borderView.clipsToBounds=YES;
    ccell.borderView.layer.borderColor=[UIColor colorWithRed:215/255.0f green:158/255.0f blue:62/255.0f alpha:1.0].CGColor;
    ccell.borderView.layer.borderWidth=1;
        return ccell;
    }else{           _adsCollectionViewHeight.constant=_adsCollectionView.contentSize.height;
            AdsCC *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdsCC" forIndexPath:indexPath];
        ccell.adsImage.layer.cornerRadius=10;
        ccell.adsImage.clipsToBounds=YES;
        NSDictionary *dict = [offersList objectAtIndex:indexPath.row];
        [ccell.adsImage setImageWithURL:[dict valueForKey:@"offer_image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            return ccell;
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if(collectionView==_homemainCollectionView){
        if([[Utils loggedInUserType]  isEqual: @"Lunchbox"]){

    if(indexPath.row==0){
        LunchBoxTripsListVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LunchBoxTripsListVC"];
        [self PushToVc:vc];
    
    }
    else  if(indexPath.row==1){
        DriverCardVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"DriverCardVC"];
        [self PushToVc:vc];
    } else  if(indexPath.row==2){
//        [Utils logoutUser];
//        [APP_DELEGATE afterLoginLogOut];
//        MyAccountVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"MyAccountVC"];
//        [self PushToVc:vc];
        [self logoutButtonPressed];
    }
    else{
    TarrifsVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TarrifsVC"];
    [self PushToVc:vc];
    }
        }else{
            
            if(indexPath.row==0){
                TripsListVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TripsListVC"];
                [self PushToVc:vc];
                
            }
            else  if(indexPath.row==1){
                DriverCardVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"DriverCardVC"];
                [self PushToVc:vc];
            } else  if(indexPath.row==2){
                //        [Utils logoutUser];
                //        [APP_DELEGATE afterLoginLogOut];
                //        MyAccountVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"MyAccountVC"];
                //        [self PushToVc:vc];
                [self logoutButtonPressed];
            }
            else{
                TarrifsVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TarrifsVC"];
                [self PushToVc:vc];
            }
        }
    }else{
        NSDictionary *dict = [offersList objectAtIndex:indexPath.row];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"offer_url"]]]];
        
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView==_adsCollectionView){
        return CGSizeMake((CGRectGetWidth(collectionView.frame)/2)-16, (CGRectGetHeight(collectionView.frame)/2)-16);

    }else{
    if(indexPath.row==2){
        return CGSizeMake((CGRectGetWidth(collectionView.frame))-16, (CGRectGetHeight(collectionView.frame)/2)-16);

    }else{
        return CGSizeMake((CGRectGetWidth(collectionView.frame)/2)-16, (CGRectGetHeight(collectionView.frame)/2)-16);
    }
    }
 
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 4.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(12, 12, 12, 12);
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

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"USERINFO"];
    [defaults synchronize];
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]:@"";
    NSString *playerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]:@"";
    [self makePostCallForPageNEW:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"dev_type":@"ios",@"type":@"",@"member_id":[Utils loggedInUserIdStr]} withRequestCode:1001];
    
    [APP_DELEGATE afterLoginLogOut];
}
-(void)viewDidAppear:(BOOL)animated{
    [locationManager requestWhenInUseAuthorization];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
}
- (IBAction)poweredbyBtnAction:(id)sender;
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"https://www.develappsolutions.com"]]];
}
@end
