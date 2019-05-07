//
//  Utils.h
//  MyShop
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Apple. All rights reserved..
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "MCLocalization.h"
@class User;

@interface Utils : NSObject

+ (id)getViewControllerWithId:(NSString *)vcId;
+ (void) showErrorAlertWithMessage:(NSString *) message;
+ (void) showAlertWithMessage:(NSString *) message;
+ (NSURL *) createURLForPage:(NSString *)page withParameters:(NSDictionary *) params;
+ (BOOL)isOnline;
+ (NSDate *)getDateFromTimestamp:(NSString *)timestamp;
+ (NSString *)createURLForPage:(NSString *) page;
+ (NSString *)getParameterListFromDisctionary:(NSDictionary *)params;
+ (void)logoutUser;
+ (void)loginUserWithMemberId:(NSString *)memberId;
+ (int)loggedInUserId;
+ (NSString *)loggedInUserType;
+ (void)setLanguage:(NSString *)language;
+ (NSString *)getLanguage;
//+ (void)loginWithUser:(User *)user;
+ (NSTextAlignment) getAlignment;
+ (NSString *)getCurrentPackage;
+ (void)packagePurchased:(NSString *)packageId ;
+ (void)updateQBId:(NSInteger)qbId;
+ (NSInteger)getQBId;
+ (BOOL)isiPad;
+ (CGSize)getSizeForText:(NSString *)text maxWidth:(CGFloat)width font:(UIFont *)font;
+ (NSString *)loggedInUserIdStr;
+ (BOOL)isCountrySelected;
+ (void) setCountry:(NSString *)name withId:(NSString *)cId;
+ (NSString *)getSelectedCountry;
+ (NSString *)loggedInIsPresent;
+ (void)loginUserWithMemberId:(NSString *)memberId withType:(NSString *)type;

+ (NSString *)getSelectedCountryName;
+ (NSString *)getHTMLString:(NSString *)string;
+ (BOOL) isValidEmail:(NSString *)email;
@end
