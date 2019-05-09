//
//  BaseViewController.h
//  StreetWhere
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved.//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "Utils.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "GiFHUD.h"
#import "JVFloatLabeledTextField.h"
//#import "HRMSystem/HRMSystem-Swift.h"

@interface BaseViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {
    int requestCode;
    
}
-(void) restrictRotation:(BOOL) restriction;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL dismissProgress;
- (void) makePostCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
             withRequestCode:(int)code;
- (void) makePostWithOutHUDCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
             withRequestCode:(int)code;

- (void) makeGetCallForPage:(NSString *)page
                 withParams:(NSDictionary *)params
            withRequestCode:(int)code;

- (void) makePostCallForPage:(NSString *)page
                  withParams:(NSDictionary *)params
                withCallback:(void (^)(id))resultCallback;
-(void)animation:(UIButton *)buttonUser2;
- (void) parseResult:(id) result withCode:(int)reqeustCode;
- (void) showErrorAlertWithMessage:(NSString *)message;
- (void) showSuccessMessage:(NSString *)message;
-(void)toastMessage:(NSString*)message;
-(UITextField *)addBottomBoreder:(UITextField *)textField;
- (void) showHUD:(NSString *)labelText;
- (void) hideHUD;
- (void)refreshItems;
- (void)showSideMenu;
-(void)addPushAnimation;
-(void)addPopAnimation;
-(NSMutableAttributedString*)addblackShadowToLabel:(NSString *)str;
-(UIView*)addborderAndRoundRectTo:(UIView*)view;
-(NSAttributedString *)base64ToDecoding:(NSString *)str;
-(void)deleteHistory;
-(void)addtolayerTO:(UIButton *)button;
- (BOOL)validateEmailWithString:(NSString*)email;

-(void)addbackground:(UIView*)view;

-(void)addcellAnimation:(UITableViewCell*)cell;
- (void) popVC;
-(void) cornerRadiusFor:(UIView *)view;
-(void) cornerRadiusForB:(UIButton *)view;
- (void) PushToVc:(UIViewController *)vc;
@end
