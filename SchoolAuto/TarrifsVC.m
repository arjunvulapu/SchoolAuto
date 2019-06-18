//
//  TarrifsVC.m
//  SchoolAuto
//
//  Created by Apple on 10/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "TarrifsVC.h"
#import "PriceTC.h"
#import "PlanTC.h"
#import "AdsCC.h"
#import "AddChildVC.h"
#import "AddLunchBoxVC.h"
@interface TarrifsVC ()
{
    NSMutableDictionary *resultDict;
    NSMutableArray *pricesList;
    NSMutableArray *plansList;
    NSMutableArray *offersList;

}
@end

@implementation TarrifsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [currentDefaults objectForKey:@"BANNERS"];
    NSDictionary *bannersDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    offersList =[bannersDict valueForKey:@"offers"];
    resultDict=[[NSMutableDictionary alloc] init];
    pricesList=[[NSMutableArray alloc] init];
    plansList=[[NSMutableArray alloc] init];

    self.title = @"TARRIFS";
    // Do any additional setup after loading the view.
    _pricesTableView.layer.cornerRadius=10.0;
    _pricesTableView.clipsToBounds=YES;
    
    _plansTableView.layer.cornerRadius=10.0;
    _plansTableView.clipsToBounds=YES;
    [self makePostCallForPageNEWGET:TARRIFS withParams:nil withRequestCode:200];
    
    _addChildBtn.layer.cornerRadius=10;
    _addChildBtn.clipsToBounds=YES;
    
    _addLunchBoxBtn.layer.cornerRadius=10;
    _addLunchBoxBtn.clipsToBounds=YES;
}
-(void)parseResult:(id)result withCode:(int)reqeustCode{
    if(reqeustCode==200){
        
        resultDict=result;
        NSLog(@"%@",resultDict);
        pricesList=[resultDict valueForKey:@"subscription_prices"];
        plansList=[resultDict valueForKey:@"subscription_plans"];
        [_plansTableView reloadData];
        [_pricesTableView reloadData];
    }
}
-(void)viewWillAppear:(BOOL)animated{
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == _pricesTableView){
        
    return pricesList.count+1;
    }else{
        return plansList.count+1;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _pricesTableView){
        if(indexPath.row==0){
            static NSString *MyIdentifier = @"FirstHeader";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            //        [cell.menuImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[menuImagesList objectAtIndex:indexPath.row]]]];
            //        cell.menuTitle.text = [NSString stringWithFormat:@"%@",[menuList objectAtIndex:indexPath.row]];
            return cell;
        }else{
        
    static NSString *MyIdentifier = @"PriceTC";
            
    PriceTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            NSDictionary *dict =[pricesList objectAtIndex:indexPath.row-1];
            cell.sharingTypeLbl.text=[NSString stringWithFormat:@"%@ Sharing",[dict valueForKey:@"count"]];
            
            cell.minChargeLbl.text=[NSString stringWithFormat:@"%@/-",[dict valueForKey:@"min_price"]];
            cell.upto5kmLbl.text=[NSString stringWithFormat:@"%@/-",[[[dict valueForKey:@"prices"] objectAtIndex:1] valueForKey:@"price"]];
            cell.upto6kmLbl.text=[NSString stringWithFormat:@"%@/-",[[[dict valueForKey:@"prices"] objectAtIndex:2] valueForKey:@"price"]];
            cell.upto7kmLbl.text=[NSString stringWithFormat:@"%@/-",[[[dict valueForKey:@"prices"] objectAtIndex:3] valueForKey:@"price"]];

    return cell;
        }
    }else{
        if(indexPath.row==0){
            static NSString *MyIdentifier = @"SecondHeader";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            //        [cell.menuImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[menuImagesList objectAtIndex:indexPath.row]]]];
            //        cell.menuTitle.text = [NSString stringWithFormat:@"%@",[menuList objectAtIndex:indexPath.row]];
            return cell;
        }else{
            
            static NSString *MyIdentifier = @"PlanTC";
            
            PlanTC *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            NSDictionary *dict =[plansList objectAtIndex:indexPath.row-1];

            cell.snoLbl.text=[NSString stringWithFormat:@"%ld",indexPath.row];
            cell.durationLbl.text=[NSString stringWithFormat:@"%@ Days",[dict valueForKey:@"duration"]];
            cell.discountlbl.text=[NSString stringWithFormat:@"%@%@ Rebate on Actual Prices",[dict valueForKey:@"discount_application"],@"%"];
            return cell;
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(tableView==_pricesTableView){
    _priceTableHeight.constant = _pricesTableView.contentSize.height;
    }else{
        _planTableViewheight.constant=_plansTableView.contentSize.height;
    }

}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

        return offersList.count;
        
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
          _adsCollectionViewHeight.constant=_adsCollectionView.contentSize.height;
        AdsCC *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdsCC" forIndexPath:indexPath];
        ccell.adsImage.layer.cornerRadius=10;
        ccell.adsImage.clipsToBounds=YES;
       // ccell.adsImage.image=[UIImage imageNamed:@"add"];
    NSDictionary *dict = [offersList objectAtIndex:indexPath.row];
    [ccell.adsImage setImageWithURL:[dict valueForKey:@"offer_image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        return ccell;
        
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    TarrifsVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"TarrifsVC"];
    [self PushToVc:vc];
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
- (IBAction)addchildBtnAction:(id)sender {
    AddChildVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AddChildVC"];
    [self PushToVc:vc];
    
}
- (IBAction)addLunchBoxBtnAction:(id)sender {
    AddLunchBoxVC *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"AddLunchBoxVC"];
    [self PushToVc:vc];
}
@end
