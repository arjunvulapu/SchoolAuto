//
//  AppDelegate.m
//  SchoolAuto
//
//  Created by Apple on 03/05/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "Utils.h"
#import "Common.h"
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Utils.h"
#import "Common.h"
#import <OneSignal/OneSignal.h>

@implementation UILabel (Helper)

- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    // NSLog(@"%@",name);
    //NSLog(@"%@-%@",self.font.fontName,self.font.fontDescriptor.fontAttributes);
    if(isBold(self.font.fontDescriptor)){
        //  NSString *str =[NSString stringWithFormat:@"%@-Bold",name];
        self.font = [UIFont fontWithName:@"Lato-Black" size:self.font.pointSize];
        
    }else{
        self.font = [UIFont fontWithName:@"Lato-Regular" size:self.font.pointSize];
    }
    
}
BOOL isBold(UIFontDescriptor * fontDescriptor)
{
    return (fontDescriptor.symbolicTraits & UIFontDescriptorTraitBold) != 0;
}

@end
@implementation UITextView (Helper)
- (void)setSubstituteFontName:(NSString *)name UI_APPEARANCE_SELECTOR {
    // NSLog(@"%@",name);
    self.font = [UIFont fontWithName:name size:self.font.pointSize];
    
}
@end
@interface AppDelegate ()<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    UIApplication *app;
    int requestCode;

}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self downloadBanners];
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:@"a9eb3689-17ab-4d68-8275-2b9119f7ce4c"
            handleNotificationAction:nil
                            settings:@{kOSSettingsKeyAutoPrompt: @false}];
    OneSignal.inFocusDisplayType = OSNotificationDisplayTypeNotification;
    
    // Recommend moving the below line to prompt for push after informing the user about
    //   how your app will use them.
    [OneSignal promptForPushNotificationsWithUserResponse:^(BOOL accepted) {
        NSLog(@"User accepted notifications: %d", accepted);
    }];
    [OneSignal addSubscriptionObserver:self];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
   
    
    [self->locationManager requestAlwaysAuthorization];

    if ([self->locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self->locationManager requestAlwaysAuthorization];
        
    }
    [self->locationManager requestWhenInUseAuthorization];
    if ([self->locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self->locationManager requestWhenInUseAuthorization];
    }
    UIAlertView * alert;

    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied) {
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else if ([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted) {
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        
        // When there is a significant changes of the location,
        // The key UIApplicationLaunchOptionsLocationKey will be returned from didFinishLaunchingWithOptions
        // When the app is receiving the key, it must reinitiate the locationManager and get
        // the latest location updates
        
        // This UIApplicationLaunchOptionsLocationKey key enables the location update even when
        // the app has been killed/terminated (Not in th background) by iOS or the user.
        
        NSLog(@"UIApplicationLaunchOptionsLocationKey : %@" , [launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]);
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
            
            // This "afterResume" flag is just to show that he receiving location updates
            // are actually from the key "UIApplicationLaunchOptionsLocationKey"
            [locationManager startUpdatingLocation];
            
        }
    }
    if([Utils loggedInUserId] != -1){
        if([[Utils loggedInUserType]  isEqual: @"Driver"]||[[Utils loggedInUserType]  isEqual: @"Lunchbox"]){
            [self afterDriverLoginSucess];
            //create new CLLocationManager
           
        }else{
            [self afterLoginSucess];
        }
    }else{
        [self afterLoginLogOut];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//}


//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//}

- (void)onOSPermissionChanged:(OSPermissionStateChanges*)stateChanges {
    
    // Example of detecting anwsering the permission prompt
    if (stateChanges.from.status == OSNotificationPermissionNotDetermined) {
        if (stateChanges.to.status == OSNotificationPermissionAuthorized)
            NSLog(@"Thanks for accepting notifications!");
        else if (stateChanges.to.status == OSNotificationPermissionDenied)
            NSLog(@"Notifications not accepted. You can turn them on later under your iOS settings.");
    }
    
    // prints out all properties
    NSLog(@"PermissionStateChanges:\n%@", stateChanges);
}
- (void)onOSSubscriptionChanged:(OSSubscriptionStateChanges*)stateChanges {
    
    // Example of detecting subscribing to OneSignal
    if (!stateChanges.from.subscribed && stateChanges.to.subscribed) {
        NSLog(@"Subscribed for OneSignal push notifications!");
        // get player ID
        
        NSLog(@"player_id     -----> %@\n", stateChanges.to.userId);
        [[NSUserDefaults standardUserDefaults] setValue:stateChanges.to.userId forKey:@"player_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // prints out all properties
    NSLog(@"SubscriptionStateChanges:\n%@", stateChanges);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)afterLoginSucess {
    locationManager.allowsBackgroundLocationUpdates=NO;
    [locationManager stopUpdatingLocation];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    
}
- (void)afterDriverLoginSucess {
    locationManager.allowsBackgroundLocationUpdates=YES;
    [locationManager startUpdatingLocation];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"DriverMainViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
}
- (void)afterLoginLogOut {
    locationManager.allowsBackgroundLocationUpdates=NO;
    [locationManager stopUpdatingLocation];
//    [locationManager stopUpdatingLocation];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
}

//starts when the application switches to the background
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [locationManager startUpdatingLocation];
    
}

//starts automatically with locationManager
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
  //  NSLog(@"Location: %f, %f", newLocation.coordinate.longitude, newLocation.coordinate.latitude);
    if([Utils loggedInUserId] != -1){
        if([[Utils loggedInUserType]  isEqual: @"Driver"]||[[Utils loggedInUserType]  isEqual: @"Lunchbox"]){
            [self updateToServer:newLocation.coordinate.latitude withlong:newLocation.coordinate.longitude];
        }
}
}
-(void)updateToServer:(CGFloat)lat withlong:(CGFloat)lng{
        [self makePostCallForPageNEW:UPDATEAUTOINFO withParams:@{@"auto_id":[NSString stringWithFormat:@"%@",[Utils loggedInUserIdStr]],@"latitude":[NSString stringWithFormat:@"%f",lat],@"longitude":[NSString stringWithFormat:@"%f",lng]} withRequestCode:110];
        
    }
- (void) makePostCallForPageNEW:(NSString *)page
                     withParams:(NSDictionary *)params
                withRequestCode:(int)code {
    
    if (![Utils isOnline]) {
        [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"internet_error"]];
        return;
    }
    
    requestCode = code;
    
   // [self performSelectorOnMainThread:@selector(showHUD:) withObject:nil waitUntilDone:YES];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:params];
    //    [dictionary setValue:[[MCLocalization sharedInstance] language] forKey:@"lang"];
    //    [dictionary setValue:@"iPhone" forKey:@"device_type"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:[Utils createURLForPage:page] parameters:dictionary progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self parseResult:responseObject withCode:requestCode];
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) parseResult:(id) result withCode:(int)reqeustCode {
   // NSLog(@"%@",result);
    if(reqeustCode==10)
    {
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:result];
        [currentDefaults setObject:data forKey:@"BANNERS"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//starts when application switches back from background
- (void)applicationWillEnterForeground:(UIApplication *)application
{
  //  [locationManager stopUpdatingLocation];
}
-(void)getBanners{
    [self makePostCallForPageNEWGET:BANNERS withParams:nil withRequestCode:10];
}
- (void) makePostCallForPageNEWGET:(NSString *)page
                        withParams:(NSDictionary *)params
                   withRequestCode:(int)code {
    
    if (![Utils isOnline]) {
        [Utils showErrorAlertWithMessage:[MCLocalization stringForKey:@"internet_error"]];
        return;
    }
    
    requestCode = code;
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:params];
    //    [dictionary setValue:[[MCLocalization sharedInstance] language] forKey:@"lang"];
    //    [dictionary setValue:@"iPhone" forKey:@"device_type"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[[Utils createURLForPage:page withParameters:dictionary] absoluteString] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self parseResult:responseObject withCode:requestCode];
        dispatch_async(dispatch_get_main_queue(), ^{
           
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)downloadBanners {
    NSData *data2 = [NSData dataWithContentsOfURL:[Utils createURLForPage:BANNERS withParameters:@{}]];
    if(data2){
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dictionary);
//        [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:@"BANNERS"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
        [currentDefaults setObject:data forKey:@"BANNERS"];
        NSData *data2 = [currentDefaults objectForKey:@"BANNERS"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
        NSLog(@"1010101--->dict%@",dict);
    }
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    NSString* strDeviceToken = [[[[deviceToken description]
                                  stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                                stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"Device_Token     -----> %@\n", strDeviceToken);
    [[NSUserDefaults standardUserDefaults] setValue:strDeviceToken forKey:@"TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
