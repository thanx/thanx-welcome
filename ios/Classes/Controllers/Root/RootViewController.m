//
//  RootViewController.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 7/17/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "RootViewController.h"

#import "LoginViewController.h"
#import "MainViewController.h"

@implementation RootViewController

+ (RootViewController *)sharedInstance {
  static RootViewController * _sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[self alloc] init];
  });
  
  return _sharedInstance;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  UIViewController * firstController = nil;
  if(THXAuth.sharedInstance.isUserAuthenticated) {
    firstController = [[MainViewController alloc] init];
  } else {
    firstController = [[LoginViewController alloc] init];
  }
  
  [self addViewController:firstController];
  
}

- (void)handleLogin {
  [self removeCurrentViewController];
  
  MainViewController *mainView = [[MainViewController alloc] init];
  [self addViewController:mainView];
}

- (void)handleLogout {
  [self removeCurrentViewController];
  
  LoginViewController *loginView = [[LoginViewController alloc] init];
  [self addViewController:loginView];
}

#pragma mark - Private Instance Methods

- (void) addViewController:(UIViewController *)viewController {
  [self addChildViewController:viewController];
  [self.view addSubview:viewController.view];
  self.currentController = viewController;
}

- (void) removeCurrentViewController {
  [self.currentController.view removeFromSuperview];
  [self.currentController removeFromParentViewController];
  self.currentController = nil;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
