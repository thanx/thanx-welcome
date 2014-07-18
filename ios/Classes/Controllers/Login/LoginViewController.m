//
//  LoginViewController.m
//  ThanxWelcome
//
//  Created by Marc Fernandez on 5/9/14.
//  Copyright (c) 2014 Thanx. All rights reserved.
//

#import "LoginViewController.h"
#import "THXAuth.h"

@interface LoginViewController ()

- (IBAction)submitButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.emailTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark IBAction Methods
- (IBAction)submitButtonClick:(id)sender {
  NSString * email = self.emailTextField.text;
  NSString * password = self.passwordTextField.text;
  if (email.length > 0 && password.length > 0) {
    [THXAuth.sharedInstance loginWithAccount:email andPassword:password];
  }
}

#pragma mark - UITextViewDelegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [textField becomeFirstResponder];
}

@end
