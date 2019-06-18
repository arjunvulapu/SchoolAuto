//
//  IntroductionViewController.h
//  Gifts
//
//  Created by apple on 09/05/17.
//  Copyright © 2017 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIPageControl *pagec;
- (IBAction)pageAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imagev;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *lastView;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UIButton *SkipBtnAction;
- (IBAction)skipAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startshopingBtn;
- (IBAction)startShopingBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *signUpbackgroundImg;


@end
