//
//  IntroductionViewController.m
//  Gifts
//
//  Created by apple on 09/05/17.
//  Copyright © 2017 apple. All rights reserved.
//



#import "IntroductionViewController.h"
#import "HomeViewController.h"
#import "Utils.h"
#import "Common.h"
@interface IntroductionViewController ()
{
    NSMutableArray *imagesList;
    NSMutableArray *titles;
    NSMutableArray *disc;
    NSInteger index ;

}
@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index =0;

    // Do any additional setup after loading the view, typically from a nib.
    titles=[NSMutableArray arrayWithObjects:@"Get Latest trends! ",@"Shop Simple",@"Add to Wishlist",@"", nil];
    imagesList=[NSMutableArray arrayWithObjects:@"sli1",@"sli2",@"sli3", nil];
    disc=[NSMutableArray arrayWithObjects:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ornare sapien no.",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ornare sapien no.",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ornare sapien no.",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ornare sapien no.", nil];
  //  [_imagev setImage:[UIImage imageNamed:[imagesList objectAtIndex:0]]];

    
    [_imagev setUserInteractionEnabled:YES];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imagev addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_imagev addGestureRecognizer:swipeRight];
    //_startshopingBtn.hidden=YES;
    _lastView.hidden=YES;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [negativeSpacer setWidth:-10];
    UIButton *filter = [UIButton buttonWithType:UIButtonTypeCustom];
    [filter setTitle:@"Skip" forState:UIControlStateNormal];
    [filter addTarget:self action:@selector(startShopingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    // [viewButtons addSubview:buttonUser];
    
    
    filter.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *customBarRightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:filter];
    
    
    //self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn1,nil];
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.signUpbackgroundImg.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.signUpbackgroundImg.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.signUpbackgroundImg addSubview:blurEffectView];
    } else {
        self.signUpbackgroundImg.backgroundColor = [UIColor blackColor];
    }
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
        self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.view.backgroundColor = [UIColor clearColor];
        
        UIButton *buttonUser = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([[Utils getLanguage] isEqualToString:KEY_LANGUAGE_EN]) {
            
            [buttonUser setImage:[UIImage imageNamed:@"left-arrow"] forState:UIControlStateNormal];
        }else{
            [buttonUser setImage:[UIImage imageNamed:@"right-arrow"] forState:UIControlStateNormal];
            
        }
        [buttonUser addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // [viewButtons addSubview:buttonUser];
        
        buttonUser.frame = CGRectMake(0, 0, 20, 20);
        //buttonUser.titleLabel.font = [UIFont systemFontOfSize:10.0];
        UIBarButtonItem *customBarRightBtn = [[UIBarButtonItem alloc] initWithCustomView:buttonUser];
        [negativeSpacer setWidth:-10];
        
      //  self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,customBarRightBtn,nil];
        
    }
    -(void)back
    {
        [self.navigationController popViewControllerAnimated:YES];
    }



-(void)swipeImage:(UISwipeGestureRecognizer*)recognizer
{
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        index++;
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        index--;
    }
    
    if (index > 0 || index < ([imagesList count]-1))
    {
        if(index <3){
        if(index==2 ){
            _firstView.hidden=YES;
            _lastView.hidden=NO;
            _lastView.alpha=1;
            _startshopingBtn.hidden=NO;
        }else{
            _firstView.hidden=YES;
            _lastView.hidden=YES;
            _lastView.alpha=0;
           // _startshopingBtn.hidden=YES;
            _startshopingBtn.hidden=NO;

        }
        [UIView transitionWithView:_imagev
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:^{
                            [_imagev setImage:[UIImage imageNamed:[imagesList objectAtIndex:index]]];
                           
                            
                        } completion:nil];
        }else{
            [APP_DELEGATE RefreshUI];
        }
    }
    else
    {
        NSLog(@"Reached the end, swipe in opposite direction");
        [APP_DELEGATE RefreshUI];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pageAction:(id)sender {
    
    [_imagev setImage:[UIImage imageNamed:[imagesList objectAtIndex:index]]];
}
- (IBAction)skipAction:(id)sender {
    //NSInteger index = _pagec.currentPage;
    
    
    index++;
    
    
    if (index > 0 || index < ([imagesList count]))
    {
        //_pagec.currentPage = index;
        [UIView transitionWithView:_imagev
                          duration:2.0f
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:^{
                            [_imagev setImage:[UIImage imageNamed:[imagesList objectAtIndex:index]]];
                          
                            
                        } completion:nil];
    }
    else
    {
        NSLog(@"Reached the end, swipe in opposite direction");
    }
    
    
}
- (IBAction)startShopingBtnAction:(id)sender {
   // NSInteger index = _pagec.currentPage;
    
    
    index++;
    
    
    if (index > 0 && index < ([imagesList count]))
    {
//        _pagec.currentPage = index;
        [UIView transitionWithView:_imagev
                          duration:2.0f
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:^{
                            [_imagev setImage:[UIImage imageNamed:[imagesList objectAtIndex:index]]];
                           
                            
                        } completion:nil];
    }
    else
    {
//                TabbarViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
//                [self.navigationController pushViewController:newView animated:YES];
        [APP_DELEGATE RefreshUI];
    }
}
@end
