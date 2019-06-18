//
//  AppDelegate.h
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)afterLoginSucess;
- (void)afterLoginLogOut;
- (void)afterDriverLoginSucess;
-(void)setIntialViewController;
@property (strong, nonatomic) NSString *fromPushNotification;
@property (strong, nonatomic) NSDictionary *pushDict;
- (void)RefreshUI;
@end

