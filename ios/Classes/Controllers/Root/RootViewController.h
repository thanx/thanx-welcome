//
//  RootViewController.h
//  ThanxWelcome
//
//  Created by Marc Fernandez on 7/17/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (strong, nonatomic) UIViewController * currentController;

+ (RootViewController *)sharedInstance;

- (void)handleLogin;

- (void)handleLogout;

@end
