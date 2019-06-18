//
//  OfferDetailVC.m
//  SchoolAuto
//
//  Created by Apple on 18/06/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "OfferDetailVC.h"

@interface OfferDetailVC ()

@end

@implementation OfferDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.offerImage setImageWithURL:[self.offerDetials valueForKey:@"offer_image"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
