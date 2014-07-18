//
//  MainViewController.m
//  ThanxWelcome
//
//  Created by THOMAS CHEN on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "MainViewController.h"
#import "THXAuth.h"

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction Methods

- (IBAction)logoutButtonClick:(id)sender {
  [THXAuth.sharedInstance logout];
}

@end
