//
//  AppDelegate.m
//  WKPCB
//
//  Created by wulanzhou-mini on 15-2-4.
//  Copyright (c) 2015年 wulanzhou-mini. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "SlideNavigationController.h"
#import "MainViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
#import "WXApi.h"
#import "ShareManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [[UINavigationBar appearance] setTintColor:kWNavTitleColor];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    //项目->Edit scheme   -> options  -> application  language  -> 里面就有 system language  和自定义的语言环境 ，切换这里就哦了~~
    //分享注册
    [[ShareManager shareInstance] registerShare];
    
    LeftMenuViewController *leftMenu = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController" bundle:nil];
    //RightMenuViewController *rightMenu = [[RightMenuViewController alloc] initWithNibName:@"RightMenuViewController" bundle:nil];
    MainViewController *main=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    SlideNavigationController *nav=[[SlideNavigationController alloc] initWithRootViewController:main];

    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    /***
    [SlideNavigationController sharedInstance].rightMenu = rightMenu;
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"top_navigation_infoicon.png"] forState:UIControlStateNormal];
    [button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
     ***/
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    
    
     
    return YES;
    /***
    //资料来源网站
    //http://www.hw-tech.net/
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
     self.window.backgroundColor=UIColorMakeRGB(28, 28, 28);
    
    WTALeftViewController *leftViewController = [WTALeftViewController new];
    WTAZoomNavigationController *zoomNavigationController = [[WTAZoomNavigationController alloc] initWithZoomFactor:200.0f];
    [zoomNavigationController setSpringAnimationOn:YES];
    [zoomNavigationController setLeftViewController:leftViewController];
    
    
    
    [[self window] setRootViewController:zoomNavigationController];
    
    [self.window makeKeyAndVisible];
    return YES;
     ***/
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
}
@end
