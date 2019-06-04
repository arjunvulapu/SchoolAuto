//
//  MainViewController.m
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MainViewController.h"
#import "HomeMainCC.h"
#import "AdsCC.h"
#import "TarrifsVC.h"
#import "TrackListVC.h"
#import "AddChildVC.h"
#import "SubScriptionList.h"
#import "MyAccountVC.h"
#import "LunchBoxListVC.h"
@interface MainViewController ()<SBSliderDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *mainCatList;
    NSMutableArray *mainCatImages;
    NSMutableArray *offersList;
    SBSliderView *slider;
    CLLocationManager *locationManager;


}
@end

@implementation MainViewController

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
    
//        [imagesArray addObject:@"banner"];
//    [imagesArray addObject:@"banner"];
//    [imagesArray addObject:@"banner"];
    _homemainCollectionView.layer.cornerRadius=10;
    _homemainCollectionView.clipsToBounds=YES;
//    [_slider2 startAutoPlay];
//    _slider2.delegate = self;
//    [_slider2 createSliderWithImages:imagesArray WithAutoScroll:YES inView:self.view];
   // _slider2.backgroundColor=[UIColor redColor];
//    _sliderHeight.constant = self.view.frame.size.width*2/3;

    slider = [[[NSBundle mainBundle] loadNibNamed:@"SBSliderView" owner:self options:nil] firstObject];
    slider.delegate = self;
    [slider startAutoPlay];

    [self.bannerView addSubview:slider];
    slider.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*2/3);
    slider.sliderHeight.constant =[UIScreen mainScreen].bounds.size.width*2/3;
    [slider createSliderWithImages:imagesArray WithAutoScroll:_AUTO_SCROLL_ENABLED inView:self.bannerView];
    
    // cat loading from static data
    mainCatList=[[NSMutableArray alloc] init];
    [mainCatList addObject:@"TRACK"];
    [mainCatList addObject:@"SUBSCRIPTION"];
    [mainCatList addObject:@"LUNCHBOX"];
    [mainCatList addObject:@"ACCOUNT"];

    mainCatImages=[[NSMutableArray alloc] init];
    [mainCatImages addObject:@"route"];
    [mainCatImages addObject:@"calendar"];
    [mainCatImages addObject:@"lunchbox"];
    [mainCatImages addObject:@"user-protection"];
    
    
    _adsCollectionView.delegate=self;
    _adsCollectionView.dataSource=self;
    _adsCollectionView.backgroundColor=[UIColor clearColor];
    
    _mainCollectionViewBgView.layer.cornerRadius=10;

    [_mainCollectionViewBgView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_mainCollectionViewBgView.layer setShadowOpacity:0.2];
    [_mainCollectionViewBgView.layer setShadowRadius:5.0];
    [_mainCollectionViewBgView.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"]:@"";
    NSString *playerID = [[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"player_id"]:@"";
    
    [self makePostCallForPageNEWNoProgess:PAGE_REGISTER_TOKEN withParams:@{@"device_token":deviceToken,@"player_id":playerID,@"dev_type":@"ios",@"type":@"parent",@"member_id":[Utils loggedInUserIdStr]}
                          withRequestCode:1001];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [locationManager requestWhenInUseAuthorization];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==1001){
        NSLog(@"Push Register%@",result);
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
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

    if(indexPath.row==0){
        TrackListVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TrackListVC"];
        [self PushToVc:vc];
    }
    else  if(indexPath.row==1){
        SubScriptionList *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"SubScriptionList"];
        [self PushToVc:vc];
    } else  if(indexPath.row==3){
//        [Utils logoutUser];
//        [APP_DELEGATE afterLoginLogOut];
        MyAccountVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"MyAccountVC"];
        [self PushToVc:vc];
    }
    else{
//    TarrifsVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TarrifsVC"];
//    [self PushToVc:vc];
        LunchBoxListVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"LunchBoxListVC"];
        [self PushToVc:vc];
    }
    }else{
        NSDictionary *dict = [offersList objectAtIndex:indexPath.row];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"offer_url"]]]];

    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        return CGSizeMake((CGRectGetWidth(collectionView.frame)/2)-16, (CGRectGetHeight(collectionView.frame)/2)-16);
 
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

- (IBAction)poweredbyBtnAction:(id)sender;
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",@"https://www.develappsolutions.com"]]];
}
@end
