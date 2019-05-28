//
//  Common.h
//  Cavaratmall
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#ifndef Cavaratmall_Common_h
#define Cavaratmall_Common_h

#import "AppDelegate.h"

#define KEY_LANGUAGE_EN @"en"
//#define KEY_LANGUAGE_AR @"ar"


#define LAST_CLOSED_TIME @"LAST_CLOSED_TIME"

#define THEME_COLOR [UIColor colorWithRed:14/255.0f green:76/255.0f blue:120/255.0f alpha:1];
#define BUTTON_BG_COLOR [UIColor whiteColor];
#define PROJECT_GRAY [UIColor colorWithRed:233.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1];

#define PLACEHOLDER_COLOR [UIColor grayColor];

#define Localized(string) [MCLocalization stringForKey:string]

#define APP_DELEGATE (AppDelegate *) [[UIApplication sharedApplication] delegate]


//#define SERVER_URL @"http://products.yellowsoft.in/homeworkers/api/"
#define SERVER_URL @"http://projects.yellowsoft.in/schoolauto/api"

#define LOGIN @"parents/login.php"
#define REGISTER @"parents/register.php"
#define FORGOTPASSWORD @"parents/forgotpassword.php"
#define TARRIFS @"parents/subscription_prices.php"
#define SCHOOLSLIST @"schools/register.php"
#define PACKAGESLIST @"autos/register.php"
#define SAHRING_OPTIONS @"parents/sharing_options.php"
#define ADDSUBSCRIPTIONS @"parents/subscriptions.php"
#define CHANGE_PASSWORD @"parents/change_password.php"
//#define SUBSCRIPTIONSLIST @"parents/subscriptions.php"
#define BANNERS @"banners-offers/register.php"

#define AUTOLOGIN @"autos/login.php"
#define TRIPSLIST @"trips/register.php"

#define AUTOINFO @"autos/register.php"
#define UPDATEAUTOINFO @"autos/auto_location.php"
#define GETAUTOINFO @"autos/status_list.php"
#define STATUSLIST @"autos/status_list.php"

#define TRIP_STATUS @"dailytrips/register.php"
#define GETTRIPSTATUS @"kid-daily-trips/register.php"
#define TRIP_EXIST_MESSAGES @"dts_status/register.php"


#define UICOLOR_FROM_HEX_ALPHA(RGBValue, Alpha) [UIColor \
colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0xFF00) >> 8))/255.0 \
blue:((float)(RGBValue & 0xFF))/255.0 alpha:Alpha]
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif
