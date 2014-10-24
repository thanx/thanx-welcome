//
//  AppDelegate.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) LoginViewController *loginViewController;
@property (strong, nonatomic) THXBeaconManager *beaconManager;

- (void)updateRootViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];

  [self.window setRootViewController:self.currentViewController];

  // Listen to notification of user removing email
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRootViewController) name:UserDidRemoveEmail object:nil];
  
  self.beaconManager = [[THXBeaconManager alloc] init];
  [application setStatusBarStyle:UIStatusBarStyleLightContent];

  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Setting View Controller Methods
- (void)updateRootViewController {
  [UIView transitionWithView:self.window
                    duration:0.5
                     options:UIViewAnimationOptionTransitionCrossDissolve
                  animations:^{ [self.window setRootViewController:self.currentViewController]; }
                  completion:nil];;
}

- (UIViewController *)currentViewController
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *email = [defaults valueForKey:@"email"];
  
  if (!email) {
    self.loginViewController = [[LoginViewController alloc] init];
    return self.loginViewController;
  }
  else {
    self.mainViewController = [[MainViewController alloc] init];
    return self.mainViewController;
  }
}

@end
